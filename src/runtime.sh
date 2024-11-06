#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./env.sh
source ./console.sh

if env_file_exists; then
  case "$(print_env 'CONTAINER_RUNTIME')" in
    docker) source ./runtime.docker.sh ;;
    podman) source ./runtime.podman.sh ;;
    *) error "$(print_env 'CONTAINER_RUNTIME') container runtime is not supported" ;;
  esac
fi
