#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

runtime_up() {
  docker compose --env-file ../.env up -d
}

runtime_down() {
  docker compose --env-file ../.env down
}

runtime_pull() {
  docker compose --env-file ../.env pull 2>&1 > /dev/null
}

runtime_logs() {
  docker compose --env-file ../.env logs --timestamps --tail='all' $1
}

runtime_load() {
  docker load < "${1}"
}

runtime_run() {
  local image="${1}"
  local cmd="${2}"
  local mount="${3}"

  if [ -n "${mount}" ]; then
    mount="--volume ${mount}"
  fi

  eval "docker run ${mount} ${image} bash -c \"${cmd}\""
}