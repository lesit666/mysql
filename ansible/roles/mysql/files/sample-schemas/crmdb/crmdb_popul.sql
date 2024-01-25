-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Populate crmdb Schema data
use crmdb;

set global local_infile=1;

-- Load Times data
load data infile '/tmp/sample-schemas/crmdb/crmdb_time.dat' 
  into table times 
  fields terminated by '|' optionally enclosed by '"' 
  ( @timeid, 
    day_name, 
    day_number_in_week, 
    day_number_in_month, 
    calendar_week_number, 
    fiscal_week_number, 
    @weekendingday,
    week_ending_day_id,
    calendar_month_number,
    fiscal_month_number,
    calendar_month_desc,
    calendar_month_id,
    fiscal_month_desc,
    fiscal_month_id,
    days_in_cal_month,
    days_in_fis_month,
    @endofcalmonth,
    @endoffismonth,
    calendar_month_name,
    fiscal_month_name,
    calendar_quarter_desc,
    calendar_quarter_id,
    fiscal_quarter_desc,
    fiscal_quarter_id,
    days_in_cal_quarter,
    days_in_fis_quarter,
    @endofcalquarter,
    @endoffisquarter,
    calendar_quarter_number,
    fiscal_quarter_number,
    calendar_year,
    calendar_year_id,
    fiscal_year,
    fiscal_year_id,
    days_in_cal_year,
    days_in_fis_year,
    @endofcalyear,
    @endoffisyear
  )
  set time_id = str_to_date( @timeid, '%Y-%m-%d-%H-%i-%s'), 
      week_ending_day = str_to_date( @weekendingday, '%Y-%m-%d-%H-%i-%s'),
      end_of_cal_month = str_to_date( @endofcalmonth, '%Y-%m-%d-%H-%i-%s'),
      end_of_fis_month = str_to_date( @endoffismonth, '%Y-%m-%d-%H-%i-%s'),
      end_of_cal_quarter = str_to_date( @endofcalquarter, '%Y-%m-%d-%H-%i-%s'),
      end_of_fis_quarter = str_to_date( @endoffisquarter, '%Y-%m-%d-%H-%i-%s'),
      end_of_cal_year = str_to_date( @endofcalyear, '%Y-%m-%d-%H-%i-%s'),
      end_of_fis_year = str_to_date( @endoffisyear, '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from times;

-- Load Countries data
load data infile '/tmp/sample-schemas/crmdb/crmdb_coun.dat' 
  into table countries
  fields terminated by '|' optionally enclosed by '"'
  ( country_id, 
    country_iso_code, 
    country_name, 
    country_subregion, 
    country_subregion_id, 
    country_region, 
    country_region_id, 
    country_total, 
    country_total_id,
    country_name_hist );

commit;

select count(*) num_rows from countries;

-- Load Customers data
load data infile '/tmp/sample-schemas/crmdb/crmdb_cust.dat' 
  into table customers
  fields terminated by '|' optionally enclosed by '"'
  ( cust_id,
    cust_first_name,
    cust_last_name,
    cust_gender,
    cust_year_of_birth,
    cust_marital_status,
    cust_street_address,
    cust_postal_code,
    cust_city,
    cust_city_id,
    cust_state_province,
    cust_state_province_id,
    country_id,
    cust_main_phone_number,
    cust_income_level,
    cust_credit_limit,
    cust_email,
    cust_total,
    cust_total_id,
    @custsrcid,
    @custefffrom,
    @custeffto,
    cust_valid )
  set cust_src_id = nullif( @custsrcid, '' ),
      cust_eff_from = str_to_date( nullif( @custefffrom, '' ), '%Y-%m-%d-%H-%i-%s'),
      cust_eff_to = str_to_date( nullif( @custeffto, '' ), '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from times;

-- Load Products data
load data infile '/tmp/sample-schemas/crmdb/crmdb_prod.dat' 
  into table products
  fields terminated by '|' optionally enclosed by '"'
  ( prod_id,
    prod_name, 
    prod_desc,
    prod_subcategory,
    prod_subcategory_id,
    prod_subcategory_desc,
    prod_category,
    prod_category_id,
    prod_category_desc,
    prod_weight_class,
    prod_unit_of_measure,
    prod_pack_size,
    supplier_id,
    prod_status,
    prod_list_price,
    prod_min_price,
    prod_total,
    prod_total_id,
    @prodsrcid,
    @prodefffrom,
    @prodeffto,
    prod_valid )
  set prod_src_id = nullif( @prodsrcid, '' ),
      prod_eff_from = str_to_date( nullif( @prodefffrom, '' ), '%Y-%m-%d-%H-%i-%s'),
      prod_eff_to = str_to_date( nullif( @prodeffto, '' ), '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from products;

-- Load Promotions data
load data infile '/tmp/sample-schemas/crmdb/crmdb_prom.dat' 
  into table promotions
  fields terminated by '|' optionally enclosed by '"'
  ( promo_id,
    promo_name,
    promo_subcategory,
    promo_subcategory_id,
    promo_category,
    promo_category_id,
    promo_cost,
    @promobegindate,
    @promoenddate,
    promo_total,
    promo_total_id )
  set promo_begin_date = str_to_date( nullif( @promobegindate, '' ), '%Y-%m-%d-%H-%i-%s'),
      promo_end_date = str_to_date( nullif( @promoenddate, '' ), '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from promotions;

-- Load Channels data
load data infile '/tmp/sample-schemas/crmdb/crmdb_chan.dat' 
  into table channels
  fields terminated by '|' optionally enclosed by '"'
  ( channel_id,
    channel_desc,
    channel_class,
    channel_class_id,
    channel_total,
    channel_total_id );

commit;

select count(*) num_rows from channels;

-- Load Sales data
load data infile '/tmp/sample-schemas/crmdb/crmdb_sale.dat' 
  into table sales
  fields terminated by '|' optionally enclosed by '"'
  ( prod_id,
    cust_id,
    @timeid,
    channel_id,
    promo_id,
    quantity_sold,
    amount_sold )
  set time_id = str_to_date( nullif( @timeid, '' ), '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from sales;

-- Load Sales w/ partitioning data
load data infile '/tmp/sample-schemas/crmdb/crmdb_sale.dat' 
  into table sales_part
  fields terminated by '|' optionally enclosed by '"'
  ( prod_id,
    cust_id,
    @timeid,
    channel_id,
    promo_id,
    quantity_sold,
    amount_sold )
  set time_id = str_to_date( nullif( @timeid, '' ), '%Y-%m-%d-%H-%i-%s');

commit;

select count(*) num_rows from sales_part;

-- Load Costs data
insert into costs 
( prod_id,
  time_id,
  channel_id,
  promo_id,
  unit_cost,
  unit_price )
select 
  prod_id,
  time_id,
  channel_id,
  promo_id,
  avg( quantity_sold - amount_sold ),
  avg( amount_sold / quantity_sold )
from 
  sales
group by
  prod_id,
  time_id,
  channel_id,
  promo_id;

commit;

select count(*) num_rows from costs;

-- Load Costs w/ partitioning data
insert into costs_part
( prod_id,
  time_id,
  channel_id,
  promo_id,
  unit_cost,
  unit_price )
select 
  prod_id,
  time_id,
  channel_id,
  promo_id,
  avg( quantity_sold - amount_sold ),
  avg( amount_sold / quantity_sold )
from 
  sales_part
group by
  prod_id,
  time_id,
  channel_id,
  promo_id;

commit;

select count(*) num_rows from costs_part;
