#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./util.sh

env_file_exists() {
  [ -f "${ENV_FILE}" ]
}

env_barrier() {
  if ! env_file_exists; then
    error "Initial configuration outstanding (run $(highlight "'./migrator install'"))"
  fi
}

print_env() {
  env -i "${BASH}" -c "set -a; . "${ENV_FILE}"; set +a; echo \${${1}};"
}

set_env_file_variable() {
  if grep "^$1=.*$" "${ENV_FILE}" &>/dev/null; then
    # Replace the value
    sed -i.bak -e "s/^$1=.*$/$1=$2/" "${ENV_FILE}"
  else
    # Insert the value in the second line of the env file
    cp "${ENV_FILE}" "${ENV_FILE}.bak"
    awk "NR==1{print; print \"$1=$2\"} NR!=1" "${ENV_FILE}.bak" > "${ENV_FILE}"
  fi
  rm "${ENV_FILE}.bak"
}

generate_env_file() {
  # If file exists return false
  ! env_file_exists || return

  info 'Generating environment file'

  # File doesn't exist, so generate it
  password="$(generate_random 'A-Za-z0-9!&()*+,-./:;<=>?@{|}~' 32)"
  encryption_key="$(generate_random 'A-Za-z0-9' 32)"
  encryption_iv="$(generate_random 'A-Za-z0-9' 16)"

  version=""
  if installed_from_archive; then
    version="$(cat "../${VERSION_FILE}")"
  else
    version="$(git describe --exact-match --tags HEAD)"
  fi

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