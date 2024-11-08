#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh

runtime_up() {
  ( cd .. ; podman-compose up -d )
}

runtime_down() {
  ( cd .. ; podman-compose down )
}

runtime_pull() {
  ( cd .. ; podman-compose pull 2>&1 > /dev/null )
}

runtime_logs() {
  ( cd .. ; podman-compose logs --timestamps --tail='all' $1 )
}

runtime_load() {
  local image_reference=$(podman load --quiet < "${1}")
  # Podman prefixes images with localhost/
  # We have to re-tag the image to start with docker.io/
  image_reference="${image_reference#*localhost/}"
  podman tag "localhost/${image_reference}" "docker.io/${image_reference}"
  podman image rm "localhost/${image_reference}"
}

runtime_run() {
  local image="${1}"
  local cmd="${2}"
  local mount="${3}"

  if [ -n "${mount}" ]; then
    mount="--volume ${mount}"
  fi

  eval "podman run ${mount} ${image} bash -c \"${cmd}\""
}