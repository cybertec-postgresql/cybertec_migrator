## Release Notes

The release notes of the last release may be found on [README.md](README.md#whats-new).

- `v3.2.0`

  **Features**

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
    - The different tabs in the table editor (Columns, Constraints, etc.) display the identifiers used in the target database
    - Provide examples for source and target connection strings when creating new migrations
    - Performance improvements when running migration jobs
    - Provide more concise error details when writing database objects to the target database (e.g. miss-matching foreign key data-types)

  **Resolved Bugs**

  - Creating a migration of a database with a view with numerous columns causes a failure during meta-data import (`ORA-40478: output value too large (maximum: 4000)`)
  - Creating a migration with an unreachable host shows a non-descriptive error
  - *Replace All* on different database object types sometimes doesn't replace all search results

- `v3.1.0`

  **Features**

    - Search and Replace  
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

  **Resolved Bugs**

    - Keys for excluded columns are not excluded automatically
    - Column aliases in view code are not migrated
    - Migration status is sometimes displayed incorrectly
    - Excluding partition columns via the sidebar prevents the Structure stage from succeeding

- `v3.0.0`

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
