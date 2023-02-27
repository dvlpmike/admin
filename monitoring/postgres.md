# Postgres

## Get the size of the database tables
```sql
-- For cli
SELECT nspname || '.' || relname AS "relation", pg_size_pretty(pg_total_relation_size(C.oid)) AS "total_size" FROM pg_class C LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace) WHERE nspname NOT IN ('pg_catalog', 'information_schema') AND C.relkind <> 'i' AND nspname !~ '^pg_toast' ORDER BY pg_total_relation_size(C.oid) DESC;
```
## Run the Sql query and save the results as a csv file
```sh
psql -U <database_user> -d <database_name> -F ',' -A -o results.csv query.sql
```
## Vacuum
Path to config file `/var/lib/pgsql/12/data/postgresql.conf`
```sql
-- VACUUM FULL
VACUUM FULL;

-- Analyze
VACUUM ANALYZE;

-- For specific table
VACUUM my_table;

-- For specific table and analyze
VACUUM ANALYZE my_table;

-- For specific table with options
VACUUM (VERBOSE, ANALYZE) my_table;

-- For specific database
VACUUM DATABASE my_database;

-- For specific database with options
VACUUM (VERBOSE, ANALYZE) my_database;

-- For all databases
VACUUM (VERBOSE, ANALYZE) ALL;

-- Check if vacuum has already been done
SELECT schemaname, relname, last_vacuum, last_autovacuum, vacuum_count, autovacuum_count, last_analyze, last_autoanalyze FROM pg_stat_user_tables;

-- Get online vacuum
SELECT * FROM pg_stat_progress_vacuum;

```
