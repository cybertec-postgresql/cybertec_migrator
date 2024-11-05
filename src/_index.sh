#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

set -e
shopt -s nullglob

# Change working directory to script directory
cd "${0%/*}"

source ./commands.configure.sh
source ./commands.down.sh
source ./commands.help.sh
source ./commands.install.sh
source ./commands.logs.sh
source ./commands.up.sh
source ./commands.upgrade.sh
source ./console.sh

case "${1}" in
  install)
    command_install
    ;;
  upgrade)
    command_upgrade "$@"
    ;;
  up)
    command_up
    ;;
  down)
    command_down
    ;;
  logs)
    command_logs "$2"
    ;;
  configure)
    command_configure "$@"
    ;;
  versions)
    sanctioned_tags
    ;;
  version)
    if env_file_exists; then
      print_env 'VERSION'
    else
      error "Initial configuration outstanding (run $(highlight "'./migrator install'"))"
    fi
    ;;
  help)
    command_help
    exit 0
    ;;
  *)
    error "Unknown command [${1}]" || true
    command_help
    exit 0
    ;;
  esac