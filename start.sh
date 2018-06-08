#!/bin/bash
set -e

_cleanup () {
  if [ ! -z ${REPO} ]; then
    if [ $? -ne 0 ]; then
      rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true
      echo "# Error during clone"         > README.md
      echo ""                            >> README.md
      echo "Cloning ${REPO} failed."     >> README.md
      echo ""                            >> README.md
      echo "Check the Logs for details." >> README.md
    fi
    refresh
  fi
  exit 0
}

trap _cleanup EXIT

if [ ! -z "${REPO}" ]; then
  echo "Cloning ${REPO}, please wait..."
  until nc -z localhost 1081; do
    sleep 1
  done
  sleep 5
  curl -X POST http://localhost:1083/stop &> /dev/null
  rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true
  git init
  if [ ! -z "${USER}" ]; then
    proto="$(echo ${REPO} | grep :// | sed -e's,^\(.*://\).*,\1,g')"
    url="$(echo ${REPO/$proto/})"
    echo "${proto}${USER}:${PASS}@${url}" > .git-credentials
  fi
  git remote add origin "${REPO}"
  git fetch
  git checkout -t origin/master
  git remote set-url origin ${REPO}
  echo "Done!"
  exit 0
fi

echo "Git Cloner not initialized"

export PATH="${PATH}:${DEFAULT_NODE_DIR}"

ws --port 3000 --directory . --forbid '/.env' --forbid '/.data' --forbid '/.git' --log-format combined
