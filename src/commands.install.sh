#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./console.sh
source ./env.sh
source ./images.load.sh
source ./images.pull.sh
source ./tls.sh
source ./util.sh

command_install() {
  if env_file_exists; then
    error "Unable to install: $(highlight "env file already exists")"
  fi

  # TODO: Handle git unsafe directory error case

  info "You are about to be asked to enter some information relevant to the installation."
  info "The allowed values are in normal brackets, the default value in square brackets."

  if ! detect_arch > /dev/null; then
    exit 1
  fi
  local arch="$(detect_arch)"
  local edition="$(prompt_edition)"
  local runtime="$(prompt_runtime)"

  generate_env_file

  set_env_file_variable "ARCH" "${arch}"
  set_env_file_variable "EDITION" "${edition}"
  set_env_file_variable "CONTAINER_RUNTIME" "${runtime}"

  if installed_from_archive; then
    load_images_from_path "../${IMAGE_PATH}";
  else
    pull_images;
  fi

  generate_self_signed_certificate

  ok "Install finished. To start the CYBERTEC Migrator, run $(highlight "./migrator up")"
}

detect_arch() {
  local architecture=""
  case $(uname -m) in
    x86_64)  architecture="amd64" ;;
    aarch64) architecture="arm64" ;;
    *) error "Unable to detect architecture $(highlight "$(uname -m)")"; exit 1 ;;
  esac
  echo "${architecture}"
}

prompt_edition() {
  local edition="trial"
  if installed_from_archive; then
    edition=$(cat "../${EDITION_FILE}")
  fi
  while true; do
    read -p "Migrator Edition (trial, professional, enterprise) [$edition]: " result
    case $result in
      "") break ;;
      assessment) ;&
      trial) ;&
      professional) ;&
      enterprise) edition=$result; break ;;
      * ) ;;
    esac
  done
  echo "${edition}"
}

prompt_runtime() {
  local runtime="docker"
  if command -v docker 2>&1 >/dev/null
  then
    runtime="docker"
  elif command -v podman 2>&1 >/dev/null
  then
    runtime="podman"
  fi

  while true; do
    read -p "Container runtime (docker, podman) [$runtime]: " result
    case $result in
      "") break ;;
      docker) ;&
      podman) runtime=$result; break ;;
      * ) ;;
    esac
  done
  echo "${runtime}"
}