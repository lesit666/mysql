-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- hrdb Schema Tables
use hrdb;

-- Regions (table)
create table regions
( region_id       int not null auto_increment comment 'Primary key of regions table.', 
  region_name     varchar(25) comment 'Names of regions. Locations are in the countries of these regions.',
    primary key ( region_id )
) comment = 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';

-- Countries (table)
create table countries 
( country_id      char(2) not null comment 'Primary key of countries table.', 
  country_name    varchar(40) comment 'Country name.',
  region_id       int comment 'Region ID for the country. Foreign key to region_id column in the departments table.',
    primary key ( country_id )
) comment = 'Country table. Contains 25 rows. References with locations table.';

-- Locations (table)
create table locations
( location_id     int not null auto_increment comment 'Primary key of locations table.',
  street_address  varchar(40) comment 'Street address of an office, warehouse, or production site of a company. Contains building number and street name.',
  postal_code     varchar(12) comment 'Postal code of the location of an office, warehouse, or production site of a company.',
  city            varchar(30) not null comment 'A not null column that shows city where an office, warehouse, or production site of a company is located.',
  state_province  varchar(25) comment 'State or Province where an office, warehouse, or production site of a company is located.',
  country_id      char(2) comment 'Country where an office, warehouse, or production site of a company is located. Foreign key to country_id column of the countries table.',
    primary key ( location_id )
) comment = 'Locations table that contains specific address of a specific office, warehouse, and/or production site of a company. Does not store addresses locations of customers. Contains 23 rows; references with the departments and countries tables.';

-- Departments (table)
create table departments
( department_id   int not null auto_increment comment 'Primary key column of departments table.',
  department_name varchar(30) not null comment 'A not null column that shows name of a department. Administration, Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public Relations, Sales, Finance, and Accounting.',
  manager_id      int comment 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.',
  location_id     int comment 'Location id where a department is located. Foreign key to location_id column of locations table.',
    primary key ( department_id )
) comment = 'Departments table that shows details of departments where employees work. Contains 27 rows; references with locations, employees, and job_history tables.';

-- Jobs (table)
create table jobs
( job_id          varchar(10) not null comment 'Primary key of jobs table.',
  job_title       varchar(35) comment 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT.',
  min_salary      int comment 'Minimum salary for a job title.',
  max_salary      int comment 'Maximum salary for a job title',
    primary key ( job_id )
) comment = 'Jobs table with job titles and salary ranges. Contains 19 rows. References with employees and job_history table.';

-- Employees (table)
create table employees
( employee_id    int not null auto_increment comment 'Primary key of employees table.',
  first_name     varchar(20) comment 'First name of the employee. A not null column.',
  last_name      varchar(25) not null comment 'Last name of the employee. A not null column.',
  email          varchar(25) comment 'Email id of the employee.',
  phone_number   varchar(20) comment 'Phone number of the employee; includes country code and area code.',
  hire_date      datetime not null comment 'Date when the employee started on this job. A not null column.',
  job_id         varchar(10) comment 'Current job of the employee; foreign key to job_id column of the jobs table. A not null column.',
  salary         decimal(8,2) comment 'Monthly salary of the employee. Must be greater than zero. (enforced by check constraint)',
  commission_pct decimal(2,2) comment 'Commission percentage of the employee; Only employees in sales department elgible for commission percentage.',
  manager_id     int comment 'Manager id of the employee; has same domain as manager_id in departments table. Foreign key to employee_id column of employees table. (useful for reflexive joins)',
  department_id  int comment 'Department id where employee works; foreign key to department_id column of the departments table.',
    primary key ( employee_id ),
    check ( salary > 0 )
) comment = 'Employees table. Contains 107 rows. References with departments, jobs, job_history tables. Contains a self reference.';

-- Job History (table)
 create table job_history
 ( employee_id    int not null comment 'A not null column in the complex primary key employee_id+start_date. Foreign key to employee_id column of the employee table.',
   start_date     datetime not null comment 'A not null column in the complex primary key employee_id+start_date. Must be less than the end_date of the job_history table. (enforced by check constraint)',
   end_date       datetime not null comment 'Last day of the employee in this job role. A not null column. Must be greater than the start_date of the job_history table. (enforced by check constraint)',
   job_id         varchar(10) comment 'Job role in which the employee worked in the past; foreign key to job_id column in the jobs table. A not null column.',
   department_id  int comment 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table.',
     primary key ( employee_id, start_date, end_date ),
     check ( end_date > start_date )
 ) comment = 'Table that stores job history of the employees. If an employee changes departments within the job or changes jobs within the department, new rows get inserted into this table with old job information of the employee. Contains a complex primary key: employee_id+start_date. Contains 25 rows. References with jobs, employees, and departments tables.';

-- Employee Details (view)
create or replace view emp_details_view
( employee_id,
  job_id,
  manager_id,
  department_id,
  location_id,
  country_id,
  first_name,
  last_name,
  salary,
  commission_pct,
  department_name,
  job_title,
  city,
  state_province,
  country_name,
  region_name )
as select
     e.employee_id, 
     e.job_id, 
     e.manager_id, 
     e.department_id,
     d.location_id,
     l.country_id,
     e.first_name,
     e.last_name,
     e.salary,
     e.commission_pct,
     d.department_name,
     j.job_title,
     l.city,
     l.state_province,
     c.country_name,
     r.region_name
from
  employees e,
  departments d,
  jobs j,
  locations l,
  countries c,
  regions r
where e.department_id = d.department_id
  and d.location_id = l.location_id
  and l.country_id = c.country_id
  and c.region_id = r.region_id
  and j.job_id = e.job_id;

-- Display hrdb schema tables
show tables from hrdb;
