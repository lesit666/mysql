-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- MySQL Server Sample Schemas (like Oracle)

drop user if exists 'labs'@'localhost';
drop user if exists 'labs'@'{{ hostvars[inventory_hostname]["ansible_hostname"] }}';

-- crmdb database

-- Drop User Accounts
drop user if exists 'crm'@'%';

-- Drop Databases/Schemas
drop database if exists crmdb;

-- Create Databases/Schemas
create database if not exists crmdb;

-- Display Databases/Schemas 
show databases;

-- Create User Accounts
create user if not exists 'crm'@'%' identified by 'MySQL.Labs_4ALL';

-- Display User Accounts
select User, Host from mysql.user where User = 'crm';

-- Drop Roles
drop role if exists crmrole;

-- Create Roles
create role if not exists crmrole;

-- Display Roles
select User, Host from mysql.user where User = 'crmrole';

-- Grant Account Privileges
grant all privileges on crmdb.* to crmrole;
grant select on mysql.user to crmrole;
grant select on mysql.db to crmrole;
grant select on mysql.tables_priv to crmrole;
grant select on mysql.columns_priv to crmrole; 
grant crmrole to 'crm'@'%';
set default role crmrole for 'crm'@'%';

-- crmdb Schema
source ./crmdb/crmdb_cre.sql
source ./crmdb/crmdb_idx.sql
source ./crmdb/crmdb_popul.sql
source ./crmdb/crmdb_code.sql
source ./crmdb/crmdb_analz.sql
