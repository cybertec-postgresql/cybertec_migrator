#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh

generate_random() {
  local PASSWORD_CHARSET="$1"
  local PASSWORD_LENGTH=$2
  LC_ALL=C tr -dc "${PASSWORD_CHARSET}" </dev/urandom | head -c "${PASSWORD_LENGTH}"
}

# TODO: Switch to .meta-inf file which contains more information
installed_from_archive() {
  [ -f "../${VERSION_FILE}" ] && return
  false
}


