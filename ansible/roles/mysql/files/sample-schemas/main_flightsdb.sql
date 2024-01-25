-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- MySQL Server Sample Schemas (Flights Booking)

drop user if exists 'labs'@'localhost';
drop user if exists 'labs'@'{{ hostvars[inventory_hostname]["ansible_hostname"] }}';

-- flightsdb database

-- Drop User Accounts
drop user if exists 'sky'@'%';

-- Drop Databases/Schemas
drop database if exists flightsdb;

-- Create Databases/Schemas
create database if not exists flightsdb;

-- Display Databases/Schemas
show databases;

-- Create User Accounts
create user if not exists 'sky'@'%' identified by 'MySQL.Labs_4ALL';

-- Display User Accounts
select User, Host from mysql.user where User = 'sky';

-- Drop Roles
drop role if exists skyrole;

-- Create Roles
create role if not exists skyrole;

-- Display Roles
select User, Host from mysql.user where User = 'skyrole';

-- Grant Account Privileges
grant all privileges on flightsdb.* to skyrole;
grant select on mysql.user to skyrole;
grant select on mysql.db to skyrole;
grant select on mysql.tables_priv to skyrole;
grant select on mysql.columns_priv to skyrole;
grant skyrole to 'sky'@'%';
set default role skyrole for 'sky'@'%';

-- flightsdb Schema
source ./flightsdb-master/small/flightsdb.sql
