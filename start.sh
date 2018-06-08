#!/bin/bash
set -e

if [ -z ${REPO_URL} ]; then
  export PATH="${PATH}:${DEFAULT_NODE_DIR}"

  ws --port 3000 --directory . --forbid '/.env' --forbid '/.data' --forbid '/.git' --log-format combined &> /dev/null
  exit
fi

trap _cleanup EXIT

_cleanup () {
  if [ $? -ne 0 ]; then
    rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true
    echo "# Error during clone"         > README.md
    echo ""                            >> README.md
    echo "Cloning ${REPO_URL} failed." >> README.md
    echo ""                            >> README.md
    echo "Check the Logs for details." >> README.md
  fi
  refresh
  exit 0
}

if [ ! -z "${REPO_URL}" ]; then
  parsed_url=($(python ./parse_url.py ${REPO_URL}))
  
  proto=${parsed_url[0]}
  user=${parsed_url[1]}
  pass=${parsed_url[2]}
  hostname=${parsed_url[3]}
  pathname=${parsed_url[4]}
  safe_url="${proto}://${hostname}${pathname}"
  
  if [ ${user} = "None" ] && [ ${pass} = "None" ]; then
    user=""
    pass=""
  fi

  echo "Cloning ${safe_url}, please wait..."

  # Wait for ot server to become available before stopping it
  until nc -z localhost 1081; do
    sleep 1
  done
  sleep 5
  # Stop the OT Server
  curl -X POST http://localhost:1083/stop &> /dev/null
  
  rm -rf /app/* /app/.* /rbd/pnpm-volume/app/node_modules &> /dev/null || true

  git init
  git config credential.helper store
  if [ ! -z "${user}" ]; then
    mkdir -p .config/git
    echo "${proto}://${user}:${pass}@${hostname}" > .config/git/credentials
    echo "Credentials stored in .config/git/credentials"
  fi
  git remote add origin "${safe_url}"
  git fetch
  git checkout -t origin/master

  echo "Done!"
  exit 0
fi
