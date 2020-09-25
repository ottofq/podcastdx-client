#!/usr/bin/env bash
set -euo pipefail

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PROJECT_DIR="$( cd "${SCRIPTS_DIR}" && cd .. && pwd )"

if [[ -f "${PROJECT_DIR}/.env" ]]; then
  set -o allexport
  source "${PROJECT_DIR}/.env"
  set +o allexport
fi

cd PROJECT_DIR

if [ -z "$(git status --porcelain)" ]; then
  yarn typedoc -out docs src
  git add docs/
  git commit -m "documentation update"

else
  echo "Please ensure everything is checked in before doing a publish"
fi
