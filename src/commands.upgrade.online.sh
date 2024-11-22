#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./images.pull.sh
source ./util.sh

command_upgrade_online() {
  info 'Updating release information'
  git fetch || error 'Could not fetch versions'

  local arch=$(print_env 'ARCH')
  local version="$(git tag --list --sort=-v:refname "*-${arch}" | head -n 1)"
  info "Upgrading to version $(highlight "${version}")"
  set_env_file_variable 'VERSION' "${version}"

  if pull_error=$(pull_images); then
    return
  else
    error "Failed to pull container images\n${pull_error}" || true
    if installed_from_archive; then
      info "Migrator was installed from an archive: run $(highlight "'./migrator upgrade --archive <archive_file>'") instead"
    fi
    exit 2
  fi
}
