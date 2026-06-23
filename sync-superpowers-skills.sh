#!/usr/bin/env bash
# Pulls upstream updates into this repo, then deploys skills/ to the local
# superpowers install path (~/.config/superpowers/skills/).
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_DIR="${SUPERPOWERS_SKILLS_DIR:-$HOME/.config/superpowers/skills}"

cd "$REPO_DIR"

if git remote get-url upstream >/dev/null 2>&1; then
  echo "==> Fetching upstream..."
  git fetch upstream

  STASHED=0
  if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "==> Stashing local changes..."
    git stash push -m "sync-superpowers-skills autostash"
    STASHED=1
  fi

  echo "==> Fast-forward merging upstream/main..."
  git merge --ff-only upstream/main

  if [ "$STASHED" -eq 1 ]; then
    echo "==> Restoring stashed changes..."
    git stash pop
  fi
else
  echo "==> No 'upstream' remote configured, skipping pull step."
  echo "    Add one with: git remote add upstream <url>"
fi

echo "==> Deploying skills/ to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
rsync -a --delete "$REPO_DIR/skills/" "$INSTALL_DIR/"

echo "==> Done."
