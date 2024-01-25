-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Drop hrdb Schema Code
use hrdb;
drop trigger if exists delete_employees_btrg;
drop trigger if exists delete_jobs_btrg;
drop trigger if exists delete_departments_btrg;
drop trigger if exists delete_locations_btrg;
drop trigger if exists delete_countries_btrg;
drop trigger if exists delete_regions_btrg;
drop trigger if exists secure_employees;
drop trigger if exists update_job_history;
drop procedure if exists secure_dml;
drop procedure if exists add_job_history;
drop procedure if exists checkNaN;
drop procedure if exists getConnId;
drop procedure if exists getAllRows;
drop procedure if exists getRowsCount;
drop procedure if exists getRowById;

-- Create hrdb Schema Code

-- Secure DML Procedure (checks office hours) 
-- Note: it's not created to avoid errors doing practices
-- delimiter //
-- create procedure secure_dml() no sql
-- begin
--   if ( date_format( now(), '%H:%i' ) not between '08:00' and '18:00' )
--     or ( date_format( now(), '%a' ) in ( 'Sat', 'Sun' ) ) then
-- 	  signal sqlstate '45000'
-- 	    set message_text = 'You may only make changes during normal office hours';
--   end if;
-- end;
-- //
-- delimiter ;

-- Secure Employees Trigger (verifies inserts on employees at office hours)
-- Note: it's not created to avoid errors doing practices
-- delimiter //
-- create trigger secure_employees before insert on employees for each row
-- begin
--   call secure_dml();
-- end;
-- //
-- delimiter ;

-- Add Job History Procedure (inserts job history records)
delimiter //
create procedure add_job_history
(  p_emp_id          int,
   p_start_date      datetime,
   p_end_date        datetime,
   p_job_id          varchar(10),
   p_department_id   smallint
) modifies sql data
begin
  insert into job_history ( employee_id, start_date, end_date, job_id, department_id )
    values ( p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id );
end;
//

-- Update Job History Trigger (logs employee job update)
create trigger update_job_history after update on employees for each row
begin
  if ( new.job_id <> old.job_id ) and ( new.department_id <> old.department_id ) then
    call add_job_history( old.employee_id, old.hire_date, now(), old.job_id, old.department_id );
  end if;
end;
//

create trigger delete_regions_btrg
  before delete on regions for each row
    update countries set countries.region_id = null where countries.region_id = old.region_id;
//

create trigger delete_countries_btrg
  before delete on countries for each row
    update locations set locations.country_id = null where locations.country_id = old.country_id;
//

create trigger delete_locations_btrg
  before delete on locations for each row
    update departments set departments.location_id = null where departments.location_id = old.location_id;
//

create trigger delete_departments_btrg
  before delete on departments for each row
begin
    update employees set employees.department_id = null where employees.department_id = old.department_id;
    delete from job_history where job_history.department_id = old.department_id;
end;
//

create trigger delete_jobs_btrg
  before delete on jobs for each row
begin
    update employees set employees.job_id = null where employees.job_id = old.job_id;
    update job_history set job_history.job_id = null where job_history.job_id = old.job_id;
end;
//

create trigger delete_employees_btrg
  before delete on employees for each row
begin
    update departments set departments.manager_id = null where departments.manager_id = old.employee_id;
    delete from job_history where job_history.employee_id = old.employee_id;
    -- update employees set employees.manager_id = null where employees.manager_id = old.employee_id;
end;
//

delimiter ;

commit;

-- Stored Routines : emulate Queries and DML statements
-- TODO: should create these sp in an utility database
--
delimiter //

create procedure checkNaN( value text )
begin
  select value REGEXP '^[0-9]+$';
end;
//

create procedure getConnId()
begin
  select /* k6_internal */ connection_id() as conn_id;
end;
//

create procedure getAllRows( in dbName text, in tabName text )
begin
--  declare EXIT HANDLER for SQLEXCEPTION
--  begin
--    select CONCAT(CONCAT(CONCAT( dbName, ' DB and/or '), tabName), ' TAB are not valid' ) ERROR_MSG;
--  end;
  set @DQRY := CONCAT(CONCAT(CONCAT('select /* k6_wrkld */ * from ', dbName), '.'), tabName);
  -- select @DQRY;
  prepare qry from @DQRY;
  execute qry;
  deallocate prepare qry;
end;
//

create procedure getRowsCount( in dbName text, in tabName text )
begin
--  declare EXIT HANDLER for SQLEXCEPTION
--  begin
--    select CONCAT(CONCAT(CONCAT( dbName, ' DB and/or '), tabName), ' TAB are not valid' ) ERROR_MSG;
--  end;
  set @DQRY := CONCAT(CONCAT(CONCAT('select /* k6_wrkld */ count(*) as total_rows from ', dbName), '.'), tabName);
  -- select @DQRY;
  prepare qry from @DQRY;
  execute qry;
  deallocate prepare qry;
end;
//

create procedure getRowById( in dbName text, in tabName text, in tabPKColName text, in idValue text )
begin
--  declare EXIT HANDLER for SQLEXCEPTION
--  begin
--    select CONCAT(CONCAT(CONCAT( dbName, ' DB and/or '), tabName), ' TAB are not valid' ) ERROR_MSG;
--  end;
  declare idValueFilter text;
  if checkNaN(idValue) then -- alphanumeric
    set idValueFilter := CONCAT(CONCAT('\'', idValue), '\'');
  else -- numeric
    set idValueFilter := idValue;
  end if;
  set @DQRY := CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT(CONCAT('select /* k6_wrkld */ * from ', dbName), '.'), tabName), ' where '), tabPKColName), ' = '), idValueFilter);
  -- select @DQRY;
  prepare qry from @DQRY;
  execute qry;
  deallocate prepare qry;
end;
//

delimiter ;

commit;
