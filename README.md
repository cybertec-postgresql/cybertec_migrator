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

### v3.5.0-rc.2

#### Features

- Several improvements in the execution of a migration:
    - Swap **execution order of *Integrity* and *Logic* stage**.
      Having indices in the Logic stage makes it easier to test performance of views, stored procedures and triggers
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/change-stage-execution-order.png"></img>
      </p>
    - Move **creation of [check constraints](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS) from Logic into Structure stage**.
      Checking the data during the data bulk load is negligible compared to the time needed to re-read the table from disk in the Logic stage.
    - As consequence **functions are created in the Structure stage**, before the tables, since check constraints may use them.
      The Logic stage re-creates the functions once again still providing the means for fast change-test round-trips.
- The _Migration Overview_ was updated to reflect the changes in the migration execution
    - It is visible in which order the database objects are created: first schemas, then user defined types, then sequences, and so on
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/overview-shows-stage-execution.png"></img>
      </p>
    - Provide drill down on _Indices_ entry to show the number of unique indices. We will enrich the _Migration Overview_ with additional information in future releases.
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/overview-show-unique-indices.png"></img>
      </p>
- Enhance migration configuration:
    - Constraint Renaming  
      Rename constraints in case there are naming collisions with other database objects.
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/constraints-rename.png"></img>
      </p>
- Improve handling of implicitly created indices via [Unique Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-UNIQUE-CONSTRAINTS) or [Primary Keys](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-PRIMARY-KEYS)
    - Show implicitly created indices in the sidebar, and the _Indices_ view. In our example `dept_id_pk` is shown in the _Constraints_ as well as in the _Indices_ section.
    - A hyperlink in the _Indices_ view facilitates navigation to the constraint
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/indices-show-unique-indices.png"></img>
      </p>
    - Rename implicitly created indices by renaming its constraint
- *Log view* shows detailed information about the started migration job
  <p align="center">
      <img src="./docs/pictures/release-notes/v3.5.0/log.provide-job-information.png"></img>
  </p>
- Improve *Sidebar*:
    - Object Type filter: add option for User Defined Types (UDT)

#### Resolved Bugs

- Cloning a migration fails due to missing database object in the source database (dropped or renamed table, dropped column, etc.)
- Integrity stage `ERROR: timeout exceeded when trying to connect`
- Integrity stage keeps processing workers after an error even with enabled "Abort stage on first error"
- Resume of an aborted job fails when the Migrator core was forcefully shut down
- Core dump due to repeated, large error message (`warn: Unable to process subpartition ... table not found`)
- Functional index with an expression containing a number was not migrated
- Overview page does now show 0 database links, synonyms, packages

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
