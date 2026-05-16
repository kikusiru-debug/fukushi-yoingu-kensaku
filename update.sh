#!/bin/bash
# data.csv が変更されていたら自動でGitHubにプッシュ → Netlifyに自動デプロイ

REPO="/Users/hasebeyuichi/Library/CloudStorage/GoogleDrive-hasebeu1@gmail.com/マイドライブ/💼 仕事・営業/fukushi-app"

cd "$REPO" || exit 1

if git diff --quiet data.csv && git ls-files --others --exclude-standard data.csv | grep -q .; then
  :
fi

if ! git diff --quiet data.csv 2>/dev/null; then
  echo "$(date): data.csv の変更を検知。GitHubにプッシュします…"
  git add data.csv
  git commit -m "Update data.csv: $(date '+%Y-%m-%d')"
  git push
  echo "$(date): デプロイ完了"
else
  echo "$(date): data.csv に変更なし"
fi
