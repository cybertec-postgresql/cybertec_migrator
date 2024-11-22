#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./console.sh
source ./env.sh

command_configure_edition() {
  edition=$(echo "${1}" | tr '[:upper:]' '[:lower:]')
  verify_edition "$edition"
  set_env_file_variable "EDITION" "$edition"
}

verify_edition() {
  edition="${1}"
    if [ "$edition" != "assessment" ] \
    && [ "$edition" != "trial" ] \
    && [ "$edition" != "professional" ] \
    && [ "$edition" != "enterprise" ]; then
        error "Edition $(highlight "'$edition'") is invalid. Possible values: assessment,trial,professional,enterprise"
    fi
}