# 📂 Models

## Overview

The **models** directory contains the complete transformation pipeline of the project. It follows a layered architecture recommended by dbt, where raw data is progressively cleaned, transformed, enriched, and modeled into business-ready datasets.

Each layer has a single responsibility, making the project modular, maintainable, and easy to debug.

```
models/
│
├── staging/
├── intermediate/
├── marts/
└── debug/
```

---

# Model Architecture

```
                RAW TABLES
                     │
                     ▼
             STAGING LAYER
        (Cleaning & Standardization)
                     │
                     ▼
          INTERMEDIATE LAYER
     (Business Logic & Transformations)
                     │
                     ▼
               MARTS LAYER
     (Star Schema for Analytics)
                     │
                     ▼
          Power BI Dashboard
```

---

# Folder Structure

## 📁 Staging

The staging layer is the first transformation layer.

Its responsibility is to convert raw source tables into clean and standardized datasets without changing the business meaning of the data.

Typical transformations include:

- Renaming columns
- Standardizing naming conventions
- Type casting
- Removing unnecessary columns
- Basic data cleaning

Output models are prefixed with:

```
stg_
```

Example:

```
stg_orders
stg_customers
stg_products
```

---

## 📁 Intermediate

The intermediate layer combines multiple staging models to create business-friendly datasets.

This layer contains the core transformation logic used throughout the project.

Typical operations include:

- Joining multiple staging models
- Aggregating payment information
- Enriching order data
- Preparing reusable datasets

Output models are prefixed with:

```
int_
```

Example:

```
int_order_details
int_customer_orders
int_payments_summary
```

---

## 📁 Marts

The marts layer contains the final analytical tables used for reporting and dashboards.

This project follows a **Star Schema**, consisting of:

### Dimension Tables

Store descriptive information.

Examples:

- Customers
- Products
- Sellers

### Fact Table

Stores measurable business events.

Example:

- Orders
- Revenue
- Payments
- Reviews

Output models include:

```
dim_customers
dim_products
dim_sellers
fact_orders
```

These models are directly connected to Power BI for dashboard creation.

---

## 📁 Debug

The debug folder contains temporary SQL models created during development.

These models are used for:

- Verifying joins
- Testing transformations
- Inspecting intermediate results
- Debugging data issues

They are **not intended for production reporting**.

---

# Data Flow

```
RAW.CUSTOMERS
RAW.ORDERS
RAW.PRODUCTS
RAW.PAYMENTS
RAW.SELLERS
RAW.REVIEWS
        │
        ▼
──────────────────────────
STAGING MODELS
──────────────────────────

stg_customers
stg_orders
stg_products
stg_payments
stg_reviews
stg_sellers
stg_order_items

        │
        ▼
──────────────────────────
INTERMEDIATE MODELS
──────────────────────────

int_order_details
int_customer_orders
int_payments_summary

        │
        ▼
──────────────────────────
MART MODELS
──────────────────────────

dim_customers
dim_products
dim_sellers
fact_orders

        │
        ▼

Power BI Dashboard
```

---

# Design Principles

The models are designed following dbt best practices:

- Layered architecture
- One responsibility per model
- Reusable transformations
- Modular SQL
- Clear naming conventions
- Comprehensive documentation
- Automated testing
- Production-ready structure

---

# Naming Conventions

| Prefix | Purpose | Example |
|---------|----------|---------|
| `stg_` | Cleaned source models | `stg_orders` |
| `int_` | Intermediate transformations | `int_order_details` |
| `dim_` | Dimension tables | `dim_products` |
| `fact_` | Fact tables | `fact_orders` |

---

# Why This Architecture?

Separating transformations into multiple layers provides several benefits:

- Easier debugging and maintenance
- Reusable business logic
- Better readability
- Scalable project structure
- Clear separation of responsibilities
- Simplified testing and documentation
- Optimized analytical models for BI tools

Instead of writing one large SQL query, each layer performs a specific task, resulting in a clean, modular, and production-ready analytics pipeline.

---

# Final Pipeline

```
Raw Data
    │
    ▼
Staging
    │
    ▼
Intermediate
    │
    ▼
Marts (Star Schema)
    │
    ▼
Power BI Dashboard
```

This layered approach ensures that raw operational data is transformed into reliable, well-structured, and business-ready datasets that support accurate reporting and decision-making.