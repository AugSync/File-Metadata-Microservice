#!/bin/bash
set -e

if [ ! -z "${REPO}" ]; then
  echo "Cloning ${REPO}, please wait..."
  until nc -z localhost 1081; do
    sleep 1
  done
  sleep 1
  curl -X POST http://localhost:1083/stop &> /dev/null
  rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true
  git init
  if [ ! -z "${USER}" ]; then
    proto="$(echo ${REPO} | grep :// | sed -e's,^\(.*://\).*,\1,g')"
    url="$(echo ${REPO/$proto/})"
    git remote add origin "${proto}${USER}:${PASS}@${url}"
  else
    git remote add origin "${REPO}"
  fi
  git fetch
  git checkout -t origin/master
  git remote set-url origin ${REPO}
  echo "Done!"
  refresh
  exit 0
fi

echo "Git Cloner not initialized"

export PATH="${PATH}:${DEFAULT_NODE_DIR}"

ws --port 3000 --directory . --forbid '/.env' --forbid '/.data' --forbid '/.git' --log-format combined
