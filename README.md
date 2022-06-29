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
Then [get the Migrator Standard Edition](https://www.cybertec-postgresql.com/en/products/cybertec-migrator#form),  a __free version__ of the CYBERTEC Migrator, follow the offline instructions provided in [Getting Started](#offline-installation) section, and try it out.

<br/>

<p align="center">
  <a href="https://www.youtube.com/watch?v=z79_lZHmDG4&t=0s"><img alt="CYBERTEC Migrator v3 Demonstration" width="384px" src="http://img.youtube.com/vi/8hSrFVOw3Rc/0.jpg"/></a><br/>
  <b>Product Demo</b>
</p>

---

For detailed information see the list of [supported migration features for Oracle](docs/oracle-migration-support.md).

## Table of Contents

1. [What's New](#whats-new)
2. [Getting Started](#getting-started)
3. [Running the Migrator](#running-the-migrator)
4. [Getting Help](#getting-help)
5. [Contact](#contact)
6. [License](#license)

## What's New

For older releases see [Release Notes](RELEASE_NOTES.md).

### v3.8.0 - 2022-06-29

#### Features

- Configure the maximal number of parallel data transfers and index creation workers for each migration.  
  The Migrator picks reasonable default values when a new migration is created:
  - `Data Tranfers`: number of CPUs where the Migrator is hosted
  - `Database Workers`: number of CPUs of the target database. Make sure to tune this parameter with the PostgreSQL configuration of [max_worker_processes, max_parallel_workers, max_parallel_maintenance_workers](https://www.postgresql.org/docs/current/runtime-config-resource.html)
  <p align="left">
      <img src="./docs/pictures/release-notes/v3.8.0/settings-parallel-workers.png"></img>
  </p>
- Enhance sidebar: show synonym meta-data as pop-up
  <p align="left">
      <img src="./docs/pictures/release-notes/v3.8.0/sidebar-shows-synonym-meta-data.png"></img>
  </p>
- Set/clear object type filter by selecting an `Object Type` in the overview tab. Use the `CTRL` key to filter for more than one database object type.
  <p align="left">
      <img src="./docs/pictures/release-notes/v3.8.0/set-object-type-filter-from-overview-tab.png"></img>
  </p>
- Add [issue templates](https://github.com/cybertec-postgresql/cybertec_migrator/issues/new/choose) for asking questions.

#### Resolved Bugs

* Empty connection check error message on `504 Gateway Time-Out`
* Broken GUI workflow in the Analyze step on `504 Gateway Time-Out`
* Error on migrating `REVERSE` indexes: PostgreSQL does not have/need an equivalent feature
* Opening a non-existent migration endlessly shows the loading animation
* Error on migrating sequences with negative `INCREMENT` - `START value cannot be greater than MAXVALUE`
* Migration controls (resume, continue, etc.) occasionally do not behave as expected
* Views depending on other views are not created in the correct order
* Spacing between the migration log time and level is jumping
* Incorrect name conflict detection for tables and triggers with the same identifier

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
  5. Start the Migrator

  ```sh
  ➜ git clone https://github.com/cybertec-postgresql/cybertec_migrator
  ➜ cd cybertec_migrator
  ➜ ./migrator configure
  [OK] Generated environment file
  [INFO] Run './migrator install' to complete setup
  ➜ ./migrator install
  [INFO] Pulling v3.7.0
  Pulling core_db ... done
  Pulling core    ... done
  Pulling web_gui ... done
  [OK] Pulled v3.7.0
  [INFO] Upgraded to v3.7.0
  [INFO] Run './migrator up' to switch to new version
  [WARN] Switching will abort running migrations
  ➜ ./migrator up
  Creating network "cybertec_migrator-network" with the default driver
  Creating cybertec_migrator_core_db_1 ... done
  Creating cybertec_migrator_core_1    ... done
  Creating cybertec_migrator_web_gui_1 ... done
  [OK] Started on 'http://localhost'
  ```

#### Offline installation

  Get your Migrator offline installation package.
  You can get the Migrator Standard Edition [here](https://www.cybertec-postgresql.com/en/products/cybertec-migrator#form) for free.  
  For the Professional or Enterprise Edition [get in touch with us](#contact) to request download credentials.

  1. Extract the provided archive file
  2. Change working directory to newly created directory
  3. Generate default configuration
  4. Import container images from archive
  5. Start the Migrator

  ```sh
  ➜ tar xf cybertec_migrator-v3.7.0-standard.tar.gz
  ➜ cd cybertec_migrator
  ➜ ./migrator configure
  [OK] Generated environment file
  [INFO] Run './migrator install' to complete setup
  ➜ ./migrator install --archive ../cybertec_migrator-v3.7.0-standard.tar.gz
  [INFO] Extracting upgrade information
  Loaded image: cybertecpostgresql/cybertec_migrator-core:v3.7.0-standard
  Loaded image: cybertecpostgresql/cybertec_migrator-web_gui:v3.7.0-standard
  Loaded image: postgres:13-alpine
  [INFO] Extracted upgrade information
  [INFO] Upgraded to v3.7.0-standard
  [INFO] Run './migrator up' to switch to new version
  [WARN] Switching will abort running migrations
  ➜ ./migrator up
  Creating network "cybertec_migrator-network" with the default driver
  Creating cybertec_migrator_core_db_1 ... done
  Creating cybertec_migrator_core_1    ... done
  Creating cybertec_migrator_web_gui_1 ... done
  [OK] Started on 'http://localhost'
  ```

## Running the Migrator

Use your web browser to access the Migrator on the URL shown in the terminal with `migrator up`. In our example it would be `http://localhost`.

The configuration provided with this repository starts the CYBERTEC Migrator over HTTP. The `EXTERNAL_HTTP_PORT` variable in the `.env` file (generated by `./migrator configure`) controls the choice of port on which the Migrator is served.

The configuration is __not meant to be used in production environment__.
Adapt the NGINX configuration in `docker/templates/default.conf.template` to your needs to run the service on HTTPS with proper credentials.

If you don't have access to an Oracle or PostgreSQL database to test the Migrator, use our [Migrator demo database environment](https://github.com/cybertec-postgresql/cybertec_migrator_demo).

### Upgrades

| ⚠️   | Running migrations _will_ be interrupted by applying upgrades |
| --- | ------------------------------------------------------------- |

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

Raising an [issue](https://github.com/cybertec-postgresql/cybertec_migrator/issues/new/choose) is encouraged.
We have templates to report bugs, requesting a new feature or for general questions.

## Contact

- [Sales](https://www.cybertec-postgresql.com/en/contact/)

## License

The content of this repository is under the [MIT License](LICENSE) in case you have to adapt the deployment to your needs.
The CYBERTEC Migrator delivered in the container images uses a proprietary license with an [EULA](EULA.md).
