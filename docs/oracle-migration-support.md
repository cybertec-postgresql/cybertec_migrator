# Supported features for migration from Oracle

Supported features of the [CYBERTEC Migrator](../README.md).

## Database Object Types

| CREATE            |    | Comment                                                    |
|-------------------|----|------------------------------------------------------------|
| DATABASE LINK     | ✅ | visible, use PostgreSQL [Foreign Data Wrapper]             |
| DIRECTORY         | ❌ |                                                            |
| FUNCTION          | ✅ | code needs to be translated manually                       |
| INDEX             | ✅ |                                                            |
| MATERIALIZED VIEW | ✅ |                                                            |
| PACKAGE           | ✅ | package code visible, code needs to be translated manually |
| PROCEDURE         | ✅ | code needs to be translated manually                       |
| SCHEMA            | ✅ |                                                            |
| SEQUENCE          | ✅ |                                                            |
| SYNONYMS          | ✅ | visible, have to be migrated manually                      |
| TABLE             | ✅ | partitions (hash, list, range) supported                   |
| TRIGGER           | ✅ |                                                            |
| TYPE              | ✅ |                                                            |
| USER              | ❌ |                                                            |
| VIEW              | ✅ |                                                            |

## Built-In Data Types

Detailed information about Oracle built-in data types may be found in the [Oracle SQL Language Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/Data-Types.html#GUID-7B72E154-677A-4342-A1EA-C74C1EA928E6).

<table class="inline">
    <tr>
        <td></td>
        <td colspan="2"><strong>Oracle</strong></td>
        <td colspan="2"><strong>PostgreSQL</strong></td>
    </tr>
    <tr>
        <td>1</td>
        <td>BFILE</td>
        <td>External LOB</td>
        <td colspan="2">BYTEA (⏳ Coming soon)</td>
    </tr>
    <tr>
        <td>2</td>
        <td>BINARY_FLOAT</td>
        <td>32-bit floating-point number</td>
        <td colspan="2">REAL</td>
    </tr>
    <tr>
        <td>3</td>
        <td>BINARY_DOUBLE</td>
        <td>64-bit floating-point number</td>
        <td colspan="2">DOUBLE PRECISION</td>
    </tr>
    <tr>
        <td>4</td>
        <td>BLOB</td>
        <td>Binary large object, ⇐ 4G ⚠️</td>
        <td colspan="2">BYTEA</td>
    </tr>
    <tr>
        <td>5</td>
        <td>CHAR(<em>n</em>), CHARACTER(<em>n</em>)</td>
        <td>Fixed-length string, 1 ⇐ <em>n</em> ⇐ 2000</td>
        <td colspan="2">CHAR(<em>n</em>), CHARACTER(<em>n</em>)</td>
    </tr>
    <tr>
        <td>6</td>
        <td>CLOB</td>
        <td>Character large object, ⇐ 4G ⚠️</td>
        <td colspan="2">TEXT</td>
    </tr>
    <tr>
        <td>7</td>
        <td>DATE</td>
        <td>Date and time</td>
        <td colspan="2">TIMESTAMP(0)</td>
    </tr>
    <tr>
        <td>8</td>
        <td>DECIMAL(<em>p,s</em>), DEC(<em>p,s</em>)</td>
        <td>Fixed-point number</td>
        <td colspan="2">DECIMAL(<em>p,s</em>), DEC(<em>p,s</em>)</td>
    </tr>
    <tr>
        <td>9</td>
        <td>DOUBLE PRECISION</td>
        <td>Floating-point number</td>
        <td colspan="2">DOUBLE PRECISION</td>
    </tr>
    <tr>
        <td>10</td>
        <td>FLOAT(<em>p</em>)</td>
        <td>Floating-point number</td>
        <td colspan="2">DOUBLE PRECISION</td>
    </tr>
    <tr>
        <td>11</td>
        <td>INTEGER, INT</td>
        <td>38 digits integer</td>
        <td colspan="2">DECIMAL(38)</td>
    </tr>
    <tr>
        <td>12</td>
        <td>INTERVAL YEAR(<em>p</em>) TO MONTH</td>
        <td>Date interval</td>
        <td colspan="2">INTERVAL YEAR TO MONTH</td>
    </tr>
    <tr>
        <td>13</td>
        <td>INTERVAL DAY(<em>p</em>) TO SECOND(<em>s</em>)</td>
        <td>Day and time interval</td>
        <td colspan="2">INTERVAL DAY TO SECOND(<em>s</em>)</td>
    </tr>
    <tr>
        <td>14</td>
        <td>LONG</td>
        <td>Character data, ⇐ 2G ⚠️</td>
        <td colspan="2">TEXT</td>
    </tr>
    <tr>
        <td>15</td>
        <td>LONG RAW</td>
        <td>Binary data, ⇐ 2G</td>
        <td colspan="2">BYTEA</td>
    </tr>
    <tr>
        <td>16</td>
        <td>NCHAR(<em>n</em>)</td>
        <td>Fixed-length UTF-8 string, 1 ⇐ <em>n</em> ⇐ 2000</td>
        <td colspan="2">CHAR(<em>n</em>) ⚠️</td>
    </tr>
    <tr>
        <td>17</td>
        <td>NCHAR VARYING(<em>n</em>)</td>
        <td>Varying-length UTF-8 string, 1 ⇐ <em>n</em> ⇐ 4000</td>
        <td colspan="2">VARCHAR(<em>n</em>) ⚠️</td>
    </tr>
    <tr>
        <td>18</td>
        <td>NCLOB</td>
        <td>Variable-length Unicode string, ⇐ 4G ⚠️</td>
        <td colspan="2">TEXT</td>
    </tr>
    <tr>
        <td rowspan="5">19</td>
        <td rowspan="5">NUMBER(<em>p</em>,0), NUMBER(<em>p</em>)</td>
        <td>8-bit integer, 1 &lt;= <em>p</em> &lt; 3</td>
        <td colspan="2">SMALLINT</td>
    </tr>
    <tr>
        <td>16-bit integer, 3 &lt;= <em>p</em> &lt; 5</td>
        <td colspan="2">SMALLINT</td>
    </tr>
    <tr>
        <td>32-bit integer, 5 &lt;= <em>p</em> &lt; 9</td>
        <td colspan="2">INT</td>
    </tr>
    <tr>
        <td>64-bit integer, 9 &lt;= <em>p</em> &lt; 19</td>
        <td colspan="2">BIGINT</td>
    </tr>
    <tr>
        <td>Fixed-point number, 19 &lt;= <em>p</em> &lt;= 38</td>
        <td colspan="2">DECIMAL(<em>p</em>)</td>
    </tr>
    <tr>
        <td>20</td>
        <td>NUMBER(<em>p,s</em>)</td>
        <td>Fixed-point number, s &gt; 0</td>
        <td colspan="2">DECIMAL(<em>p,s</em>)</td>
    </tr>
    <tr>
        <td>21</td>
        <td>NUMBER, NUMBER(*)</td>
        <td>Floating-point number</td>
        <td colspan="2">DOUBLE PRECISION</td>
    </tr>
    <tr>
        <td>22</td>
        <td>NUMERIC(<em>p,s</em>)</td>
        <td>Fixed-point number</td>
        <td colspan="2">NUMERIC(<em>p,s</em>)</td>
    </tr>
    <tr>
        <td>23</td>
        <td>NVARCHAR2(<em>n</em>)</td>
        <td>Varying-length UTF-8 string, 1 ⇐ <em>n</em> ⇐ 4000</td>
        <td colspan="2">VARCHAR(<em>n</em>) ⚠️</td>
    </tr>
    <tr>
        <td>24</td>
        <td>RAW(n)</td>
        <td>Variable-length binary string, 1 ⇐ n ⇐ 2000</td>
        <td colspan="2">BYTEA</td>
    </tr>
    <tr>
        <td>25</td>
        <td>REAL</td>
        <td>Floating-point number</td>
        <td colspan="2">DOUBLE PRECISION</td>
    </tr>
    <tr>
        <td>26</td>
        <td>ROWID</td>
        <td>Physical row addresses</td>
        <td colspan="2">CHAR(10) (⏳ Not automated yet)</td>
    </tr>
    <tr>
        <td>27</td>
        <td>SMALLINT</td>
        <td>38 digits integer</td>
        <td colspan="2">DECIMAL(38)</td>
    </tr>
    <tr>
        <td>28</td>
        <td>TIMESTAMP(<em>p</em>)</td>
        <td>Date and time with fraction</td>
        <td colspan="2">TIMESTAMP(<em>p</em>)</td>
    </tr>
    <tr>
        <td>29</td>
        <td>TIMESTAMP(<em>p</em>) WITH TIME ZONE</td>
        <td>Date and time with fraction and time zone</td>
        <td colspan="2">TIMESTAMP(<em>p</em>) WITH TIME ZONE</td>
    </tr>
    <tr>
        <td>30</td>
        <td>UROWID(<em>n</em>)</td>
        <td>Logical row addresses, 1 ⇐ <em>n</em> ⇐ 4000</td>
        <td colspan="2">VARCHAR(<em>n</em>) (⏳ Not automated yet)</td>
    </tr>
    <tr>
        <td>31</td>
        <td>VARCHAR(<em>n</em>)</td>
        <td>Variable-length string, 1 ⇐ <em>n</em> ⇐ 4000</td>
        <td colspan="2">VARCHAR(<em>n</em>)</td>
    </tr>
    <tr>
        <td>32</td>
        <td>VARCHAR2(<em>n</em>)</td>
        <td>Variable-length string, 1 ⇐ <em>n</em> ⇐ 4000</td>
        <td colspan="2">VARCHAR(<em>n</em>)</td>
    </tr>
    <tr>
        <td>33</td>
        <td>XMLTYPE</td>
        <td>XML data</td>
        <td colspan="2">XML</td>
    </tr>
</table>
