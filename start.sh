#!/bin/bash
set -e

if [ ! -z "${GITHUB_REPO}" ]; then
  echo "Cloning ${GITHUB_REPO}, please wait..."
  until [ nc -z localhost 1081 ]; do
    sleep 1
  done
  sleep 1
  curl -X POST http://localhost:1083/stop &> /dev/null
  rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true
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
