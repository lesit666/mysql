
-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- crmdb schema indexes and foreign keys
use crmdb;

-- Promotion table PK
alter table promotions 
  add primary key ( promo_id );

-- Sales table foreign key to Promotions table
alter table sales 
  add foreign key ( promo_id ) 
  references promotions ( promo_id );

-- Costs table foreign key to Promotions table
alter table costs 
  add foreign key ( promo_id ) 
  references promotions ( promo_id );

-- Customers table PK
alter table customers
  add primary key ( cust_id );

-- Sales table foreign key to Customers table
alter table sales
  add foreign key ( cust_id ) references customers ( cust_id );

-- Products table PK
alter table products
  add primary key ( prod_id );

-- Sales table foreign key to Products table
alter table sales
  add foreign key ( prod_id ) references products ( prod_id );

-- Costs table foreign key to Products table
alter table costs
  add foreign key ( prod_id ) references products ( prod_id );

-- Times table PK
alter table times
  add primary key ( time_id );

-- Sales table foreign key to Times table
alter table sales
  add foreign key ( time_id ) references times ( time_id );

-- Costs table foreign key to Times table
alter table costs
  add foreign key ( time_id ) references times ( time_id );

-- Channels table PK
alter table channels
  add primary key ( channel_id );

-- Sales table foreign key to Channels table
alter table sales
  add foreign key ( channel_id ) references channels ( channel_id );

-- Costs table foreign key to Channels table
alter table costs
  add foreign key ( channel_id ) references channels ( channel_id );

-- Countries table PK
alter table countries
  add primary key ( country_id );

-- Customers table foreign key to Countries table
alter table customers
  add foreign key ( country_id ) references countries ( country_id );

-- Sales product id index
create index sales_prod_ix
  on sales ( prod_id );

-- Sales customer id index
create index sales_cust_ix
  on sales ( cust_id );

-- Sales time id index
create index sales_time_ix
  on sales ( time_id );

-- Sales channel id index
create index sales_channel_ix
  on sales ( channel_id );

-- Sales promotion id index
create index sales_promo_ix
  on sales ( promo_id );

-- Costs product id index
create index costs_prod_ix
  on costs ( prod_id );

-- Costs time id index
create index costs_time_ix
  on costs ( time_id );

-- Products product status index
create index products_prod_status_ix
  on products ( prod_status );

-- Products product subcategory index
create index products_prod_subcat_ix
  on products ( prod_subcategory );

-- Products product category index
create index products_prod_cat_ix 
  on products ( prod_category );

-- Customers gender index
create index customers_gender_ix
  on customers ( cust_gender );

-- Customers marital status index
create index customers_marital_ix
  on customers ( cust_marital_status );

-- Customers year of birthday index
create index customers_yob_ix
  on customers ( cust_year_of_birth );

-- Display sh schema indexes
select TABLE_NAME, INDEX_NAME, INDEX_TYPE
  from information_schema.STATISTICS 
where TABLE_SCHEMA = 'sh' order by TABLE_NAME, INDEX_NAME;
