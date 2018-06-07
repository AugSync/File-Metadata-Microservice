#!/bin/bash
set -e

if [ ! -z "${GITHUB_REPO}" ]; then
  echo "Cloning ${GITHUB_REPO}..."
  rm -rf /app/* /app/.* &> /dev/null || true
  refresh
  git init
  if [ ! -z "${GITHUB_USER}" ]; then
    git remote add origin "https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPO}"
  else
    git remote add origin "https://github.com/${GITHUB_REPO}"
  fi
  git fetch
  git checkout -t origin/master
  git remote set-url origin "https://github.com/${GITHUB_REPO}"
  echo "Done!"
  refresh
  exit 0
fi

echo "GitHub Cloner not initialized"

export PATH="${PATH}:${DEFAULT_NODE_DIR}"

ws --port 3000 --directory . --forbid '/.env' --forbid '/.data' --forbid '/.git' --log-format combined
