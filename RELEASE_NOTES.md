## Release Notes

The release notes of the last release may be found on [README.md](README.md#whats-new).

### v3.5.0-rc.2

#### Features

- Several improvements in the execution of a migration:
    - Swap **execution order of *Integrity* and *Logic* stage**.
      Having indices in the Logic stage makes it easier to test performance of views, stored procedures and triggers.
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/change-stage-execution-order.png"></img>
      </p>
    - Move **creation of [check constraints](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-CHECK-CONSTRAINTS) from Logic into Structure stage**.
      Checking the data during the data bulk load is negligible compared to the time needed to re-read the table from disk in the Logic stage.
    - As a consequence, **functions are created in the Structure stage** prior to tables, since they may be used by check constraints.
      The Logic stage re-creates the functions once again still providing the means for fast change-test round-trips.
- The _Migration Overview_ was updated to reflect the changes in the migration execution:
    - It is visible in which order the database objects are created: first schemas, then user defined types, followed by sequences, etc.
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
- Improve handling of implicitly created indices via [Unique Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-UNIQUE-CONSTRAINTS) or [Primary Keys](https://www.postgresql.org/docs/current/ddl-constraints.html#DDL-CONSTRAINTS-PRIMARY-KEYS):
    - Show implicitly created indices in the sidebar and the _Indices_ view. In our example, `dept_id_pk` is shown in the _Constraints_ as well as the _Indices_ section.
    - A hyperlink in the _Indices_ view facilitates navigation to the constraint.
      <p align="center">
          <img src="./docs/pictures/release-notes/v3.5.0/indices-show-unique-indices.png"></img>
      </p>
    - Rename implicitly created indices by renaming its constraint.
- *Log view* shows detailed information about the started migration job:
  <p align="center">
      <img src="./docs/pictures/release-notes/v3.5.0/log.provide-job-information.png"></img>
  </p>
- Improve *Sidebar*:
    - Object Type Filter: add option for User Defined Types (UDT).

#### Resolved Bugs

- Cloning a migration fails due to missing database object in the source database (dropped or renamed table, dropped column, etc.)
- Integrity stage `ERROR: timeout exceeded when trying to connect`
- Integrity stage keeps processing workers after an error even with enabled "Abort stage on first error"
- Resume of an aborted job fails when the Migrator core was forcefully shut down
- Core dump due to repeated, large error message (`warn: Unable to process subpartition ... table not found`)
- Functional index with an expression containing a number was not migrated
- Overview page does now show 0 database links, synonyms, packages

### v3.4.3

This is a bugfix release for [v3.4.0](RELEASE_NOTES.md).

> **Note**: v3.4.1 and v3.4.2 were not released.

#### Resolved Bugs

- Foreign keys are not created in parallel
- Import fails for databases with a view on a view
- Import fails for databases with a partition of a non-imported table (i.e. temporary, secondary, nested, or dropped table)

### v3.4.2

Not released.

### v3.4.1

Not released.

### v3.4.0

The main focus of this release is improving the performance for reading the source database meta-data (we tested databases with approximately 400.000 database objects).
This includes improvements to the GUI to be responsive with a large number of database objects.

> **NOTE**  
> After starting the migrator the dashboard may show an error until the Migrator converted existing migrations in its internal database.
> Depending on the number and size of existing migrations this may take some time.

#### Features

- Reading and analyzing the source database meta-data is now faster
- *Overview page*: drill down to show specific data types
- Improve *Sidebar*:
    - Show number of database objects
    - Add new `Constraints` Object Type filter (`Check`, `Foreign Keys`, and `Unique/Primary Keys`)
    - Add `Disable Partitioning` for multiple tables
- Improve *Search and Replace*
    - Include index names
    - Scope search with sidebar filter
- Highlight element in the table editor when selected in the sidebar or when navigated from the log view
- *Log View*:
    - Scope log entries based on job execution: `ALL`, `CURRENT MIGRATION`, and `LAST EXECUTED JOB`
    - Download content of log view

#### Resolved Bugs

- Creating a migration of a database with a large number of DBOs fails
- Unable to save large configuration changes
- `Partitions` tab not responsive for a table with large number of partitions (>500)
- Resuming data stage results in migrating the data from a different SCN
- Data stage was not aborted properly by user request


### v3.3.0

#### Features

  - Show information of additional Oracle database object types
    - Database links
    - Packages (specification and body)
    - Synonyms
  - Show procedures and functions as separate types (until now both types were shown under `Functions`)
  - Improve data transfer for Oracle `BLOB, CLOB, NCLOB` and `BFILE` columns for rows with big LOBs.
    This may fix out-of-memory errors on the Oracle side, namely `MSG: ORA-01062: unable to allocate memory for define buffer`.
    It also _significantly_ reduces the Migrator memory footprint.
  - The transfer of a row containing a LOB bigger than 500MB will abort with an informative error message.

#### Resolved Bugs

  - Creating a migration of a database with invisible columns causes a failure during meta-data import
    (`null value in column "position" of relation "table_column" violates not-null constraint`)


### v3.2.0

#### Features

- Enhanced migration configuration:
  - Index Renaming  
    Rename indices in case there are naming collisions with other database objects
  - Primary/Unique Key Modification  
    Add, remove and change the order of table columns in a primary/unique key
- Browser Tab Syncing  
  Work on the same migration in multiple browser tabs, with them being synced in real-time
- *Search and Replace* on check constraints and expression indexes
- Usability Improvements
  - Improved sidebar functionalities:
      - Object Type filter: add options for indices, triggers, and sequences
      - Bulk exclude of schemata and tables
  - The tabs in the table editor (Columns, Constraints, etc.) display the identifiers used in the target database
  - Provide examples for source and target connection strings when creating new migrations
  - Performance improvements when running migration jobs
  - Provide more concise error details when writing database objects to the target database (e.g. miss-matching foreign key data-types)

#### Resolved Bugs

  - Creating a migration of a database with a view containing numerous columns causes a failure during meta-data import (`ORA-40478: output value too large (maximum: 4000)`)
  - Creating a migration with an unreachable host shows a non-descriptive error
  - *Replace All* on different database object types sometimes doesn't replace all search results


### v3.1.0

#### Features

- *Search and Replace*  
  Perform bulk changes on column data types / default values, functions, views, and triggers (with support for even more object properties coming soon)

- Significant Speed Improvements  
  **Feel** the difference

- Resume Failed Stages  
  Spend less time fixing those last few migration errors

- Realtime Syntax Checking  
  Get immediate feedback about the syntactical correctness of code

- Partition Renaming  
  Rename partitions as part of a migration instead of altering the source database

- Code Export  
  Export code of function / views / triggers (with code import coming soon)

- Migration Deletion  
  Delete of completed migrations

- Migration Cloning  
  Prepare migrations against your staging environment and then execute them against production

#### Resolved Bugs

- Keys for excluded columns are not excluded automatically
- Column aliases in view code are not migrated
- Migration status is sometimes displayed incorrectly
- Excluding partition columns via the sidebar prevents the Structure stage from succeeding


### v3.0.0

With _CYBERTEC Migrator_ v3 we've rebuilt the GUI from the ground up to simplify database migrations even further

  - Get a brief look at the structure of your source database by using the migration _Overview_
  - Quickly drill down into your data model with the help of the new _Sidebar_
  - Stages (natural synchronization points of a migration process) now guide you through the migration process
      - **Structure** stage: create database objects necessary to migrate the table data
      - **Data** stage: migrate table data in parallel
      - **Logic** stage: create functions, triggers, views
      - **Integrity** stage: parallel creation of primary keys, indices, foreign keys, and constraint checks
  - Enjoy quick round trips and gain confidence in the correctness of your migration thanks to the reworked _Migration Controls_
      - **Start** migration from the beginning
      - **Rerun stage** in case of an error
      - **Continue** to next stage
      - **Abort** migration and restart at any time
  - Explore the inner workings of your migration with the new, and easily accessible _Log View_
      - Log entries are inter-linked to the database objects configuration
      - Filter on log level (`ERROR`, `WARNING`, `INFO`, `VERBOSE`)
  - Extensive configuration
      - Exclude database objects (schemas, tables, columns, indexes, ...) from migration
      - Table editor to configure columns, constraints, indices, triggers, and partitions
      - Bulk change of data types (for example change all `NUMBER(4)` to `int`, instead of `smallint`)
      - Integrated code editor for functions, stored procedures, and views with diff feature
