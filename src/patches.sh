#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./util.sh

v3_20_0_add_arch_and_container_runtime() {
  if [ -z "$(print_env 'ARCH')" ]; then
    local architecture=""
    case $(uname -m) in
      x86_64) architecture="amd64" ;;
      aarch64|arm64) architecture="arm64" ;;
      *)
        error "Unable to detect architecture $(highlight "$(uname -m)")"
        error "Please file a ticket so we may resolve this issue:"
        error "    Public:    https://github.com/cybertec-postgresql/cybertec_migrator/issues/new/choose"
        error "    Customers: https://cybertec.atlassian.net/servicedesk/customer/portal/3/group/4/create/23"
        exit 1
        ;;
    esac
    set_env_file_variable "ARCH" "$architecture"
  fi

  if [ -z "$(print_env 'CONTAINER_RUNTIME')" ]; then
    set_env_file_variable "CONTAINER_RUNTIME" "docker"
  fi
}
