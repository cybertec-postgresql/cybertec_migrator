#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./util.sh

env_file_exists() {
  [ -f "${ENV_FILE}" ]
}

print_env() {
  env -i "${BASH}" -c "set -a; . "${ENV_FILE}"; set +a; echo \${${1}};"
}

set_env_file_variable() {
  if grep "^$1=.*$" "${ENV_FILE}" &>/dev/null; then
    sed -i -e "s/^$1=.*$/$1=$2/" "${ENV_FILE}"
  else
    sed -i "1{G;s/$/$1=$2/}" "${ENV_FILE}"
  fi
}

generate_env_file() {
  # If file exists return false
  ! env_file_exists || return

  info 'Generating environment file'

  # File doesn't exist, so generate it
  password="$(generate_random 'A-Za-z0-9!&()*+,-./:;<=>?@{|}~' 32)"
  encryption_key="$(generate_random 'A-Za-z0-9' 32)"
  encryption_iv="$(generate_random 'A-Za-z0-9' 16)"
  version="$(git describe --exact-match --tags HEAD)"

  cat <<EOF > "${ENV_FILE}"
# —— User configurable ——
EXTERNAL_HTTP_PORT=${HTTPS_PORT_DEFAULT}
VERSION=${version}
EDITION=trial
CONTAINER_RUNTIME=docker

# —— Internal ⚠ ——
CORE_DB_PASSWORD="${password}"
CORE_ENCRYPTION_KEY="${encryption_key}"
CORE_ENCRYPTION_IV="${encryption_iv}"
EOF

  chmod 600 "${ENV_FILE}"
}