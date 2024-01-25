-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- crmdb Schema Tables
use crmdb;

-- Drop existing crmdb schema tables
drop table if exists sales;
drop table if exists sales_part;
drop table if exists costs;
drop table if exists costs_part;
drop table if exists times;
drop table if exists products;
drop table if exists channels;
drop table if exists promotions;
drop table if exists customers;
drop table if exists countries;
drop table if exists supplementary_demographics;
drop table if exists sales_transactions_ext;

-- Create Sales table
create table sales 
(
    prod_id 		  int not null            comment 'FK to the products dimension table.',
    cust_id 		  int not null            comment 'FK to the customers dimension table.',
    time_id 		  datetime not null       comment 'FK to the times dimension table.',
    channel_id 		int not null            comment 'FK to the channels dimension table.',
    promo_id 		  int not null            comment 'Promotion identifier, without FK constraint (intentionally) to show outer join optimization.',
    quantity_sold decimal(10,2) not null  comment 'Product quantity sold with the transaction.',
    amount_sold 	decimal(10,2) not null  comment 'Invoiced amount to the customer.'
) comment = 'Facts table, without a primary key; all rows are uniquely identified by the combination of all foreign keys.';

-- Create Sales table w/ Partitioning
create table sales_part 
(
    prod_id 		  int not null,
    cust_id 		  int not null,
    time_id 		  datetime not null,
    channel_id 	 	int not null,
    promo_id 		  int not null,
    quantity_sold decimal(10,2) not null,
    amount_sold 	decimal(10,2) not null 
)
partition by range ( year( time_id )  * 100 + month( time_id ) )
(
  partition sales_2014    values less than (201500),
  partition sales_2015    values less than (201600),
  partition sales_h1_2016 values less than (201607),
  partition sales_h2_2016 values less than (201700),
  partition sales_q1_2017 values less than (201704),
  partition sales_q2_2017 values less than (201707),
  partition sales_q3_2017 values less than (201710),
  partition sales_q4_2017 values less than (201800),
  partition sales_q1_2018 values less than (201804),
  partition sales_q2_2018 values less than (201807),
  partition sales_q3_2018 values less than (201810),
  partition sales_q4_2018 values less than (201900),
  partition sales_q1_2019 values less than (201904),
  partition sales_q2_2019 values less than (201907),
  partition sales_q3_2019 values less than (201910),
  partition sales_q4_2019 values less than (202000),
  partition sales_q1_2020 values less than (202004),
  partition sales_q2_2020 values less than (202007),
  partition sales_q3_2020 values less than (202010),
  partition sales_q4_2020 values less than (202100),
  partition sales_q1_2021 values less than (202104),
  partition sales_q2_2021 values less than (202107),
  partition sales_q3_2021 values less than (202110),
  partition sales_q4_2021 values less than (202200),
  partition sales_q1_2022 values less than (202204),
  partition sales_q2_2022 values less than (202207),
  partition sales_q3_2022 values less than (202210),
  partition sales_q4_2022 values less than (202300)
);

-- Create Costs table
create table costs 
(
    prod_id 		  int not null,
    time_id 		  datetime not null,
    promo_id 		  int not null,
    channel_id 		int not null,
    unit_cost     decimal(10,2) not null,
    unit_price	  decimal(10,2) not null
);

-- Create Costs table w/ partitioning
create table costs_part 
(
    prod_id 		  int not null,
    time_id 		  datetime not null,
    promo_id 		  int not null,
    channel_id 		int not null,
    unit_cost     decimal(10,2) not null,
    unit_price	  decimal(10,2) not null
)
partition by range ( year( time_id )  * 100 + month( time_id ) )
(
  partition costs_2014    values less than (201500),
  partition costs_2015    values less than (201600),
  partition costs_h1_2016 values less than (201607),
  partition costs_h2_2016 values less than (201700),
  partition costs_q1_2017 values less than (201704),
  partition costs_q2_2017 values less than (201707),
  partition costs_q3_2017 values less than (201710),
  partition costs_q4_2017 values less than (201800),
  partition costs_q1_2018 values less than (201804),
  partition costs_q2_2018 values less than (201807),
  partition costs_q3_2018 values less than (201810),
  partition costs_q4_2018 values less than (201900),
  partition costs_q1_2019 values less than (201904),
  partition costs_q2_2019 values less than (201907),
  partition costs_q3_2019 values less than (201910),
  partition costs_q4_2019 values less than (202000),
  partition costs_q1_2020 values less than (202004),
  partition costs_q2_2020 values less than (202007),
  partition costs_q3_2020 values less than (202010),
  partition costs_q4_2020 values less than (202100),
  partition costs_q1_2021 values less than (202104),
  partition costs_q2_2021 values less than (202107),
  partition costs_q3_2021 values less than (202110),
  partition costs_q4_2021 values less than (202200),
  partition costs_q1_2022 values less than (202204),
  partition costs_q2_2022 values less than (202207),
  partition costs_q3_2022 values less than (202210),
  partition costs_q4_2022 values less than (202300)
);

