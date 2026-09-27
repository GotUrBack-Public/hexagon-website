#!/bin/bash
# HEXAGON DEPLOYMENT SCRIPT FOR GITHUB PAGES
# USAGE: ./deploy.sh

set -e

REPO="hexagon-website"
BRANCH="gh-pages"
MSG="Deploy: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"

echo "[HEXAGON] Initializing deployment..."

if [ ! -d ".git" ]; then
    git init
    git remote add origin "git@github.com:USERNAME/$REPO.git"
fi

git checkout -B $BRANCH 2>/dev/null || git checkout $BRANCH
git add -A
git commit -m "$MSG" || echo "[HEXAGON] No changes to commit"
git push -f origin $BRANCH

echo "[HEXAGON] Deployment complete."
echo "[HEXAGON] Site available at: https://USERNAME.github.io/$REPO/"
echo "[HEXAGON] Remember: NO TRACE"