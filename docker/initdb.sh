#!/bin/bash

set -e

DATABASE="migrator"
SCHEMA="cybertec_migrator"

psql -v ON_ERROR_STOP=1 <<-EOF
    CREATE DATABASE ${DATABASE};
EOF

psql -v ON_ERROR_STOP=1 --dbname "${DATABASE}" <<-EOF
    CREATE SCHEMA ${SCHEMA};
EOF
