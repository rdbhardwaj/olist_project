# 🥇 Marts Layer

## Overview

The **Marts layer** is the final transformation layer of the dbt project. It organizes the transformed data into a **star schema**, making it optimized for reporting, business intelligence, and dashboarding.

This layer contains business-ready **dimension** and **fact** tables that serve as the single source of truth for analytical workloads.

---

## Objectives

- Build a star schema
- Improve query performance
- Simplify business reporting
- Support BI dashboards
- Provide consistent analytical datasets

---

## Data Model

The marts layer consists of one central fact table surrounded by supporting dimension tables.

| Model | Type | Description |
|--------|------|-------------|
| fact_orders | Fact | Central transactional table containing one row per purchased item with sales, payment, freight, and review metrics. |
| dim_customers | Dimension | Customer information including unique customer identifier, city, and state. |
| dim_products | Dimension | Product details and translated product category names. |
| dim_sellers | Dimension | Seller information including seller location and state. |

---

## Star Schema

```
                 DIM_CUSTOMERS
                       │
                       │
DIM_PRODUCTS ─── FACT_ORDERS ─── DIM_SELLERS
```

The **fact_orders** table references all dimensions using surrogate business keys, enabling efficient analytical queries and dashboard filtering.

---

## Business Metrics

The fact table contains several analytical metrics, including:

- Total Payment
- Product Price
- Freight Cost
- Average Review Score
- Total Reviews
- Payment Installments
- Order Status
- Purchase Timestamp
- Delivery Dates

These metrics support sales analysis, operational monitoring, and customer satisfaction reporting.

---

## Data Quality Tests

The marts layer includes comprehensive dbt tests to ensure production-ready data.

### Generic Tests

- `unique`
- `not_null`
- `unique_combination_of_columns`

### Custom Tests

- Positive value validation
- Non-zero payment validation
- Review score range validation (1–5)

These validations help ensure analytical accuracy and maintain trust in business reports.

---

## Materialization

All marts models are materialized as **Tables**.

### Why Tables?

- Faster dashboard performance
- Optimized analytical queries
- Reduced execution time for BI tools
- Improved scalability for large datasets

---

## Business Use Cases

The marts layer supports a variety of business analyses, including:

- Sales performance analysis
- Revenue tracking
- Customer behavior analysis
- Product category performance
- Seller performance monitoring
- Customer satisfaction analysis
- Payment behavior analysis
- Operational reporting

---

## Dashboard Integration

The marts layer serves as the data source for the **Power BI dashboard**, providing curated datasets for interactive visualizations and executive reporting.

The dashboard includes:

- Executive Sales Overview
- Seller & Operations Analysis
- Revenue trends
- Product performance
- Customer satisfaction metrics
- Order lifecycle analysis
- Seller performance insights
- Payment installment analysis

---

## Layer Output

The marts layer produces analytics-ready tables that can be directly consumed by BI tools such as **Power BI**, **Looker Studio**, **Tableau**, or other reporting platforms without requiring additional transformations.