#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./runtime.sh

command_up() {
  tls_barrier
  fix_encryption_key

  runtime_up
  print_url
}

tls_barrier() {
  if [ ! -f "${HOST_SSL_CERTIFICATE}" ] && [ ! -f "${HOST_SSL_CERTIFICATE_KEY}" ]; then
    error "Could not find TLS/SSL certificate" || true
    info "Run $(highlight "'./migrator configure --tls self-signed-cert'") to generate a self-signed TLS/SSL certificate"
    exit 3
  fi
}

fix_encryption_key() {
  # With v3.19.0, all passwords within the database are encrypted
  # TODO: remove after a couple of releases
  if [ -z "$(print_env 'CORE_ENCRYPTION_KEY')" ]; then
    encryption_key="$(generate_random 'A-Za-z0-9' 32)"
    encryption_iv="$(generate_random 'A-Za-z0-9' 16)"

    echo "CORE_ENCRYPTION_KEY=\"${encryption_key}\"" >> "${ENV_FILE}"
    echo "CORE_ENCRYPTION_IV=\"${encryption_iv}\"" >> "${ENV_FILE}"
    info "Generated encryption key and IV"
  fi
}

print_url() {
  ip_addr="$(get_hostname)"
  if [ ! -z "${ip_addr}" ]; then
    port=":$(print_env 'EXTERNAL_HTTP_PORT')"
    if [ "${port}" = ":${HTTPS_PORT_DEFAULT}" ]; then
      port=''
    fi

    ok "Started on $(highlight "'https://${ip_addr}${port}'")"
  fi
}

get_hostname() {
  # BSD `hostname` doesn't understand the `-I` flag
  (hostname --all-ip-addresses 2> /dev/null || hostname) | awk '{ print $1 }'
}