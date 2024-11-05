#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./console.sh
source ./runtime.sh

command_logs() {
  if [ ! -z "$(docker compose top)" ]; then
    runtime_logs "$1"
  else
    error "Logs not available while not running ($(highlight "'./migrator up'") to start)"
  fi
}
