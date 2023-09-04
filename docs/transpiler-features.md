# Transpiler Features

The CYBERTEC Migrator is able to parse PL/SQL code, analyze it and transpile it to PL/pgSQL.
\
Each supported construct is represented by a corresponding rule.

This feature-set is under ongoing development, adding new rules wherever possible.
If you have a suggestion for a new rule, please open a [feature request](https://github.com/cybertec-postgresql/cybertec_migrator/issues/new?assignees=&labels=feature+request&template=feature_request.yml).

## Rules

### CYAR-0001: `AddParamlistParentheses`

In Oracle, a procedure without parameters may omit parentheses in its definition, whereas PostgreSQL always requires them.

#### Example

```sql
-- PL/SQL
CREATE PROCEDURE proc   IS ...;
-- PL/pgSQL
CREATE PROCEDURE proc() IS ...;
```

### CYAR-0002: `ReplacePrologue`

The bodies of Oracle's functions and procedures are initiated with `IS|AS BEGIN ...`, and have to be adapted to
PostgreSQL's `AS $$ ...`.

#### Example

```sql
-- PL/SQL
CREATE PROCEDURE proc IS    BEGIN ...;
-- PL/pgSQL
CREATE PROCEDURE proc AS $$ BEGIN ...;
```

### CYAR-0003: `ReplaceEpilogue`

As the counterpart to [CYAR-0002](#cyar-0002-replaceprologue), this replaces the epilogue of Oracle functions and
procedures, stripping the optional block identifier and specifying the `LANGAGE`.

#### Example

```sql
-- PL/SQL
CREATE PROCEDURE proc IS BEGIN ... END;
-- PL/pgSQL
CREATE PROCEDURE proc IS BEGIN ... END proc; $$ LANGUAGE plpgsql;
```


### CYAR-0004: `FixTrunc`

Transpiles usages of Oracle's `trunc()` function based on the argument type.

> Note: This rule is not yet implemented.

### CYAR-0005: `ReplaceSysdate`

Transpiles [Oracle's `SYSDATE`](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/SYSDATE.html#GUID-807F8FC5-D72D-4F4D-B66D-B0FE1A8FA7D2),
which returns the current time of the operating system (as opposed to statement or transaction timestamp), to
[PostgreSQL's `clock_timestamp()`](https://www.postgresql.org/docs/current/functions-datetime.html).

#### Example

```sql
-- PL/SQL
SELECT sysdate           FROM dual;
-- PL/pgSQL
SELECT clock_timestamp() FROM dual;
```

### CYAR-0006: `ReplaceNvl`

Replaces [Oracle's `NVL`](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/NVL.html#GUID-3AB61E54-9201-4D6A-B48A-79F4C4A034B2)
with [PostgreSQL's `coalesce`](https://www.postgresql.org/docs/current/functions-conditional.html#FUNCTIONS-COALESCE-NVL-IFNULL).

#### Example

```sql
-- PL/SQL
SELECT nvl(dummy, 'null')      FROM dual;
-- PL/pgSQL
SELECT coalesce(dummy, 'null') FROM dual;
```


### CYAR-0007: `RemoveEditionable`

As PostgreSQL does not have the concept of editioning, the `EDITIONABLE` and `NONEDITIONABLE` keywords of functions
and procedures are omitted.

#### Example

```sql
-- PL/SQL
CREATE EDITIONABLE PROCEDURE proc ...;
-- PL/pgSQL
CREATE             PROCEDURE proc ...;
```

### CYAR-0008: `ReplaceNvl2`

Replaces [Oracle's `NVL2`](https://docs.oracle.com/en/database/oracle/oracle-database/23/sqlrf/NVL2.html#GUID-414D6E81-9627-4163-8AC2-BD24E57742AE)
with a `CASE` statement.

#### Example

```sql
-- PL/SQL
SELECT NVL2(dummy, 1, 2)                             FROM dual;
-- PL/pgSQL
SELECT CASE WHEN dummy IS NOT NULL THEN 1 ELSE 2 END FROM dual;
```
