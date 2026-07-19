# 📸 Snapshots

## Overview

The **Snapshots** directory is used to preserve the historical state of records over time using dbt's built-in snapshot functionality.

Unlike standard dbt models that overwrite data during each run, snapshots track changes in source records and maintain a complete history of updates. This enables historical reporting, auditing, and Slowly Changing Dimension (SCD Type 2) analysis.

---

## Objectives

- Preserve historical data
- Track changes to dimension records
- Enable Slowly Changing Dimensions (SCD Type 2)
- Support auditing and historical reporting
- Maintain a complete record history

---

## Snapshot Model

| Snapshot | Description |
|----------|-------------|
| customers_snapshot | Tracks historical changes to customer records, preserving previous versions whenever monitored attributes change. |

---

## Snapshot Strategy

This project uses the **Check Strategy**.

The snapshot compares specified columns during each execution.

If any monitored column changes:

- The existing record is closed.
- A new version of the record is created.
- Historical data is preserved.

---

## Snapshot Metadata

Each snapshot record contains dbt-generated metadata columns:

| Column | Description |
|---------|-------------|
| dbt_valid_from | Timestamp when the record version became active |
| dbt_valid_to | Timestamp when the record version expired (NULL indicates the current version) |
| dbt_updated_at | Timestamp when dbt detected the change |
| dbt_scd_id | Unique identifier for the versioned record |

---

## Running Snapshots

Execute snapshots using:

```bash
dbt snapshot
```

To view snapshot records:

```sql
SELECT *
FROM ANALYTICS_MARTS.CUSTOMERS_SNAPSHOT;
```

---

## Example

### Original Record

| Customer ID | City | State |
|-------------|------|-------|
| C001 | São Paulo | SP |

---

### After an Update

If the customer's city changes to **Campinas**, the snapshot preserves both versions.

| Customer ID | City | dbt_valid_from | dbt_valid_to |
|-------------|------|----------------|--------------|
| C001 | São Paulo | 2024-01-01 | 2024-08-15 |
| C001 | Campinas | 2024-08-15 | NULL |

This allows analysts to answer questions such as:

- What was the customer's location at a specific point in time?
- How have customer records changed historically?
- Which records have been updated over time?

---

## Business Benefits

Using snapshots enables:

- Historical customer analysis
- Change tracking
- Data auditing
- Slowly Changing Dimension (SCD Type 2) implementation
- Time-travel reporting
- Improved data governance

---

## Why Snapshots?

Traditional dbt models overwrite existing data during every run, causing previous values to be lost.

Snapshots solve this by maintaining historical versions of records, making them invaluable for production-grade analytics projects where historical accuracy is essential.

---

## Layer Output

The snapshots layer provides historical versions of records that can be used for auditing, trend analysis, compliance reporting, and Slowly Changing Dimension (SCD Type 2) implementations without affecting the analytical models in the marts layer.