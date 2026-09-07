#!/usr/bin/env bash
# Снимок рабочей версии перед правками:  ./backup.sh "почему"
set -euo pipefail
cd "$(dirname "$0")"
stamp="$(date '+%Y-%m-%d_%H%M')"
note="${*:-снимок}"
mkdir -p backups
cp index.html "backups/index_${stamp}.html"
printf '%s  %s\n' "$stamp" "$note" >> backups/README.md
echo "✓ backups/index_${stamp}.html — $note"
ls -1t backups/index_*.html | tail -n +16 | xargs -r rm --   # держим последние 15
