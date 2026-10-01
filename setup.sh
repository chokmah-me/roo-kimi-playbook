#!/usr/bin/env bash
# Install the roo-kimi-playbook configuration into a project directory.
# Usage: ./setup.sh /path/to/project
set -euo pipefail

TARGET="${1:-}"
if [ -z "$TARGET" ]; then
  echo "usage: $0 /path/to/project" >&2
  exit 1
fi

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$TARGET"

cp "$HERE/.clinerules" "$TARGET/.clinerules"
cp -r "$HERE/.roo" "$TARGET/.roo"

if [ ! -f "$TARGET/AGENTS.md" ]; then
  cp "$HERE/templates/AGENTS.md" "$TARGET/AGENTS.md"
  echo "installed starter AGENTS.md — edit it for your project"
else
  echo "AGENTS.md already present — left untouched"
fi

echo "done → $TARGET"
echo "next: install Zoo Code (or the Kimi Code CLI) and follow INSTALLATION_GUIDE.md"
