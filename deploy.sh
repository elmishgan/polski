#!/usr/bin/env bash
# Публикация тренажёра на GitHub Pages.
# Использование:  ./deploy.sh            — коммит с датой в сообщении
#                 ./deploy.sh "текст"    — своё сообщение коммита
set -euo pipefail
cd "$(dirname "$0")"

msg="${*:-обновление $(date '+%Y-%m-%d %H:%M')}"

git add -A
if git diff --cached --quiet; then
  echo "Изменений нет — публиковать нечего."
  exit 0
fi

git commit -q -m "$msg"
git push -q

remote="$(git remote get-url origin 2>/dev/null || true)"
if [ -n "$remote" ]; then
  slug="$(printf '%s' "$remote" | sed -e 's#^git@github.com:##' -e 's#^https://github.com/##' -e 's#\.git$##')"
  user="${slug%%/*}"
  repo="${slug##*/}"
  echo "✓ Запушено: $msg"
  echo "  Через ~30 секунд обновится: https://${user}.github.io/${repo}/"
  echo "  На айфоне: просто закрой и снова открой иконку (нужна сеть)."
else
  echo "✓ Закоммичено локально, но remote не настроен — см. CLAUDE.md §7."
fi
