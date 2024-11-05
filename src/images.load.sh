#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./runtime.sh

load_images_from_path() {
  local path="${1}"

  info 'Loading container images'

  [ -d "${path}" ] || error "Archive file corrupted - '${path}' directory with container images missing"

  for image in ${path}/*.tar; do
    runtime_load "${image}" > /dev/null
  done
}
