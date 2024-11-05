#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./commands.upgrade.offline.sh
source ./commands.upgrade.online.sh
source ./env.sh
source ./runtime.sh

command_upgrade() {
  if [ -z "${2}" ]; then
      command_upgrade_online
  elif [ "${2}" = '--archive' ] && [ -f "${3}" ]; then
      command_upgrade_offline "${3}"
  else
      error 'Unexpected usage'
  fi

  git checkout --quiet "$(print_env 'VERSION')"

  ok "Upgrade finished. To restart the CYBERTEC Migrator, run $(highlight "./migrator up")"
}
