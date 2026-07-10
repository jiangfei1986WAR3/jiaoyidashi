#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SOURCE="$REPO_ROOT/skills"
TARGET="$HOME/.codex/skills"

if [ ! -d "$SOURCE" ]; then
  echo "Missing source skills directory: $SOURCE" >&2
  exit 1
fi

mkdir -p "$TARGET"
cp -R "$SOURCE"/. "$TARGET"/

echo "Trading skills restored to: $TARGET"
echo "Next: ask Codex to verify the skills and update machine-specific paths."

