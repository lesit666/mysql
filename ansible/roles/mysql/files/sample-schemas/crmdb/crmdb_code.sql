-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- crmdb schema additional views and materialized views (tables)
use crmdb;

-- Profits table
create view profits
  as select
	s.channel_id, 
	s.cust_id, 
	s.prod_id, 
	s.promo_id, 
	s.time_id,
	c.unit_cost, 
	c.unit_price, 
	s.amount_sold, 
	s.quantity_sold,
	c.unit_cost * s.quantity_sold total_cost
from 
    costs c, sales s
where c.prod_id = s.prod_id
  and c.time_id = s.time_id
  and c.channel_id = s.channel_id
  and c.promo_id = s.promo_id;

-- Calendar Month Sales materialized view (table)
create table cal_month_sales_mv
as
  select   t.calendar_month_desc, sum(s.amount_sold) dollars
  from     sales s, times t
  where    s.time_id = t.time_id
  group by t.calendar_month_desc;

-- Promotion, Channel, Subcategory and Date End Day of Week Sales materialized view (table)
create table fweek_pscat_sales_mv
as
  select   t.week_ending_day, p.prod_subcategory, sum(s.amount_sold) dollars, s.channel_id, s.promo_id
  from     sales s, times t, products p
  where    s.time_id = t.time_id
  and      s.prod_id = p.prod_id
  group by t.week_ending_day, p.prod_subcategory, s.channel_id, s.promo_id;

-- Promotion, Channel, Subcategory and Date End Day of Week Sales materialized view indexes
create index fw_psc_s_mv_subcat_ix
  on fweek_pscat_sales_mv ( prod_subcategory );

create index fw_psc_s_mv_chan_ix
  on fweek_pscat_sales_mv ( channel_id );

create index fw_psc_s_mv_promo_ix
  on fweek_pscat_sales_mv ( promo_id );

create index fw_psc_s_mv_wd_ix
  on fweek_pscat_sales_mv ( week_ending_day );
