# 🔧 Macros

The project uses reusable dbt macros to standardize transformations and automate environment-specific behavior. Macros help eliminate repetitive SQL and improve maintainability.

---

## 1. `clean_text.sql`

### Purpose

Standardizes text values across models by cleaning inconsistent formatting.

### Functionality

- Converts text to lowercase
- Removes leading and trailing spaces
- Replaces multiple spaces with a single space
- Produces consistent values for joins and analysis

### Example

**Before**

| Value |
|--------|
| ` São Paulo ` |
| `RIO DE JANEIRO` |
| `  Belo   Horizonte  ` |

**After**

| Value |
|--------|
| `são paulo` |
| `rio de janeiro` |
| `belo horizonte` |

### Usage

```sql
{{ clean_text('customer_city') }}
```

This macro is used wherever text normalization is required before loading data into staging models.

---

## 2. `generate_schema_name.sql`

### Purpose

Overrides dbt's default schema generation logic to organize models into separate Snowflake schemas based on their layer.

### Functionality

Instead of creating all models in one schema, models are automatically materialized into dedicated schemas such as:

| Layer | Target Schema |
|--------|---------------|
| Staging | STAGING |
| Intermediate | INTERMEDIATE |
| Marts | MARTS |

This creates a clean warehouse structure and follows modern analytics engineering best practices.

### Example

Without the macro:

```
OLIST_DB.PUBLIC
```

With the macro:

```
OLIST_DB.STAGING
OLIST_DB.INTERMEDIATE
OLIST_DB.MARTS
```

### Benefits

- Cleaner warehouse organization
- Easier navigation
- Environment-independent schema generation
- Reduced manual configuration
- Better scalability for larger dbt projects

---

## Why Use Macros?

Using macros allows SQL logic to be written once and reused throughout the project.

Benefits include:

- Improved code reusability
- Reduced duplication
- Consistent data transformations
- Easier maintenance
- Cleaner and more modular dbt models