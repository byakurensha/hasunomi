#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE=""

while [ "$#" -gt 0 ]; do
  case "$1" in
    --workspace)
      [ "$#" -ge 2 ] || { echo "NG: --workspace needs a path" >&2; exit 2; }
      WORKSPACE="$2"
      shift 2
      ;;
    -h|--help)
      echo "Usage: ./install.sh --workspace /absolute/path/to/workspace"
      exit 0
      ;;
    *)
      echo "NG: unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

[ -n "$WORKSPACE" ] || { echo "NG: --workspace is required" >&2; exit 2; }
WORKSPACE="$(cd "$WORKSPACE" && pwd)"
[ -f "$WORKSPACE/CLAUDE.md" ] || { echo "NG: target has no CLAUDE.md" >&2; exit 1; }
[ -d "$WORKSPACE/.claude" ] || { echo "NG: target has no .claude directory" >&2; exit 1; }

python3 - <<'PY'
import sys
if sys.version_info < (3, 9):
    raise SystemExit("NG: Python 3.9 or newer is required")
PY

SHARE="$HOME/.local/share/glm-gateway"
CONFIG="$HOME/.config/glm-gateway"
BIN="$HOME/bin"
STAGE="$(mktemp -d "${TMPDIR:-/tmp}/glm-gateway-install.XXXXXX")"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/runtime" "$SHARE" "$CONFIG" "$BIN"
cp -R "$ROOT/runtime/." "$STAGE/runtime/"
chmod 755 "$STAGE/runtime/glm-gateway" \
  "$STAGE/runtime/glm-gateway-wrapper" \
  "$STAGE/runtime/glm-gateway-server"

rm -rf "$SHARE/runtime"
mv "$STAGE/runtime" "$SHARE/runtime"
cp "$ROOT/version.txt" "$SHARE/version.txt"
ln -sfn "$SHARE/runtime/glm-gateway" "$BIN/glm-gateway"

python3 - "$WORKSPACE" "$CONFIG/config.json" "$ROOT/version.txt" <<'PY'
import json
import os
from pathlib import Path
import sys

workspace = str(Path(sys.argv[1]).resolve())
path = Path(sys.argv[2])
version = Path(sys.argv[3]).read_text(encoding="utf-8").strip()
exa = {"type": "http", "url": "https://mcp.exa.ai/mcp"}
current = {}
if path.exists():
    value = json.loads(path.read_text(encoding="utf-8"))
    if isinstance(value, dict):
        current = value

mcp_path = Path(workspace) / ".mcp.json"
mcp = {}
if mcp_path.exists():
    value = json.loads(mcp_path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise SystemExit(f"NG: MCP configuration must be an object: {mcp_path}")
    mcp = value
servers = mcp.setdefault("mcpServers", {})
if not isinstance(servers, dict):
    raise SystemExit(f"NG: mcpServers must be an object: {mcp_path}")
existing_exa = servers.get("exa")
managed_exa = bool(current.get("exa_mcp_managed", False))
if existing_exa is None:
    servers["exa"] = exa
    managed_exa = True
elif existing_exa != exa:
    raise SystemExit("NG: an MCP server named exa already has a different configuration")

mcp_path.parent.mkdir(parents=True, exist_ok=True)
mcp_temporary = mcp_path.with_suffix(".json.tmp")
mcp_temporary.write_text(json.dumps(mcp, indent=2) + "\n", encoding="utf-8")
os.chmod(mcp_temporary, 0o644)
mcp_temporary.replace(mcp_path)

current.update({
    "schema": 2,
    "addon_version": version,
    "workspace": workspace,
    "port": int(current.get("port", 8794)),
    "text_model": current.get("text_model", "glm-5.2"),
    "openrouter_model": current.get("openrouter_model", "deepseek/deepseek-v4-pro"),
    "deepseek_model": current.get("deepseek_model", "deepseek-v4-pro"),
    "vision_model": current.get("vision_model", "glm-4.6v"),
    "zai_anthropic_url": current.get(
        "zai_anthropic_url",
        current.get("anthropic_url", "https://api.z.ai/api/anthropic/v1/messages"),
    ),
    "openrouter_anthropic_url": current.get(
        "openrouter_anthropic_url", "https://openrouter.ai/api/v1/messages"
    ),
    "deepseek_anthropic_url": current.get(
        "deepseek_anthropic_url", "https://api.deepseek.com/anthropic/v1/messages"
    ),
    "vision_url": current.get(
        "vision_url", "https://api.z.ai/api/paas/v4/chat/completions"
    ),
    "zai_key_file": str(path.parent / "zai.env"),
    "openrouter_key_file": str(path.parent / "openrouter.env"),
    "deepseek_key_file": str(path.parent / "deepseek.env"),
    "exa_mcp_managed": managed_exa,
})
current.pop("anthropic_url", None)
current.pop("key_file", None)
path.parent.mkdir(parents=True, exist_ok=True)
temporary = path.with_suffix(".tmp")
temporary.write_text(json.dumps(current, indent=2) + "\n", encoding="utf-8")
os.chmod(temporary, 0o600)
temporary.replace(path)
PY

"$BIN/glm-gateway" configure

cat <<EOF
OK: GLM + DeepSeek Gateway Add-on installed.
Workspace: $WORKSPACE
Normal VS Code settings were not changed.
Official Exa search MCP was registered in the HASUNOMI workspace.

Configure at least one text provider. Each command is independent:
  $BIN/glm-gateway key zai          # Opus: GLM-5.2; also enables image/PDF
  $BIN/glm-gateway key openrouter   # Sonnet: DeepSeek V4 Pro via OpenRouter
  $BIN/glm-gateway key deepseek     # Haiku: DeepSeek V4 Pro direct

You may configure all three, but it is not required:
  $BIN/glm-gateway key all

Then verify and launch:
  $BIN/glm-gateway status
  $BIN/glm-gateway doctor --live
  $BIN/glm-gateway launch

On first launch, approve the project MCP server named exa if Claude Code asks.
EOF
