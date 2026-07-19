# ✅ Tests

## Overview

The **Tests** directory is responsible for validating data quality throughout the dbt project.

Data pipelines are only valuable if the data is accurate and reliable. The tests in this project automatically verify that important business rules are always satisfied before the data reaches dashboards or downstream applications.

This project contains both **generic tests** and **custom business tests**.

---

# Test Categories

## 1. Generic Tests

Generic tests validate common data quality rules such as uniqueness, null values, and acceptable value ranges.

These tests are reusable across multiple models and columns.

---

### Unique Test

**Purpose**

Ensures duplicate records do not exist where uniqueness is expected.

**Example**

Every customer should have only one unique Customer ID.

✅ Correct

| Customer ID |
|-------------|
| C001 |
| C002 |
| C003 |

❌ Incorrect

| Customer ID |
|-------------|
| C001 |
| C001 |
| C003 |

---

### Not Null Test

**Purpose**

Ensures important columns never contain missing values.

**Example**

Every order should have an Order ID.

✅ Correct

| Order ID |
|----------|
| O101 |
| O102 |

❌ Incorrect

| Order ID |
|----------|
| NULL |
| O102 |

---

### Relationships Test

**Purpose**

Ensures foreign keys actually exist in the parent table.

Example:

Every Product ID inside Fact Orders should exist in the Product Dimension.

This prevents orphan records.

---

# 2. Custom Generic Tests

To make the project more production-ready, custom reusable tests were created.

---

## Positive Values Test

**File**

```
tests/generic/positive_values.sql
```

### Logic

Checks that numeric values are **greater than zero**.

### Business Reason

Negative prices or payments are invalid in an e-commerce system.

### Example

✅ Valid

| Payment |
|----------|
| 120 |
| 55 |
| 899 |

❌ Invalid

| Payment |
|----------|
| -10 |
| -250 |

---

## Non-Zero Test

**File**

```
tests/generic/non_zero.sql
```

### Logic

Ensures the value is **not equal to zero**.

### Business Reason

An order with zero payment or zero selling price usually indicates missing or incorrect transaction data.

### Example

✅ Valid

| Payment |
|----------|
| 150 |
| 89 |

❌ Invalid

| Payment |
|----------|
| 0 |
| 0 |

---

## Value Between Test

**File**

```
tests/generic/value_between.sql
```

### Logic

Checks whether a value falls within a specified range.

### Business Reason

Customer review scores must always be between **1 and 5**.

### Example

✅ Valid

| Review Score |
|--------------|
| 4 |
| 5 |
| 2 |

❌ Invalid

| Review Score |
|--------------|
| 0 |
| 7 |
| -1 |

---

# 3. Singular Business Tests

Unlike generic tests, singular tests validate complete business rules using custom SQL queries.

If the SQL query returns **zero rows**, the test passes.

If any rows are returned, those records violate business rules and the test fails.

---

## Order Lifecycle Test

**File**

```
tests/test_order_lifecycle.sql
```

### Logic

This test validates that an order follows a logical business lifecycle.

It checks for situations that should never happen.

Examples include:

- A delivered order without a delivery date
- An approved order without an approval timestamp
- A shipped order without a shipping date
- Orders with inconsistent timestamps

### Business Reason

An order cannot be delivered before it has been shipped or approved. Detecting these inconsistencies ensures the order lifecycle remains reliable for reporting and operational analysis.

---

## Payment Integrity Test

**File**

```
tests/test_payment_integrity.sql
```

### Logic

This test verifies that payment information is complete and consistent.

It checks for issues such as:

- Delivered orders without any payment record
- Payments with zero or negative amounts
- Invalid installment values (less than 1)

### Business Reason

A successfully delivered order should always have a valid payment. Invalid payment amounts or installment counts usually indicate data quality issues that can affect revenue reporting and financial analysis.

---

# Test Execution

Run all tests:

```bash
dbt test
```

Run only generic tests:

```bash
dbt test --select test_type:generic
```

Run only singular tests:

```bash
dbt test --select test_type:singular
```

Run a specific test:

```bash
dbt test --select test_payment_integrity
```

---

# Why Testing Matters

Without automated testing:

- Dashboards may display incorrect metrics.
- Revenue reports can become inaccurate.
- Duplicate records may inflate KPIs.
- Missing relationships can break analyses.
- Business decisions may be based on unreliable data.

By implementing both generic and business-specific tests, this project ensures that the analytical models remain accurate, trustworthy, and production-ready.

---

# Testing Summary

| Test Type | Purpose |
|------------|---------|
| Unique | Prevent duplicate records |
| Not Null | Ensure mandatory fields are populated |
| Relationships | Maintain referential integrity between models |
| Positive Values | Validate numeric values are greater than zero |
| Non-Zero | Prevent zero-value transactions |
| Value Between | Ensure values stay within an acceptable range |
| Order Lifecycle | Validate logical order progression |
| Payment Integrity | Verify payment completeness and correctness |

The combination of generic and custom tests provides comprehensive data quality validation across the entire dbt pipeline, helping ensure that only clean, reliable, and business-ready data reaches the final reporting layer.