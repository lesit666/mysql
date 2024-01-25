-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- MySQL InnoDB Cluster Configuration account

-- Drop Roles
drop role if exists labsconfrole;

-- Create User Accounts
drop user if exists 'labs'@'localhost';
drop user if exists 'labs'@'{{ hostvars[inventory_hostname]["ansible_hostname"] }}';

-- Create User Accounts
create user if not exists 'labs'@'%' identified by 'MySQL.Labs_4ALL';

-- Display User Accounts
select User, Host from mysql.user where User = 'labs' order by User, Host;

-- Create Roles
create role if not exists labsconfrole;

-- Display Roles
select User, Host from mysql.user where User = 'labsconfrole';

-- Grant Account Privileges to configure MySQL InnoDB Cluster
grant CLONE_ADMIN, CONNECTION_ADMIN, CREATE USER, EXECUTE, FILE, GROUP_REPLICATION_ADMIN, PERSIST_RO_VARIABLES_ADMIN, PROCESS, RELOAD, REPLICATION CLIENT, REPLICATION SLAVE, REPLICATION_APPLIER, REPLICATION_SLAVE_ADMIN, ROLE_ADMIN, SELECT, SHUTDOWN, SYSTEM_VARIABLES_ADMIN on *.* to labsconfrole with grant option;
grant DELETE, INSERT, UPDATE on mysql.* to labsconfrole with grant option;
grant ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, INDEX, INSERT, LOCK TABLES, REFERENCES, SHOW VIEW, TRIGGER, UPDATE on mysql_innodb_cluster_metadata.* to labsconfrole with grant option;
grant ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, INDEX, INSERT, LOCK TABLES, REFERENCES, SHOW VIEW, TRIGGER, UPDATE on mysql_innodb_cluster_metadata_bkp.* to labsconfrole with grant option;
grant ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, DELETE, DROP, EVENT, INDEX, INSERT, LOCK TABLES, REFERENCES, SHOW VIEW, TRIGGER, UPDATE on mysql_innodb_cluster_metadata_previous.* to labsconfrole with grant option;;
grant labsconfrole to 'labs'@'%';
set default role labsconfrole to 'labs'@'%';

-- MySQL Server Sample Schemas (like Oracle)

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
grant all privileges on hrdb.* to labsconfrole;

-- hrdb Schema
source ./hrdb/hrdb_cre.sql
source ./hrdb/hrdb_idx.sql
source ./hrdb/hrdb_popul.sql
source ./hrdb/hrdb_code.sql
source ./hrdb/hrdb_analz.sql

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
set default role crmrole to 'crm'@'%';
grant all privileges on crmdb.* to labsconfrole;

-- crmdb Schema
source ./crmdb/crmdb_cre.sql
source ./crmdb/crmdb_idx.sql
source ./crmdb/crmdb_popul.sql
source ./crmdb/crmdb_code.sql
source ./crmdb/crmdb_analz.sql

-- -- flightsdb database

-- -- Drop User Accounts
-- drop user if exists 'sky'@'%';

-- -- Drop Databases/Schemas
-- drop database if exists flightsdb;

-- -- Create Databases/Schemas
-- create database if not exists flightsdb;

-- -- Display Databases/Schemas
-- show databases;

-- -- Create User Accounts
-- create user if not exists 'sky'@'%' identified by 'MySQL.Labs_4ALL';

-- -- Display User Accounts
-- select User, Host from mysql.user where User = 'sky';

-- -- Drop Roles
-- drop role if exists skyrole;

-- -- Create Roles
-- create role if not exists skyrole;

-- -- Display Roles
-- select User, Host from mysql.user where User = 'skyrole';

-- -- Grant Account Privileges
-- grant all privileges on flightsdb.* to skyrole;
-- grant select on mysql.user to skyrole;
-- grant select on mysql.db to skyrole;
-- grant select on mysql.tables_priv to skyrole;
-- grant select on mysql.columns_priv to skyrole;
-- grant skyrole to 'sky'@'%';
-- set default role skyrole to 'sky'@'%';
-- grant all privileges on flightsdb.* to labsconfrole;

-- -- flightsdb Schema
-- source ./flightsdb-master/small/flightsdb.sql

-- select count(*) from flightsdb.booking;