# 🌱 Seeds

## Overview

The **Seeds** directory contains static reference datasets that are loaded into Snowflake using the `dbt seed` command. These CSV files provide lookup information that enriches the analytical models without requiring external joins or manual data entry.

Unlike source tables, seed files are version-controlled alongside the project, ensuring consistency, reproducibility, and easier maintenance.

---

## Objectives

- Store static reference data within the project
- Standardize business terminology
- Improve data readability
- Enrich analytical models
- Eliminate hardcoded mappings in SQL

---

## Seed Files

| Seed File | Description |
|-----------|-------------|
| state_mapping.csv | Maps Brazilian state abbreviations (e.g., SP, RJ) to their full state names (São Paulo, Rio de Janeiro, etc.). |
| category_groups.csv | Groups individual product categories into broader business-friendly product segments for simplified reporting and analysis. |

---

## Usage

Seed files are loaded into Snowflake using:

```bash
dbt seed
```

To reload the seed after making changes:

```bash
dbt seed --full-refresh
```

---

## Business Applications

### state_mapping.csv

Used to:

- Convert state abbreviations into readable names
- Improve dashboard readability
- Standardize geographic reporting
- Support seller and customer location analysis

Example:

| State Code | State Name |
|------------|------------|
| SP | São Paulo |
| RJ | Rio de Janeiro |
| MG | Minas Gerais |

---

### category_groups.csv

Used to:

- Group similar product categories
- Simplify dashboard visualizations
- Reduce category fragmentation
- Enable higher-level product performance analysis

Example:

| Product Category | Category Group |
|------------------|----------------|
| bed_bath_table | Home & Living |
| computers_accessories | Electronics |
| health_beauty | Health & Beauty |

---

## Benefits

Using seed files provides several advantages:

- Version-controlled reference data
- Easy maintenance
- Consistent business definitions
- Reusable lookup tables
- Improved reporting quality
- Simplified SQL transformations

---

## Materialization

Seed files are materialized as regular tables in Snowflake and can be referenced like any other dbt model using the `ref()` function.

Example:

```sql
SELECT *
FROM {{ ref('state_mapping') }}
```

---

## Layer Output

The seed layer provides standardized lookup tables that are consumed throughout the project to enrich staging, intermediate, and marts models, resulting in cleaner SQL, consistent business logic, and more user-friendly dashboards.