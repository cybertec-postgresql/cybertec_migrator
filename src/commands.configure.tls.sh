#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./tls.sh

command_configure_tls() {
  local tls_sub_command=$(echo "${1}" | cut --delimiter=":" --fields=1)
  local tls_file_location=$(echo "${1}" | cut --delimiter=":" --fields=2)
  case ${tls_sub_command} in
    "")
      error "Missing argument for option '--tls'"
      ;;
    self-signed-cert)
      generate_self_signed_certificate
      ;;
    key)
      exec_error=$(cp "${tls_file_location}" "${HOST_SSL_CERTIFICATE_KEY}" 2>&1 > /dev/null) || \
        error "Failed to install TLS/SSL certificate key\n${exec_error}"
      ok "Installed TLS/SSL certificate key"
      ;;
    cert)
      exec_error=$(cp "${tls_file_location}" "${HOST_SSL_CERTIFICATE}" 2>&1 > /dev/null) || \
        error "Failed to install TLS/SSL certificate\n${exec_error}"
      ok "Installed TLS/SSL certificate"
      ;;
    *)
      error "Unknown argument '${2} ${3}'"
      ;;
  esac
}
