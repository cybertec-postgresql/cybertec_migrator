#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./runtime.sh

pull_images() {
  local edition="$(print_env 'EDITION')"
  local version="$(print_env 'VERSION')"

  info "Pulling container images for $(highlight "${edition}:${version}")"

  if pull_error=$(runtime_pull); then
    return
  else
    error "Failed to pull container images\n${pull_error}"
  fi
}
