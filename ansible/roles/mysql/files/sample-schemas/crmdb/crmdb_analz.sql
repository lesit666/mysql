-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Analyze crmdb Schema Tables (update stats)
use crmdb;

analyze table sales;

analyze table sales_part;

analyze table costs;

analyze table costs_part;

analyze table channels;

analyze table countries;

analyze table customers;

analyze table products;

analyze table promotions;

analyze table sales;

analyze table sales_transactions_ext;

analyze table supplementary_demographics;

analyze table times;

analyze table cal_month_sales_mv;

analyze table fweek_pscat_sales_mv;
