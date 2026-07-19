# 🥈 Intermediate Layer

## Overview

The **Intermediate layer** bridges the gap between the raw staging models and the final dimensional models. It combines data from multiple staging tables, applies business logic, and creates reusable datasets that simplify downstream analytics.

Unlike the staging layer, the intermediate layer is where meaningful transformations and business rules are implemented.

---

## Objectives

- Join related datasets
- Apply business logic
- Reduce duplicate transformations
- Create reusable analytical models
- Simplify the construction of fact and dimension tables

---

## Models

| Model | Description |
|--------|-------------|
| int_order_details | Combines order, product, seller, payment, and review information into a single dataset at the order-item level. |
| int_customer_orders | Enriches customer orders with customer information, creating one record per order. |
| int_payments_summary | Aggregates payment information at the order level, including total payment and installment details. |

---

## Business Transformations

The intermediate layer performs the following transformations:

### int_order_details

- Joins orders, customers, products, sellers, payments, and reviews
- Calculates total payment per order
- Adds freight cost
- Includes review scores
- Preserves one row per purchased item

---

### int_customer_orders

- Combines customer and order information
- Creates one row per customer order
- Retains purchase timestamps and order lifecycle details
- Simplifies customer-level analysis

---

### int_payments_summary

- Aggregates multiple payment records into a single order-level record
- Calculates:
  - Total payment amount
  - Maximum number of payment installments
  - Payment count per order

---

## Data Quality Tests

The intermediate models include automated dbt tests to validate transformed data.

### Generic Tests

- `unique`
- `not_null`
- `unique_combination_of_columns`

These tests ensure:

- Every order has a unique identifier where expected.
- Composite keys remain unique.
- Required fields are never missing.

---

## Grain

| Model | Grain |
|--------|-------|
| int_order_details | One row per order item |
| int_customer_orders | One row per order |
| int_payments_summary | One row per order |

---

## Materialization

All intermediate models are materialized as **Views**.

### Benefits

- Eliminates redundant SQL in downstream models
- Keeps transformations modular
- Improves readability and maintainability
- Reduces storage usage

---

## Layer Output

The intermediate layer produces reusable business-ready datasets that feed the **Marts layer**, where star schema dimension and fact tables are built for reporting and business intelligence.