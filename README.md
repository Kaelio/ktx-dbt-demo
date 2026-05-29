# klo-dbt-demo

A demo dbt project showcasing Orbit analytics models.

This project builds views in the `orbit_analytics` schema from raw source tables in
`orbit_raw`.

## Project Layout

- `models/staging/` - typed views over raw source tables
- `models/intermediate/` - reusable business logic
- `models/marts/` - analytics-ready reporting views
- `models/schema.yml` - model and column tests
- `models/sources.yml` - raw source table definitions
- `tests/` - custom data tests

## Running dbt

Set the Postgres connection environment variables:

```bash
export KAELIO_DEMO_PG_HOST=...
export KAELIO_DEMO_PG_PORT=5432
export KAELIO_DEMO_PG_DATABASE=demo
export KAELIO_DEMO_PG_USER=...
export KAELIO_DEMO_PG_PASSWORD=...
```

Run dbt with the Postgres adapter:

```bash
uvx --from dbt-core --with dbt-postgres dbt compile --project-dir . --profiles-dir .
uvx --from dbt-core --with dbt-postgres dbt run --project-dir . --profiles-dir .
uvx --from dbt-core --with dbt-postgres dbt test --project-dir . --profiles-dir .
```

`dbt run` requires a database user that can create and replace views in
`orbit_analytics`.

## Generated Files

dbt creates local runtime files such as `target/`, `logs/`, `.user.yml`, and
`dbt_packages/`. These are intentionally ignored and should not be committed.
