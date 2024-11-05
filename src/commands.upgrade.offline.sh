#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./barriers.sh
source ./constants.sh
source ./env.sh
source ./images.load.sh
source ./runtime.sh
source ./util.sh

command_upgrade_offline() {
  local archive="${1}"

  info "Extracting archive"
  temp_dir="$(mktemp -t "${TEMP_TEMPLATE}" -d)"
  trap 'rm -rf -- "${temp_dir}"' EXIT
  extraction_error=$(tar -xf "${archive}" --strip-components=2 --directory "${temp_dir}" 2>&1 > /dev/null) \
    || error "Failed to extract archive file\n$extraction_error"

  info "Updating release information"
  git fetch --quiet --tags "${temp_dir}/.git" 1>/dev/null

  local archive_image_path="${temp_dir}/${IMAGE_PATH}"
  load_images_from_path "${archive_image_path}"

  info 'Archiving container images'
  mkdir -p "../${IMAGE_PATH}"
  mv ${archive_image_path}/*.tar "../${IMAGE_PATH}"

  set_env_file_variable EDITION "$(cat "${temp_dir}/${EDITION_FILE}")"
  set_env_file_variable VERSION "$(cat "${temp_dir}/${VERSION_FILE}")"
}
