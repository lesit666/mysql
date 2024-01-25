-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Create hrdb Schema Indexes
use hrdb;

-- Employees indexes
create index emp_department_ix
       on employees (department_id);

create index emp_job_ix
       on employees (job_id);

create index emp_manager_ix
       on employees (manager_id);

create index emp_name_ix
       on employees (last_name, first_name);

-- Department indexes
create index dept_location_ix
       on departments (location_id);

-- Job History indexes
create index jhist_job_ix
       on job_history (job_id);

create index jhist_employee_ix
       on job_history (employee_id);

create index jhist_department_ix
       on job_history (department_id);

-- Job indexes
create index job_title_inx
       on jobs ( job_title );

-- Locations indexes
create index loc_city_ix
       on locations (city);

create index loc_state_province_ix	
       on locations (state_province);

create index loc_country_ix
       on locations (country_id);

-- Display hrdb schema indexes
select TABLE_NAME, INDEX_NAME, INDEX_TYPE
  from information_schema.STATISTICS 
where TABLE_SCHEMA = 'hrdb' order by TABLE_NAME, INDEX_NAME;

