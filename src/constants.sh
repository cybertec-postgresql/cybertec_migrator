#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

HTTPS_PORT_DEFAULT=443

# Temporary directory
TEMP_TEMPLATE='migrator.XXXXXX'

# Directory name in archive
ARCHIVE_DIR='./cybertec_migrator'

# Environment configuration files
ENV_FILE='../.env'

# Directory where we save container images provided from offline installation packages
IMAGE_PATH='images'

# These files exist only if the directory was provided by on offline installation package
EDITION_FILE='.edition'
VERSION_FILE='.version'

# TLS/SSL file on host (local bind mounts)
HOST_SSL_CERTIFICATE="../volumes/web_gui/nginx/certs/nginx.crt"
HOST_SSL_CERTIFICATE_KEY="../volumes/web_gui/nginx/certs/nginx.key"
