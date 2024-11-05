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
source ./env.sh

case "${1}" in
  install)
    command_install
    ;;
  upgrade)
    env_barrier
    command_upgrade "$@"
    ;;
  up)
    env_barrier
    command_up
    ;;
  down)
    env_barrier
    command_down
    ;;
  logs)
    env_barrier
    command_logs "$2"
    ;;
  configure)
    env_barrier
    command_configure "$@"
    ;;
  versions)
    env_barrier
    sanctioned_tags
    ;;
  version)
    env_barrier
    print_env 'VERSION'
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