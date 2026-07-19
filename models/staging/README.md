# 🥉 Staging Layer

## Overview

The **Staging layer** is the first transformation layer in the dbt project. Its primary purpose is to clean, standardize, and prepare raw data from Snowflake without altering the underlying business logic.

This layer acts as the foundation for all downstream models by ensuring that every dataset has consistent naming conventions, data types, and quality checks.

---

## Objectives

- Standardize column names
- Clean raw text fields
- Preserve original business data
- Improve readability
- Apply data quality tests
- Create a reliable base for intermediate models

---

## Source Tables

The staging layer consumes data directly from the **RAW** schema.

| Source Table | Staging Model |
|--------------|---------------|
| customers | stg_customers |
| orders | stg_orders |
| order_items | stg_order_items |
| payments | stg_payments |
| products | stg_products |
| sellers | stg_sellers |
| reviews | stg_reviews |
| geolocation | stg_geolocations |
| category_translations | stg_category_translations |

---

## Transformations Performed

The staging models perform lightweight transformations, including:

- Renaming columns using consistent snake_case naming
- Removing unnecessary columns
- Cleaning text fields using reusable macros
- Standardizing city and state values
- Casting columns to appropriate data types
- Creating a consistent schema across all datasets

No business calculations or aggregations are performed in this layer.

---

## Data Quality Tests

The staging layer includes automated dbt tests to ensure data integrity.

### Generic Tests

- `unique`
- `not_null`
- `unique_combination_of_columns`

### Custom Tests

- Positive value validation
- Non-zero payment validation
- Valid review score checks

These tests help detect missing values, duplicate records, and invalid data before downstream transformations.

---

## Documentation

Every staging model includes:

- Model descriptions
- Column descriptions
- Data quality tests
- Source lineage

This enables dbt Docs to automatically generate searchable documentation.

---

## Materialization

All staging models are materialized as **Views**.

### Why Views?

- No additional storage cost
- Always reflects the latest raw data
- Faster development iterations
- Simplified maintenance

---

## Layer Output

The staging layer produces clean, standardized datasets that are consumed by the **Intermediate Layer**, where business logic and data enrichment are applied.