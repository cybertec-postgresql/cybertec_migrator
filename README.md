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

<br/>

<p align="center">
  <a href="http://www.youtube.com/watch?v=8hSrFVOw3Rc"><img alt="CYBERTEC Migrator v3 Demonstration" width="384px" src="http://img.youtube.com/vi/8hSrFVOw3Rc/0.jpg"/></a><br/>
  <b>Product Demo</b>
</p>

---

For detailed information see the list of [supported migration features for Oracle](docs/oracle-migration-support.md).

## Table of Contents

1. [What's New](#whats-new)
2. [Getting Started](#getting-started)
3. [Running the Migrator](#running-the-migrator)
4. [Contact](#contact)

## What's New

For older releases see [Release Notes](RELEASE_NOTES.md).

### v3.6.0 - 2022-04-26

#### Features

- Add support for __stage post-hook SQL scripts__ to adapt the migration with functionalities not provided by the Migrator.
  The scripts are executed at the end of a stage.
  Typical use cases for such scripts are to create database objects which are not present in the source database, or to define ownership and access permissions.
    - Add a stage post-hook script in the _Stages Tab_.
      <p align="left">
          <img src="./docs/pictures/release-notes/v3.6.0/stage-post-hook-scripts.png"></img>
      </p>
    - Editor for stage hook scripts. It is possible to temporary disable a hook script.
      <p align="left">
          <img src="./docs/pictures/release-notes/v3.6.0/stage-post-hook-script-editor.png"></img>
      </p>
    - The execution of the stage post-hook scripts are __logged for audit purposes__.
      <p align="left">
          <img src="./docs/pictures/release-notes/v3.6.0/stage-post-hook-script-logging.png"></img>
      </p>
- Improve _Data stage_: __partitions and sub-partitions__ of partitioned tables are __migrated in parallel__.
- Support migration of `GENERATED AS IDENTITY` constraint.
- Improve user experience:
    - Code editors verify DDL code to provide fast error feedback.
      <p align="left">
          <img src="./docs/pictures/release-notes/v3.6.0/editor-code-verification.png"></img>
      </p>
    - Receive browser tab notification when a migration job finished.
    - Add keyboard hotkey `Ctrl`-`Enter` to start migration job execution.

#### Resolved Bugs

- Failed to created migration of an Oracle database containing a column that uses a data-type from the `SYS` schema
- Starting a migration job with more than one stage and incorrect target connection bricks the migration
- Sidebar filter showing schemas that contain none of the filter results
- Misleading console log entries `No metadata found. There is more than once class-validator version installed probably ...`

## Getting Started

### Requirements

_CYBERTEC Migrator_ is distributed as a set of [Docker](https://www.docker.com/) images that are brought up by [Docker Compose](https://docs.docker.com/compose/).

- [`docker`](https://docs.docker.com/get-docker/)
- [`docker-compose`](https://docs.docker.com/compose/install/) (`>= 1.27.0`)
- `git` (`>= 2.20.1`)
- `bash` (`>= 4.0`)

### Obtaining Images

_CYBERTEC Migrator_ images can be obtained through Docker Hub.  
An offline installation package is also available for environments in which networking restrictions are imposed.

- Docker Hub  
  Please [get in touch with us](#contact) if your account has not been granted access to the respective images.

  ```sh
  cat ~/password.txt | docker login --username <username> --password-stdin
  ```

- Offline installation package  
  Please [get in touch with us](#contact) to request download credentials.

### Setup

- Online installation

  1. Clone the repository
  2. Change directory into cloned repository
  3. Generate default configuration
  4. Download images

  <br/>

  ```sh
  git clone https://github.com/cybertec-postgresql/cybertec_migrator
  cd cybertec_migrator
  ./migrator configure
  ./migrator install
  ```

- Offline installation

  | 💡  | Installation archives also serve as upgrade archives |
    | --- | ---------------------------------------------------- |

  1. Extract the provided archive file
  2. Change directory to the directory created in the previous step
  3. Generate default configuration
  4. Import images from archive

  <br/>

  ```sh
  tar xf cybertec_migrator-vX.Y.Z.tar.gz
  cd cybertec_migrator
  ./migrator configure
  ./migrator install --archive ../cybertec_migrator-vX.Y.Z.tar.gz
  ```

## Running the Migrator

```sh
./migrator up
```

CYBERTEC Migrator only supports connections via HTTP.

The `EXTERNAL_HTTP_PORT` variable in the `.env` file (generated by `./migrator configure`) controls the choice of port on which the Migrator is served.

### Upgrades

| ⚠️  | Running migrations _will_ be interrupted by applying upgrades |
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

  1. Update release information
  2. Upgrade to version bundled in archive
  3. Apply upgrade

  <br/>

  ```sh
  ./migrator update --archive cybertec_migrator-vX.Y.Z.tar.gz
  ./migrator upgrade --archive cybertec_migrator-vX.Y.Z.tar.gz
  ./migrator up
  ```

## Contact

- [Sales](https://www.cybertec-postgresql.com/en/contact/)
- [Report Bug](https://cybertec.atlassian.net/servicedesk/customer/portal/3/group/4/create/23)
