#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./console.sh
source ./runtime.sh
source ./util.sh

generate_self_signed_certificate() {
  info "Generating self-signed TLS/SSL certificate"

  local edition=$(print_env 'EDITION')
  local version=$(print_env 'VERSION')
  local image="docker.io/cybertecpostgresql/cybertec_migrator-${edition}-web_gui:${version}"

  runtime_run ${image} "openssl genrsa -out /tmp/nginx.key 4096 && cat /tmp/nginx.key" \
    > ../volumes/web_gui/nginx/certs/nginx.key
  runtime_run ${image} \
    "openssl req -new -key /tmp/nginx.key -x509 -out /tmp/nginx.crt -days 3650 -subj \\\"/C=AT/ST=Lower Austria/L=Wöllersdorf/O=CYBERTEC PostgreSQL International GmbH/OU=Development/CN=cybertec.at\\\" && cat /tmp/nginx.crt" \
    "type=bind,source=\"$(pwd)/../volumes/web_gui/nginx/certs/nginx.key\",target=/tmp/nginx.key" \
    > ../volumes/web_gui/nginx/certs/nginx.crt
}
