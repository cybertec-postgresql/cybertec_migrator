# Frequently Asked Questions

FAQ for the [CYBERTEC Migrator](../README.md).

## Table of Contents

- [Installation and Configuration](#installation-and-configuration)
  - [How do I configure TCPS for Oracle databases?](#how-do-i-configure-tcps-for-oracle-databases)
  - [How do I generate a self-signed certificate?](#how-do-i-generate-a-self-signed-certificate)
  - [How do I install an existing certificate?](#how-do-i-install-an-existing-certificate)

## Installation and Configuration

#### How do I configure TCPS for Oracle databases?

- Install `sqlnet.ora` and `tnsnames.ora` from the template files.
  ```sh
  ➜ TNS_ADMIN=./volumes/core/config/oracle/network/admin
  ➜ cp "$TNS_ADMIN/templates"/*.ora "$TNS_ADMIN/"
  ```
- Add the net service name of the secure connection to the `volumes/core/config/oracle/network/admin/tnsnames.ora`.
- Create a **client wallet** containing the database server certificates and copy all wallet files to `./volumes/core/config/oracle/wallet` and restart the Migrator:
  ```sh
  ➜ cp <client wallet files> volumes/core/config/oracle/wallet
  ➜ ./migrator down
  ➜ ./migrator up
  ```
- When creating a new migration use the Oracle net service name defined in the previous steps. The URL format is `oracle://net_service_name`.

#### How do I generate a self-signed certificate

Generate the certificate with `migrator configure --tls self-signed-cert` and restart the Migrator.

```sh
➜ ./migrator configure --tls self-signed-cert
[INFO] Generating self-signed TLS/SSL certificate
Creating cybertec_migrator_web_gui_run ... done
Generating a RSA private key
.+++++
........................+++++
writing new private key to '/etc/nginx/certs/nginx.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:AT
State or Province Name (full name) [Some-State]:Lower Austria
Locality Name (eg, city) []:Wöllersdorf
Organization Name (eg, company) [Internet Widgits Pty Ltd]:CYBERTEC PostgreSQL International GmbH
Organizational Unit Name (eg, section) []:CYBERTEC Solutions
Common Name (e.g. server FQDN or YOUR name) []:
Email Address []:invalid@cybertec.at
Creating cybertec_migrator_web_gui_run ... done
[OK] Generated self-signed TLS/SSL certificate
[INFO] Run './migrator up' to switch to new version
[WARN] Switching will abort running migrations

➜ ./migrator up
Recreating cybertec_migrator_core_db_1 ... done
Recreating cybertec_migrator_core_1    ... done
Recreating cybertec_migrator_web_gui_1 ... done
[OK] Started on 'https://example.org'
```

#### How do I install an existing certificate?

Install the certificate and the private key with `configure --tls cert:<file-location>`, respective `configure --tls key:<file-location>`, and restart the Migrator.
For example if you have a certificate `example.org.crt` and the private key `example.org.key` located in `/tmp`.

```sh
➜ ./migrator configure --tls cert:/tmp/example.org.crt
[OK] Installed TLS/SSL certificate
➜ ./migrator configure --tls key:/tmp/example.org.key
[OK] Installed TLS/SSL certificate key
➜ ./migrator up
Recreating cybertec_migrator_core_db_1 ... done
Recreating cybertec_migrator_core_1    ... done
Recreating cybertec_migrator_web_gui_1 ... done
[OK] Started on 'https://example.org'
```
