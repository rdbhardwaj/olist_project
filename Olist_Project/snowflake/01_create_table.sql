-- =====================================================
-- Project : Olist Analytics Engineering Project
-- Purpose : Create RAW tables
-- Author  : Devashish
-- =====================================================

USE DATABASE OLIST_DB;
USE SCHEMA RAW;

CREATE OR REPLACE TABLE CUSTOMERS (

    CUSTOMER_ID VARCHAR,

    CUSTOMER_UNIQUE_ID VARCHAR,

    CUSTOMER_ZIP_CODE_PREFIX NUMBER,

    CUSTOMER_CITY VARCHAR,

    CUSTOMER_STATE VARCHAR

);