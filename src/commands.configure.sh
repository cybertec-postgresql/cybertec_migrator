#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./commands.configure.edition.sh
source ./commands.configure.tls.sh
source ./console.sh

command_configure() {
  case "${2}" in
  --edition)
    command_configure_edition "${3}"
    ;;
  --tls)
    command_configure_tls "${3}"
    ;;
  *)
    error "Unexpected usage"
  esac
}
