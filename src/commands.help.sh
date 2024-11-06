#!/usr/bin/env bash

# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2022-2024 CYBERTEC PostgreSQL International GmbH <office@cybertec.at>

source ./console.sh

command_help() {
    print "$(cat <<EOF
$(highlight "up")                                     Start Migrator in background
$(highlight "down")                                   Stop Migrator
$(highlight "logs")                                   Print logs

$(highlight "edition")                                Display current edition
$(highlight "version")                                Display current version

$(highlight "upgrade")                                Upgrade to newest version
$(highlight "upgrade") --archive <archive-file>       Upgrade to version contained in archive

$(highlight "configure --edition <edition>")          Set CYBERTEC Migrator edition. Must be one of (assessment,trial,professional,enterprise)
$(highlight "configure --tls self-signed-cert")       Generate self-signed TLS/SSL certificate
$(highlight "configure --tls cert:<file-location>")   Install TLS/SSL certificate (the path has to be absolute)
$(highlight "configure --tls key:<file-location>")    Install private key of TLS/SSL certificate (the path has to be absolute)

$(highlight "help")                                   Display this help text
EOF
)"
}