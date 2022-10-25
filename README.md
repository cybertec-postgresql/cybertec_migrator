<p align="center">
  <img alt="CYBERTEC Migrator" width="300px" src="https://www.cybertec-postgresql.com/wp-content/uploads/2018/03/Migrator_neu-300x79.png"/>
  <br/><br/>
  <i>Streamlined Oracle to PostgreSQL migration</i>
</p>

---

<p align="center">
  <a href="#getting-started">Getting Started</a> •
  <a href="#running-the-migrator">Running the Migrator</a> •
  <a href="#contact">Contact</a>
</p>

[_CYBERTEC Migrator_](https://www.cybertec-postgresql.com/en/products/cybertec-migrator/) is a streamlined and user-friendly tool that helps you to organize and efficiently migrate multiple Oracle databases to PostgreSQL.
In addition to migrating your data professionally and securely with minimum effort, _CYBERTEC Migrator_ allows you to visually monitor and track the whole process at any time.

Do you want to know if the Migrator can migrate your Oracle database to PostgreSQL?
Then [get the Migrator Standard Edition](https://www.cybertec-postgresql.com/en/products/cybertec-migrator#form), a **free version** of the CYBERTEC Migrator, follow the offline instructions provided in [Getting Started](#offline-installation) section, and try it out.

The blog article [Meet the CYBERTEC Migrator](https://www.cybertec-postgresql.com/en/meet-the-cybertec-migrator/) provides a good introduction on how to migrate Oracle's HR demo schema to PostgreSQL.
Alternatively, you may want to watch the complementary [CYBERTEC Migrator YouTube playlist](https://www.youtube.com/playlist?list=PLt4uYyc72accw-Wi1Egn-IcOOSitK5Lcq).

<br/>

<p align="center">
  <a href="https://www.youtube.com/watch?v=z79_lZHmDG4&t=0s"><img alt="CYBERTEC Migrator v3 Demonstration" width="384px" src="http://img.youtube.com/vi/8hSrFVOw3Rc/0.jpg"/></a><br/>
  <b>Product Demo</b>
</p>

---

For detailed information see the list of [supported migration features for Oracle](docs/oracle-migration-support.md).

## Table of Contents

1. [What's New](#whats-new)
1. [Getting Started](#getting-started)
1. [Running the Migrator](#running-the-migrator)
1. [Getting Help](#getting-help)
1. [Contact](#contact)
1. [License](#license)

## What's New

For older releases see [Release Notes](RELEASE_NOTES.md).

### v3.12.0 - 2022-10-25

#### Features

- Enhance migration log in the data stage:

  - Improve summary of the start and end logs

    ```text
    resumed data stage from oracle://localhost:1521/pdb1 to postgresql://localhost:5432/postgres: using 8 workers
      excluded tables: 1
      successful transfers: 1 (out of 7)
      remaining transfers: 6

    ...

    failed executing data stage: stage run-time 00:01:534
      excluded tables: 1
      successful transfers: 6 (out of 7)
      remaining transfers: 1
      failed transfers: 1
    ```

  - Print a warning if the source and/or target connection are not encrypted
    ```text
    Info     Data  using secure connection to read data from oracle://pdb_sec [oracle://10.0.0.127:2484/pdb?protocol=tcps]
    Warning  Data  using insecure connection to write data to postgresql://localhost:5432/postgres
    ```
  - Periodically log `data-migrator` transfer statistics for each table.
    This interval may be set using the [`CORE_DATA_MIGRATOR_PROGRESS_INTERVAL` environment variable](docs/faq.md#how-do-i-set-environment-variables) (default: `600000` milliseconds, `10` minutes)

    ```text
    Verbose  Data  loading data for table:"HR"."EMPLOYEES" [hr.employees]: processed 982 rows in 01:20.000 - 45 rows/sec (total: 41 rows/sec in 05:00.000)
    Verbose  Data  finished loading data for table:"HR"."EMPLOYEES" [hr.employees]: processed 1012 rows in 00:02:01 - 40 rows/sec
    ```

- Quote reserved identifiers when generating data queries for both Oracle and PostgreSQL
- Add support for **secured communication** (TCPS) access to Oracle databases without using a _net service name_.
  For details, check out our [FAQ - How do I configure TCPS for Oracle databases](docs/faq.md#how-do-i-configure-tcps-for-oracle-databases) section
- Configure the [`FREEZE` parameter](https://www.postgresql.org/docs/current/sql-copy.html) during the data transfer by setting the [`CORE_DATA_MIGRATOR_USE_COPY_FREEZE` environment variable](docs/faq.md#how-do-i-set-environment-variables) (default: `false`).
  Only use this setting if you are aware of its implications

#### Resolved Bugs

- An error on the target connection during the structure, integrity or logic stage may cause the Migrator core to crash

## Getting Started

### Requirements

_CYBERTEC Migrator_ is distributed as a set of [container images](https://github.com/opencontainers/image-spec/blob/main/spec.md) that are managed with the help of [Docker Compose](https://docs.docker.com/compose/).

- [`docker`](https://docs.docker.com/get-docker/)
- [`docker-compose`](https://docs.docker.com/compose/install/) (`>= 1.27.0`)
- `git` (`>= 2.20.1`)
- `bash` (`>= 4.0`)

### Migrator Installation

The _CYBERTEC Migrator_ images can be obtained via two channels

- [Online installation via container registry](#online-installation)
- From an [offline installation](#offline-installation) package for environments in which networking restrictions are imposed

| 💡  | The Migrator Standard Edition is only available as [offline installation package](https://www.cybertec-postgresql.com/en/products/cybertec-migrator#form) |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |

#### Online installation

You need an account on the [Docker Hub](https://hub.docker.com/) container image registry.

Please [get in touch with us](#contact) if your account has not been granted access to the respective images.
Make sure you are logged in the Docker Hub registry with the correct user.

```sh
cat ~/password.txt | docker login --username <username> --password-stdin
```

1. Clone this git repository
2. Change working directory to the previously cloned repository
3. Generate default configuration
4. Download and load container images
5. Generate a self-signed TLS/SSL certificate or install a certificate (see [FAQ](docs/faq.md) for more details)
6. Start the Migrator

```sh
➜ git clone https://github.com/cybertec-postgresql/cybertec_migrator
➜ cd cybertec_migrator
➜ ./migrator configure
[OK] Generated environment file
[INFO] Run './migrator install' to complete setup
➜ ./migrator install
[INFO] Pulling v3.12.0
Pulling core_db ... done
Pulling core    ... done
Pulling web_gui ... done
[OK] Pulled v3.12.0
[INFO] Upgraded to v3.12.0
[WARN] Could not find TLS/SSL certificate
[INFO] Run './migrator configure --tls self-signed-cert' to generate a self-signed TLS/SSL certificate
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
[OK] Started on 'https://localhost'
```

#### Offline installation

Get your Migrator offline installation package.
You can get the Migrator Standard Edition [here](https://www.cybertec-postgresql.com/en/products/cybertec-migrator#form) for free.  
 For the Professional or Enterprise Edition [get in touch with us](#contact) to request download credentials.

1. Extract the provided archive file
2. Change working directory to newly created directory
3. Generate default configuration
4. Import container images from archive
5. Generate a self-signed TLS/SSL certificate or install a certificate (see [FAQ](docs/faq.md) for more details)
6. Start the Migrator

```sh
➜ tar xf cybertec_migrator-v3.12.0-standard.tar.gz
➜ cd cybertec_migrator
➜ ./migrator configure
[OK] Generated environment file
[INFO] Run './migrator install' to complete setup
➜ ./migrator install --archive ../cybertec_migrator-v3.12.0-standard.tar.gz
[INFO] Extracting upgrade information
Loaded image: cybertecpostgresql/cybertec_migrator-core:v3.12.0-standard
Loaded image: cybertecpostgresql/cybertec_migrator-web_gui:v3.12.0-standard
Loaded image: postgres:13-alpine
[INFO] Extracted upgrade information
[INFO] Upgraded to v3.12.0-standard
[WARN] Could not find TLS/SSL certificate
[INFO] Run './migrator configure --tls self-signed-cert' to generate a self-signed TLS/SSL certificate
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
[OK] Started on 'https://localhost'
```

## Running the Migrator

Use your web browser to access the Migrator on the URL shown in the terminal with `migrator up`. In our example it would be `https://localhost`.

The configuration provided with this repository starts the CYBERTEC Migrator on the standard HTTPS port.
The `EXTERNAL_HTTP_PORT` variable in the `.env` file (generated by `./migrator configure`) controls the choice of port on which the Migrator is served.

If you don't have access to an Oracle or PostgreSQL database to test the Migrator, use our [Migrator demo database environment](https://github.com/cybertec-postgresql/cybertec_migrator_demo).

### Upgrades

| ⚠️  | Running migrations _will_ be interrupted by applying upgrades |
| --- | ------------------------------------------------------------- |

> **Attention**  
> If you upgrade from a Migrator version previous of 3.11.0 you have to create the TLS/SSL certificate after upgrading to the new version, **before restarting** the new Migrator.
>
> ```sh
> ./migrator update
> ./migrator upgrade
> # Don't forget the create or install a TLS/SSL certificate
> ./migrator configure --tls self-signed-cert
> ./migrator up
> ```

- Online upgrade

  1. Update release information
  2. Upgrade to newest version
  3. Apply upgrade

  <br/>

  ```sh
  ./migrator update
  ./migrator upgrade
  ./migrator up
  ```

- Offline upgrade

  | 💡  | Installation archives also serve for upgrading the Migrator |
  | --- | ----------------------------------------------------------- |

  1. Update release information
  2. Upgrade to version bundled in archive
  3. Apply upgrade

  <br/>

  ```sh
  ./migrator update --archive cybertec_migrator-vX.Y.Z.tar.gz
  ./migrator upgrade --archive cybertec_migrator-vX.Y.Z.tar.gz
  ./migrator up
  ```

## Getting Help

If you have a questions maybe you want to check the [Migrator FAQ](docs/faq.md).
If you can't find the answer there you may have more luck in one of the [existing questions](https://github.com/cybertec-postgresql/cybertec_migrator/issues?q=label%3Aquestion+).

Raising an [issue](https://github.com/cybertec-postgresql/cybertec_migrator/issues/new/choose) is encouraged.
We have templates to report bugs, requesting a new feature or for general questions.

Customers of the paid Migrator license may use the [Migrator Service Desk](https://cybertec.atlassian.net/servicedesk/customer/portal/3/group/-1).

## Contact

- [Sales](https://www.cybertec-postgresql.com/en/contact/)

## License

The content of this repository is under the [MIT License](LICENSE) in case you have to adapt the deployment to your needs.
The CYBERTEC Migrator delivered in the container images uses a proprietary license with an [EULA](EULA.md).
