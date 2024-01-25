-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- MariaDB Server Sample Schemas (like Oracle)

drop user if exists 'labs'@'localhost';
drop user if exists 'labs'@'{{ hostvars[inventory_hostname]["ansible_hostname"] }}';

-- hrdb database

-- Drop User Accounts
drop user if exists 'hr'@'%';

-- Drop Databases/Schemas
drop database if exists hrdb;

-- Create Databases/Schemas
create database if not exists hrdb;

-- Display Databases/Schemas 
show databases;

-- Create User Accounts
create user if not exists 'hr'@'%' identified by 'MySQL.Labs_4ALL';

-- Display User Accounts
select User, Host from mysql.user where User = 'hr';

-- Drop Roles
drop role if exists hrrole;

-- Create Roles
create role if not exists hrrole;

-- Display Roles
select User, Host from mysql.user where User = 'hrrole';

-- Grant Account Privileges
grant all privileges on hrdb.* to hrrole;
grant select on mysql.user to hrrole;
grant select on mysql.db to hrrole;
grant select on mysql.tables_priv to hrrole;
grant select on mysql.columns_priv to hrrole; 
grant hrrole to 'hr'@'%';
set default role hrrole to 'hr'@'%';

-- hrdb Schema
source ./hrdb/hrdb_cre.sql
source ./hrdb/hrdb_idx.sql
source ./hrdb/hrdb_popul.sql
-- TODO: create some triggers, for example to keep history of changes when deleting an employee
source ./hrdb/hrdb_code.sql
source ./hrdb/hrdb_analz.sql