-- Create Times table
create table times 
(
  time_id 			           datetime not null    comment 'Primary key; day date, finest granularity, CORRECT ORDER.',
  day_name 			           varchar(9)	not null  comment 'Monday to Sunday, repeating.',
  day_number_in_week 		   tinyint not null     comment '1 to 7, repeating.',
  day_number_in_month 	   tinyint not null     comment '1 to 31, repeating.',
  calendar_week_number 	   tinyint not null     comment '1 to 53, repeating.',
  fiscal_week_number 		   tinyint not null     comment '1 to 53, repeating.',
  week_ending_day 		     datetime not null    comment 'Date of last day in week, CORRECT ORDER.',
  week_ending_day_id	 	   smallint not null,
  calendar_month_number 	 tinyint not null     comment '1 to 12, repeating.',
  fiscal_month_number 	   tinyint not null     comment '1 to 12, repeating.',
  calendar_month_desc 	   varchar(8) not null  comment 'e.g. 2017-01, CORRECT ORDER.',
  calendar_month_id	 	     smallint not null,
  fiscal_month_desc 		   varchar(8) not null  comment 'e.g. 2017-01, CORRECT ORDER.',
  fiscal_month_id	 	       smallint not null,
  days_in_cal_month 		   tinyint not null     comment 'e.g. 28,31, repeating.',
  days_in_fis_month 		   tinyint not null     comment 'e.g. 25,32, repeating.',
  end_of_cal_month 		     datetime not null    comment 'Last day of calendar month.',
  end_of_fis_month 		     datetime not null    comment 'Last day of fiscal month.',
  calendar_month_name 	   varchar(9) not null  comment 'January to December, repeating.',
  fiscal_month_name 		   varchar(9) not null  comment 'January to December, repeating.',
  calendar_quarter_desc 	 char(7) not null     comment 'e.g. 2017-Q1, CORRECT ORDER.',
  calendar_quarter_id	 	   smallint not null,
  fiscal_quarter_desc 	   char(7) not null     comment 'e.g. 2018-Q3, CORRECT ORDER.',
  fiscal_quarter_id	 	     smallint not null,
  days_in_cal_quarter 	   tinyint not null     comment 'e.g. 88,90, repeating.',
  days_in_fis_quarter 	   tinyint not null     comment 'e.g. 88,90, repeating.',
  end_of_cal_quarter 		   datetime not null    comment 'Last day of calendar quarter.',
  end_of_fis_quarter 		   datetime not null    comment 'Last day of fiscal quarter.',
  calendar_quarter_number  tinyint not null     comment '1 to 4, repeating.',
  fiscal_quarter_number 	 tinyint not null     comment '1 to 4, repeating.',
  calendar_year 		       smallint not null    comment 'e.g. 2018, CORRECT ORDER.',
  calendar_year_id 		     smallint not null,
  fiscal_year 		         smallint not null    comment 'e.g. 2018, CORRECT ORDER.',
  fiscal_year_id 		       smallint not null,
  days_in_cal_year 		     smallint not null    comment '365,366 repeating.',
  days_in_fis_year 		     smallint not null    comment 'e.g. 355,364, repeating.',
  end_of_cal_year 		     datetime not null    comment 'Last day of cal year.',
  end_of_fis_year 		     datetime not null    comment 'Last day of fiscal year.'
) comment = 'Time dimension table (lookup) to support multiple hierarchies and materialized views.';

-- Create Products table
create table products 
(
  prod_id               int not null            comment 'Primary key.',
  prod_name             varchar(50) not null    comment 'Product name.',
  prod_desc             varchar(4000) not null  comment 'Product description.',
  prod_subcategory      varchar(50) not null    comment 'Product subcategory.',
  prod_subcategory_id   int not null,
  prod_subcategory_desc varchar(2019) not null  comment 'Product subcategory description.',
  prod_category         varchar(50) not null    comment 'Product category.',
  prod_category_id      int not null,
  prod_category_desc    varchar(2019) not null  comment 'Product category description.',
  prod_weight_class     smallint not null       comment 'Product weight class.',
  prod_unit_of_measure  varchar(20)             comment 'Product unit of measure.',
  prod_pack_size 		    varchar(30) not null    comment 'Product package size.',
  supplier_id           int not null,
  prod_status           varchar(20) not null    comment 'Product status.', 
  prod_list_price       decimal(8,2) not null   comment 'Product list price.',
  prod_min_price        decimal(8,2) not null   comment 'Product minimum price.',
  prod_total 			      varchar(13) not null,
  prod_total_id 		    int not null,
  prod_src_id        		int,
  prod_eff_from      		datetime,
  prod_eff_to        		datetime,
  prod_valid         		varchar(1)	
) comment = 'Products dimension table (lookup).';

