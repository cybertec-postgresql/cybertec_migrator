#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./constants.sh
source ./util.sh

v3_20_0_add_arch_and_container_runtime() {
  if [ -z "$(print_env 'ARCH')" ]; then
    local architecture=""
    case $(uname -m) in
      x86_64) architecture="amd64" ;;
      aarch64|arm64) architecture="arm64" ;;
      *)
        error "Unable to detect architecture $(highlight "$(uname -m)")"
        error "Please file a ticket so we may resolve this issue:"
        error "    Public:    https://github.com/cybertec-postgresql/cybertec_migrator/issues/new/choose"
        error "    Customers: https://cybertec.atlassian.net/servicedesk/customer/portal/3/group/4/create/23"
        exit 1
        ;;
    esac
    set_env_file_variable "ARCH" "$architecture"
  fi

  if [ -z "$(print_env 'CONTAINER_RUNTIME')" ]; then
    set_env_file_variable "CONTAINER_RUNTIME" "docker"
  fi
}

v4_0_0_add_llm_settings() {
  if ! env_file_exists; then
    return
  fi

  if grep -q 'CORE_LLM_CONFIG' "${ENV_FILE}"; then
    return
  fi

  cat >> "${ENV_FILE}" <<'EOF'

# —— AI-Assistant (optional) ——
# Mode 1 (recommended): copy ./llm.example.yaml to ./llm.yaml, then uncomment:
# CORE_LLM_CONFIG=llm.yaml
# Optional: override the model, API key and timeout of the file
# CORE_LLM_MODEL=
# CORE_LLM_API_KEY=
# CORE_LLM_TIMEOUT_MS=300000
# Mode 2: configure a single model without a file (CORE_LLM_BASE_URL and CORE_LLM_MODEL are required):
# CORE_LLM_BASE_URL=https://llm.example.com/v1
# CORE_LLM_MODEL=
# CORE_LLM_API_KEY=
# CORE_LLM_TIMEOUT_MS=300000
EOF
  info 'Added AI-Assistant settings to the environment file'
}
