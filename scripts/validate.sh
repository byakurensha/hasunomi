#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required=(
  README.md README.ja.md LICENSE SECURITY.md
  HASUNOMI/CLAUDE.md HASUNOMI/version.txt
  add-ons/glm-deepseek-gateway/APPLY.md
  add-ons/glm-deepseek-gateway/version.txt
)
for item in "${required[@]}"; do
  test -e "$ROOT/$item" || { echo "NG: missing $item" >&2; exit 1; }
done

test "$(head -n 1 "$ROOT/HASUNOMI/version.txt")" = "HASUNOMI 1.2.2"
test "$(head -n 1 "$ROOT/add-ons/glm-deepseek-gateway/version.txt")" = \
  "HASUNOMI GLM + DeepSeek Gateway Add-on 2.0.0"

python3 - \
  "$ROOT/HASUNOMI/system/management-tool/management-tool" \
  "$ROOT/HASUNOMI/system/office-tool/office-tool" \
  "$ROOT/add-ons/glm-deepseek-gateway/runtime/glm-gateway" \
  "$ROOT/add-ons/glm-deepseek-gateway/runtime/glm-gateway-wrapper" \
  "$ROOT/add-ons/glm-deepseek-gateway/runtime/glm-gateway-server" \
  "$ROOT/add-ons/glm-deepseek-gateway/runtime/glm_gateway_common.py" <<'PY'
from pathlib import Path
import sys

for name in sys.argv[1:]:
    source = Path(name).read_text(encoding="utf-8")
    compile(source, name, "exec")
PY
bash -n "$ROOT/add-ons/glm-deepseek-gateway/install.sh"

if find "$ROOT" -type f \( \
  -name '*.zip' -o -name '.env' -o -name '.env.*' -o \
  -name '*.pyc' -o -name '.DS_Store' \
\) -print -quit | grep -q .; then
  echo "NG: generated archive, cache, or environment file entered public source" >&2
  exit 1
fi

if rg -ni \
  --glob '!validate.sh' \
  '/Users/zedo|/home/lotus|/home/leaf|Source/byakurensha|POND|POT|Internal-Overlay' \
  "$ROOT"; then
  echo "NG: private path or internal runtime detail found" >&2
  exit 1
fi
if rg -n '(ZAI|OPENROUTER|DEEPSEEK|ANTHROPIC)_API_KEY=[A-Za-z0-9_.-]{12,}' "$ROOT"; then
  echo "NG: possible credential value found" >&2
  exit 1
fi

echo "OK: HASUNOMI GitHub public source boundary"
