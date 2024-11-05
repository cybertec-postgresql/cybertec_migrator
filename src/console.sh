#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

# Color codes
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
LIGHT_GREY='\033[1;37m'
NC='\033[0m'

print() {
  printf "${1}\n"
}

highlight() {
  echo "${LIGHT_GREY}${1}${NC}"
}

error() {
  >&2 printf "[${RED}ERROR${NC}] ${1}\n"
  return ${2-1}
}

warn() {
  printf "[${YELLOW}WARN${NC}] ${1}\n"
}

info() {
  printf "[${WHITE}INFO${NC}] ${1}\n"
}

ok() {
  printf "[${GREEN}OK${NC}] ${1}\n"
}