-- Create Channels table
create table channels 
(
  channel_id        int not null          comment 'Primary key column.',
  channel_desc      varchar(20) not null  comment 'e.g. telesales, internet, catalog.',
  channel_class 		varchar(20) not null  comment 'e.g. direct, indirect.',
  channel_class_id  int not null,
  channel_total     varchar(13) not null,
  channel_total_id  int not null
) comment = 'Small dimension table (lookup).';

-- Create Promotions table
create table promotions 
(
  promo_id              int not null           comment 'Primary key column.',
  promo_name            varchar(30) not null   comment 'Promotion description.',
  promo_subcategory     varchar(30) not null   comment 'Enables to investigate promotion hierarchies.',
  promo_subcategory_id  int not null,
  promo_category        varchar(30) not null   comment 'Promotion category.',
  promo_category_id     int not null,
  promo_cost            decimal(10,2) not null comment 'Promotion cost, to do promotion effect calculations.',
  promo_begin_date      datetime not null      comment 'Promotion begin day.',
  promo_end_date        datetime not null      comment 'Promotion end day.',
  promo_total           varchar(15) not null,
  promo_total_id        int not null
) comment = 'Dimension table (lookup) without a PK-FK relationship with the facts table, to show outer join functionality.';

-- Create Customers table
create table customers (
  cust_id                 int not null          comment 'Primary key.',
  cust_first_name         varchar(20) not null  comment 'First name of the customer.',
  cust_last_name          varchar(40) not null  comment 'Last name of the customer.',
  cust_gender             char(1) not null      comment 'Gender; low cardinality attribute.',
  cust_year_of_birth      smallint not null     comment 'Customer year of birth.',
  cust_marital_status     varchar(20)           comment 'Customer marital status; low cardinality attribute.',
  cust_street_address     varchar(40) not null  comment 'Customer street address.',
  cust_postal_code        varchar(10) not null  comment 'Postal code of the customer.',
  cust_city               varchar(30) not null  comment 'City where the customer lives.',
  cust_city_id            int not null,
  cust_state_province     varchar(40) not null  comment 'Customer geography: state or province.',
  cust_state_province_id  int not null,
  country_id              int not null          comment 'Foreign key to the countries table (snowflake design).',
  cust_main_phone_number  varchar(25) not null  comment 'Customer main phone number.',
  cust_income_level       varchar(30)           comment 'Customer income level.',
  cust_credit_limit       bigint                comment 'Customer credit limit.',
  cust_email              varchar(50)           comment 'Customer email.',
  cust_total              varchar(14) not null,
  cust_total_id           int not null,
  cust_src_id             int,
  cust_eff_from           datetime,
  cust_eff_to             datetime,
  cust_valid              varchar(1)
  ) comment = 'Product dimension table (lookup)';

-- Create Countries table
create table countries 
(
  country_id            int not null          comment 'Primary key.',
  country_iso_code      char(2) not null,
  country_name          varchar(40) not null  comment 'Country name.',
  country_subregion     varchar(30) not null  comment 'e.g. Western Europe, to allow hierarchies.',
  country_subregion_id  int not null,
  country_region        varchar(20) not null  comment 'e.g. Europe, Asia.',
  country_region_id     int not null,
  country_total         varchar(11) not null,
  country_total_id      int not null,
  country_name_hist     varchar(40)
) comment = 'Country dimension table (lookup) for snowflake desing.';

-- Create Supplementary Demographics table
create table supplementary_demographics
(
  cust_id                  int not null,
  education                varchar(21),
  occupation               varchar(21),
  household_size           varchar(21),
  yrs_residence            int,
  affinity_card            bigint,
  bulk_pack_diskettes      bigint,
  flat_panel_monitor       bigint,
  home_theater_package     bigint,
  bookkeeping_application  bigint,
  printer_supplies         bigint,
  y_box_games              bigint,
  os_doc_set_kanji         bigint,
  comments                 varchar(4000)
);

-- Create Sales Transactions External
create table sales_transactions_ext
(
    prod_id 		  int not null,
    cust_id 		  int not null,
    time_id 		  datetime not null,
    channel_id 		int not null,
    promo_id 		  int not null,
    quantity_sold decimal(10,2) not null,
    amount_sold 	decimal(10,2) not null,
    unit_cost decimal(10,2) not null,
    unit_price 	decimal(10,2) not null
);

show tables from crmdb;
