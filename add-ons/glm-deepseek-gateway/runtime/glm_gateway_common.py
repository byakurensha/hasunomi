from __future__ import annotations

import json
import os
import signal
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Any, Dict


HOME = Path.home()
SHARE = HOME / ".local/share/glm-gateway"
CONFIG_DIR = HOME / ".config/glm-gateway"
CONFIG_FILE = CONFIG_DIR / "config.json"
RUNTIME = SHARE / "runtime"
LOG_DIR = SHARE / "logs"
PID_FILE = LOG_DIR / "gateway.pid"
LOG_FILE = LOG_DIR / "gateway.log"
SERVER = RUNTIME / "glm-gateway-server"
WRAPPER = RUNTIME / "glm-gateway-wrapper"
USER_DATA = SHARE / "vscode-user-data"
EXTENSIONS = SHARE / "vscode-extensions"


class GatewayError(RuntimeError):
    pass


def read_config() -> Dict[str, Any]:
    if not CONFIG_FILE.is_file():
        raise GatewayError(f"configuration is missing: {CONFIG_FILE}")
    value = json.loads(CONFIG_FILE.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise GatewayError("configuration must be a JSON object")
    return value


KEY_SPECS = {
    "zai": ("ZAI_API_KEY", "zai_key_file", "zai.env"),
    "openrouter": ("OPENROUTER_API_KEY", "openrouter_key_file", "openrouter.env"),
    "deepseek": ("DEEPSEEK_API_KEY", "deepseek_key_file", "deepseek.env"),
}


def key_path(config: Dict[str, Any], provider: str) -> Path:
    try:
        _env_name, config_name, filename = KEY_SPECS[provider]
    except KeyError as error:
        raise GatewayError(f"unsupported key provider: {provider}") from error
    return Path(str(config.get(config_name) or CONFIG_DIR / filename)).expanduser()


def load_key(config: Dict[str, Any], provider: str) -> str:
    env_name, _config_name, _filename = KEY_SPECS[provider]
    path = key_path(config, provider)
    if not path.is_file():
        raise GatewayError(
            f"{provider} API key is missing; run: {HOME}/bin/glm-gateway key {provider}"
        )
    for line in path.read_text(encoding="utf-8").splitlines():
        if line.startswith(f"{env_name}="):
            value = line.split("=", 1)[1].strip().strip("\"'")
            if value:
                return value
    raise GatewayError(f"{env_name} is missing from {path}")


def gateway_url(config: Dict[str, Any], path: str = "/health") -> str:
    return f"http://127.0.0.1:{int(config.get('port', 8794))}{path}"


def get_health(config: Dict[str, Any]) -> Dict[str, Any]:
    try:
        with urllib.request.urlopen(gateway_url(config), timeout=2) as response:
            value = json.loads(response.read().decode())
    except Exception:
        return {}
    return value if isinstance(value, dict) else {}


def health_matches(config: Dict[str, Any]) -> bool:
    health = get_health(config)
    return all(
        (
            health.get("ok") is True,
            health.get("mode") == "dynamic",
            health.get("vision_model") == config.get("vision_model"),
            health.get("routing") == "vision-analysis-then-text",
        )
    )


def _read_pid() -> int:
    try:
        return int(PID_FILE.read_text(encoding="utf-8").strip())
    except (FileNotFoundError, ValueError):
        return 0


def _pid_is_gateway(pid: int) -> bool:
    if pid <= 1:
        return False
    try:
        result = subprocess.run(
            ["ps", "-p", str(pid), "-o", "command="],
            check=False,
            capture_output=True,
            text=True,
        )
    except OSError:
        return False
    return result.returncode == 0 and "glm-gateway-server" in result.stdout


def stop_gateway() -> None:
    pid = _read_pid()
    if _pid_is_gateway(pid):
        try:
            os.kill(pid, signal.SIGTERM)
        except ProcessLookupError:
            pass
        for _ in range(30):
            try:
                os.kill(pid, 0)
            except ProcessLookupError:
                break
            time.sleep(0.1)
        else:
            try:
                os.kill(pid, signal.SIGKILL)
            except ProcessLookupError:
                pass
    PID_FILE.unlink(missing_ok=True)


def server_environment(config: Dict[str, Any]) -> Dict[str, str]:
    environment = os.environ.copy()
    environment.update(
        {
            "GLM_GATEWAY_ZAI_KEY_FILE": str(key_path(config, "zai")),
            "GLM_GATEWAY_OPENROUTER_KEY_FILE": str(key_path(config, "openrouter")),
            "GLM_GATEWAY_DEEPSEEK_KEY_FILE": str(key_path(config, "deepseek")),
            "GLM_GATEWAY_TEXT_MODEL": str(config.get("text_model", "glm-5.2")),
            "GLM_GATEWAY_OPENROUTER_MODEL": str(
                config.get("openrouter_model", "deepseek/deepseek-v4-pro")
            ),
            "GLM_GATEWAY_DEEPSEEK_MODEL": str(
                config.get("deepseek_model", "deepseek-v4-pro")
            ),
            "GLM_GATEWAY_VISION_MODEL": str(config.get("vision_model", "glm-4.6v")),
            "GLM_GATEWAY_ZAI_ANTHROPIC_URL": str(config.get("zai_anthropic_url")),
            "GLM_GATEWAY_OPENROUTER_ANTHROPIC_URL": str(
                config.get("openrouter_anthropic_url")
            ),
            "GLM_GATEWAY_DEEPSEEK_ANTHROPIC_URL": str(
                config.get("deepseek_anthropic_url")
            ),
            "GLM_GATEWAY_VISION_URL": str(config.get("vision_url")),
            "GLM_GATEWAY_PORT": str(int(config.get("port", 8794))),
        }
    )
    environment.pop("ZAI_API_KEY", None)
    environment.pop("OPENROUTER_API_KEY", None)
    environment.pop("DEEPSEEK_API_KEY", None)
    return environment


def ensure_gateway(config: Dict[str, Any]) -> None:
    if not any(key_path(config, provider).is_file() for provider in KEY_SPECS):
        raise GatewayError(
            "no API key is configured; run glm-gateway key zai, "
            "glm-gateway key openrouter, or glm-gateway key deepseek"
        )
    if health_matches(config):
        return
    if get_health(config):
        raise GatewayError(
            f"port {config.get('port', 8794)} is used by a different service"
        )
    stop_gateway()
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    with LOG_FILE.open("ab") as log:
        process = subprocess.Popen(
            [sys.executable, str(SERVER)],
            stdin=subprocess.DEVNULL,
            stdout=log,
            stderr=subprocess.STDOUT,
            env=server_environment(config),
            start_new_session=True,
        )
    PID_FILE.write_text(f"{process.pid}\n", encoding="utf-8")
    for _ in range(60):
        if health_matches(config):
            return
        if process.poll() is not None:
            break
        time.sleep(0.25)
    raise GatewayError(f"gateway failed to start; inspect {LOG_FILE}")


def claude_environment(config: Dict[str, Any]) -> Dict[str, str]:
    environment = os.environ.copy()
    base = gateway_url(config, "").rstrip("/")
    environment.update(
        {
            "ANTHROPIC_AUTH_TOKEN": "local-glm-gateway",
            "ANTHROPIC_BASE_URL": base,
            "ANTHROPIC_DEFAULT_OPUS_MODEL": "hasunomi-glm",
            "ANTHROPIC_DEFAULT_SONNET_MODEL": "hasunomi-deepseek-openrouter",
            "ANTHROPIC_DEFAULT_HAIKU_MODEL": "hasunomi-deepseek-direct",
            "CLAUDE_CODE_SUBAGENT_MODEL": "hasunomi-deepseek-direct",
        }
    )
    environment.pop("ANTHROPIC_API_KEY", None)
    environment.pop("ZAI_API_KEY", None)
    environment.pop("OPENROUTER_API_KEY", None)
    environment.pop("DEEPSEEK_API_KEY", None)
    return environment


def local_message(config: Dict[str, Any], body: Dict[str, Any]) -> Dict[str, Any]:
    request = urllib.request.Request(
        gateway_url(config, "/v1/messages"),
        data=json.dumps(body).encode(),
        headers={
            "Content-Type": "application/json",
            "x-api-key": "local-glm-gateway",
            "anthropic-version": "2023-06-01",
        },
        method="POST",
    )
    try:
        with urllib.request.urlopen(request, timeout=300) as response:
            value = json.loads(response.read().decode())
    except urllib.error.HTTPError as error:
        detail = error.read().decode(errors="replace")
        raise GatewayError(f"live request failed: HTTP {error.code}: {detail[:500]}")
    if not isinstance(value, dict):
        raise GatewayError("live request did not return a JSON object")
    return value
