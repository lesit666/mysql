-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Inserting Data into the hr Database/Schema
use hrdb;

-- Regions data
INSERT INTO hrdb.regions (region_name) VALUES ('Europe');
INSERT INTO hrdb.regions (region_name) VALUES ('Americas');
INSERT INTO hrdb.regions (region_name) VALUES ('Asia');
INSERT INTO hrdb.regions (region_name) VALUES ('Middle East and Africa');


select count(*) num_rows from regions;

-- Countries data
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('AR','Argentina',2);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('AU','Australia',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('BE','Belgium',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('BR','Brazil',2);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('CA','Canada',2);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('CH','Switzerland',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('CN','China',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('DE','Germany',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('DK','Denmark',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('EG','Egypt',4);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('FR','France',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('IL','Israel',4);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('IN','India',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('IT','Italy',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('JP','Japan',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('KW','Kuwait',4);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('ML','Malaysia',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('MX','Mexico',2);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('NG','Nigeria',4);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('NL','Netherlands',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('SG','Singapore',3);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('UK','United Kingdom',1);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('US','United States of America',2);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('ZM','Zambia',4);
INSERT INTO hrdb.countries (country_id,country_name,region_id) VALUES ('ZW','Zimbabwe',4);


select count(*) num_rows from countries;

-- Locations data
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('1297 Via Cola di Rie','00989','Roma',NULL,'IT');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('93091 Calle della Testa','10934','Venice',NULL,'IT');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('9450 Kamiya-cho','6823','Hiroshima',NULL,'JP');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('2014 Jabberwocky Rd','26192','Southlake','Texas','US');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('2011 Interiors Blvd','99236','South San Francisco','California','US');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('2020 Zagora St','50090','South Brunswick','New Jersey','US');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('2018 Charade Rd','98199','Seattle','Washington','US');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('40-5-12 Laogianggen','190518','Beijing',NULL,'CN');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('1298 Vileparle (E)','490231','Bombay','Maharashtra','IN');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('12-98 Victoria Street','2901','Sydney','New South Wales','AU');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('198 Clementi North','540198','Singapore',NULL,'SG');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('8204 Arthur St',NULL,'London',NULL,'UK');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('9702 Chester Road','09629850293','Stretford','Manchester','UK');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Schwanthalerstr. 7031','80925','Munich','Bavaria','DE');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('20 Rue des Corps-Saints','1730','Geneva','Geneve','CH');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Murtenstrasse 921','3095','Bern','BE','CH');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL');
INSERT INTO hrdb.locations (street_address,postal_code,city,state_province,country_id) VALUES ('Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

select count(*) num_rows from locations;

-- Departments data
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Administration',1,7);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Marketing',4,6);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Purchasing',16,9);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Human Resources',10,3);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Shipping',64,19);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('IT',10,14);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Public Relations',13,21);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Sales',36,7);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Executive',1,2);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Finance',25,5);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Accounting',16,21);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Treasury',NULL,21);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Corporate Tax',NULL,21);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Control And Credit',NULL,23);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Shareholder Services',NULL,10);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Benefits',NULL,10);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Manufacturing',NULL,11);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Construction',NULL,2);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Contracting',NULL,6);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Operations',NULL,7);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('IT Support',NULL,14);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('NOC',NULL,14);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('IT Helpdesk',NULL,14);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Government Sales',NULL,1);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Retail Sales',NULL,14);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Recruiting',NULL,11);
INSERT INTO hrdb.departments (department_name,manager_id,location_id) VALUES ('Payroll',NULL,9);

select count(*) num_rows from departments;

-- Jobs data
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('AC_ACCOUNT','Public Accountant',4200,9000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('AC_MGR','Accounting Manager',8200,16000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('AD_ASST','Administration Assistant',3000,6000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('AD_PRES','President',20210,40000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('AD_VP','Administration Vice President',15000,30000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('FI_ACCOUNT','Accountant',4200,9000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('FI_MGR','Finance Manager',8200,16000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('HR_REP','Human Resources Representative',4000,9000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('IT_PROG','Programmer',4000,10000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('MK_MAN','Marketing Manager',9000,15000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('MK_REP','Marketing Representative',4000,9000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('PR_REP','Public Relations Representative',4500,10500);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('PU_CLERK','Purchasing Clerk',2500,5500);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('PU_MAN','Purchasing Manager',8000,15000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('SA_MAN','Sales Manager',10000,20210);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('SA_REP','Sales Representative',6000,12021);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('SH_CLERK','Shipping Clerk',2500,5500);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('ST_CLERK','Stock Clerk',2021,5000);
INSERT INTO hrdb.jobs (job_id,job_title,min_salary,max_salary) VALUES ('ST_MAN','Stock Manager',5500,8500);

select count(*) num_rows from jobs;

-- Employees data
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Steven','King','SKING','515.123.4567','2017-06-17 00:00:00','AD_PRES',24000.00,NULL,NULL,25);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Neena','Kochhar','NKOCHHAR','515.123.4568','2018-09-21 00:00:00','AD_VP',17000.00,NULL,1,25);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Lex','De Haan','LDEHAAN','515.123.4569','2020-01-13 00:00:00','AD_VP',17000.00,NULL,1,25);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alexander','Hunold','AHUNOLD','590.423.4567','2019-01-03 00:00:00','IT_PROG',9000.00,NULL,7,16);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Bruce','Ernst','BERNST','590.423.4568','2020-05-21 00:00:00','IT_PROG',6000.00,NULL,10,16);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('David','Austin','DAUSTIN','590.423.4569','2018-06-25 00:00:00','IT_PROG',4800.00,NULL,10,16);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Valli','Pataballa','VPATABAL','590.423.4560','2019-02-05 00:00:00','IT_PROG',4800.00,NULL,10,16);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Diana','Lorentz','DLORENTZ','590.423.5567','2020-02-07 00:00:00','IT_PROG',4200.00,NULL,10,16);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Nancy','Greenberg','NGREENBE','515.124.4569','2021-08-17 00:00:00','FI_MGR',12021.00,NULL,4,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Daniel','Faviet','DFAVIET','515.124.4169','2021-08-16 00:00:00','FI_ACCOUNT',9000.00,NULL,25,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('John','Chen','JCHEN','515.124.4269','2018-09-28 00:00:00','FI_ACCOUNT',8200.00,NULL,25,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Ismael','Sciarra','ISCIARRA','515.124.4369','2018-09-30 00:00:00','FI_ACCOUNT',7700.00,NULL,25,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jose Manuel','Urman','JMURMAN','515.124.4469','2019-03-07 00:00:00','FI_ACCOUNT',7800.00,NULL,25,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Luis','Popp','LPOPP','515.124.4567','2020-12-07 00:00:00','FI_ACCOUNT',6900.00,NULL,25,21);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Den','Raphaely','DRAPHEAL','515.127.4561','2021-12-07 00:00:00','PU_MAN',11000.00,NULL,1,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alexander','Khoo','AKHOO','515.127.4562','2017-05-18 00:00:00','PU_CLERK',3100.00,NULL,43,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Shelli','Baida','SBAIDA','515.127.4563','2018-12-24 00:00:00','PU_CLERK',2900.00,NULL,43,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Sigal','Tobias','STOBIAS','515.127.4564','2018-07-24 00:00:00','PU_CLERK',2800.00,NULL,43,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Guy','Himuro','GHIMURO','515.127.4565','2019-11-15 00:00:00','PU_CLERK',2600.00,NULL,43,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Karen','Colmenares','KCOLMENA','515.127.4566','2020-08-10 00:00:00','PU_CLERK',2500.00,NULL,43,7);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Matthew','Weiss','MWEISS','650.123.1234','2018-07-18 00:00:00','ST_MAN',8000.00,NULL,1,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Adam','Fripp','AFRIPP','650.123.2234','2018-04-10 00:00:00','ST_MAN',8200.00,NULL,1,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Payam','Kaufling','PKAUFLIN','650.123.3234','2017-05-01 00:00:00','ST_MAN',7900.00,NULL,1,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Shanta','Vollman','SVOLLMAN','650.123.4234','2018-10-10 00:00:00','ST_MAN',6500.00,NULL,1,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Kevin','Mourgos','KMOURGOS','650.123.5234','2020-11-16 00:00:00','ST_MAN',5800.00,NULL,1,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Julia','Nayer','JNAYER','650.124.1214','2018-07-16 00:00:00','ST_CLERK',3200.00,NULL,37,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Irene','Mikkilineni','IMIKKILI','650.124.1224','2019-09-28 00:00:00','ST_CLERK',2700.00,NULL,37,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('James','Landry','JLANDRY','650.124.1334','2020-01-14 00:00:00','ST_CLERK',2400.00,NULL,37,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Steven','Markle','SMARKLE','650.124.1434','2021-03-08 00:00:00','ST_CLERK',2200.00,NULL,37,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Laura','Bissot','LBISSOT','650.124.5234','2018-08-20 00:00:00','ST_CLERK',3300.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Mozhe','Atkinson','MATKINSO','650.124.6234','2018-10-30 00:00:00','ST_CLERK',2800.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('James','Marlow','JAMRLOW','650.124.7234','2018-02-16 00:00:00','ST_CLERK',2500.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('TJ','Olson','TJOLSON','650.124.8234','2020-04-10 00:00:00','ST_CLERK',2100.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jason','Mallin','JMALLIN','650.127.1934','2018-06-14 00:00:00','ST_CLERK',3300.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Michael','Rogers','MROGERS','650.127.1834','2019-08-26 00:00:00','ST_CLERK',2900.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Ki','Gee','KGEE','650.127.1734','2020-12-12 00:00:00','ST_CLERK',2400.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Hazel','Philtanker','HPHILTAN','650.127.1634','2021-02-06 00:00:00','ST_CLERK',2200.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Renske','Ladwig','RLADWIG','650.121.1234','2017-07-14 00:00:00','ST_CLERK',3600.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Stephen','Stiles','SSTILES','650.121.2034','2018-10-26 00:00:00','ST_CLERK',3200.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('John','Seo','JSEO','650.121.2019','2019-02-12 00:00:00','ST_CLERK',2700.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Joshua','Patel','JPATEL','650.121.1834','2019-04-06 00:00:00','ST_CLERK',2500.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Trenna','Rajs','TRAJS','650.121.8009','2017-10-17 00:00:00','ST_CLERK',3500.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Curtis','Davies','CDAVIES','650.121.2994','2018-01-29 00:00:00','ST_CLERK',3100.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Randall','Matos','RMATOS','650.121.2874','2019-03-15 00:00:00','ST_CLERK',2600.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Peter','Vargas','PVARGAS','650.121.2018','2019-07-09 00:00:00','ST_CLERK',2500.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('John','Russell','JRUSSEL','011.44.1344.429268','2018-10-01 00:00:00','SA_MAN',14000.00,0.40,1,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Karen','Partners','KPARTNER','011.44.1344.467268','2018-01-05 00:00:00','SA_MAN',13500.00,0.30,1,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alberto','Errazuriz','AERRAZUR','011.44.1344.429278','2018-03-10 00:00:00','SA_MAN',12000.00,0.30,1,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Gerald','Cambrault','GCAMBRAU','011.44.1344.619268','2020-10-15 00:00:00','SA_MAN',11000.00,0.30,1,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018','2021-01-29 00:00:00','SA_MAN',10500.00,0.20,1,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Peter','Tucker','PTUCKER','011.44.1344.129268','2018-01-30 00:00:00','SA_REP',10000.00,0.30,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('David','Bernstein','DBERNSTE','011.44.1344.345268','2018-03-24 00:00:00','SA_REP',9500.00,0.25,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Peter','Hall','PHALL','011.44.1344.478968','2018-08-20 00:00:00','SA_REP',9000.00,0.25,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Christopher','Olsen','COLSEN','011.44.1344.498718','2019-03-30 00:00:00','SA_REP',8000.00,0.20,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Nanette','Cambrault','NCAMBRAU','011.44.1344.987668','2019-12-09 00:00:00','SA_REP',7500.00,0.20,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Oliver','Tuvault','OTUVAULT','011.44.1344.486508','2020-11-23 00:00:00','SA_REP',7000.00,0.15,36,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Janette','King','JKING','011.44.1345.429268','2018-01-30 00:00:00','SA_REP',10000.00,0.35,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Patrick','Sully','PSULLY','011.44.1345.929268','2018-03-04 00:00:00','SA_REP',9500.00,0.35,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Allan','McEwen','AMCEWEN','011.44.1345.829268','2018-08-01 00:00:00','SA_REP',9000.00,0.35,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Lindsey','Smith','LSMITH','011.44.1345.729268','2018-03-10 00:00:00','SA_REP',8000.00,0.30,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Louise','Doran','LDORAN','011.44.1345.629268','2018-12-15 00:00:00','SA_REP',7500.00,0.30,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Sarath','Sewall','SSEWALL','011.44.1345.529268','2019-11-03 00:00:00','SA_REP',7000.00,0.25,39,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Clara','Vishney','CVISHNEY','011.44.1346.129268','2018-11-11 00:00:00','SA_REP',10500.00,0.25,42,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Danielle','Greene','DGREENE','011.44.1346.229268','2020-03-19 00:00:00','SA_REP',9500.00,0.15,42,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Mattea','Marvins','MMARVINS','011.44.1346.329268','2021-01-24 00:00:00','SA_REP',7200.00,0.10,42,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('David','Lee','DLEE','011.44.1346.529268','2021-02-23 00:00:00','SA_REP',6800.00,0.10,42,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Sundar','Ande','SANDE','011.44.1346.629268','2021-03-24 00:00:00','SA_REP',6400.00,0.10,42,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Amit','Banda','ABANDA','011.44.1346.729268','2021-04-21 00:00:00','SA_REP',6200.00,0.10,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Lisa','Ozer','LOZER','011.44.1343.929268','2018-03-11 00:00:00','SA_REP',11500.00,0.25,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Harrison','Bloom','HBLOOM','011.44.1343.829268','2019-03-23 00:00:00','SA_REP',10000.00,0.20,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Tayler','Fox','TFOX','011.44.1343.729268','2019-01-24 00:00:00','SA_REP',9600.00,0.20,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('William','Smith','WSMITH','011.44.1343.629268','2020-02-23 00:00:00','SA_REP',7400.00,0.15,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Elizabeth','Bates','EBATES','011.44.1343.529268','2020-03-24 00:00:00','SA_REP',7300.00,0.15,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Sundita','Kumar','SKUMAR','011.44.1343.329268','2021-04-21 00:00:00','SA_REP',6100.00,0.10,45,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Ellen','Abel','EABEL','011.44.1644.429267','2018-05-11 00:00:00','SA_REP',11000.00,0.30,48,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alyssa','Hutton','AHUTTON','011.44.1644.429266','2018-03-19 00:00:00','SA_REP',8800.00,0.25,48,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jonathon','Taylor','JTAYLOR','011.44.1644.429265','2019-03-24 00:00:00','SA_REP',8600.00,0.20,48,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jack','Livingston','JLIVINGS','011.44.1644.429264','2019-04-23 00:00:00','SA_REP',8400.00,0.20,48,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Kimberely','Grant','KGRANT','011.44.1644.429263','2020-05-24 00:00:00','SA_REP',7000.00,0.15,48,NULL);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Charles','Johnson','CJOHNSON','011.44.1644.429262','2021-01-04 00:00:00','SA_REP',6200.00,0.10,48,22);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Winston','Taylor','WTAYLOR','650.507.9876','2019-01-24 00:00:00','SH_CLERK',3200.00,NULL,61,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jean','Fleaur','JFLEAUR','650.507.9877','2019-02-23 00:00:00','SH_CLERK',3100.00,NULL,61,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Martha','Sullivan','MSULLIVA','650.507.9878','2020-06-21 00:00:00','SH_CLERK',2500.00,NULL,61,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Girard','Geoni','GGEONI','650.507.9879','2021-02-03 00:00:00','SH_CLERK',2800.00,NULL,61,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Nandita','Sarchand','NSARCHAN','650.509.1876','2018-01-27 00:00:00','SH_CLERK',4200.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alexis','Bull','ABULL','650.509.2876','2018-02-20 00:00:00','SH_CLERK',4100.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Julia','Dellinger','JDELLING','650.509.3876','2019-06-24 00:00:00','SH_CLERK',3400.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Anthony','Cabrio','ACABRIO','650.509.4876','2020-02-07 00:00:00','SH_CLERK',3000.00,NULL,64,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Kelly','Chung','KCHUNG','650.505.1876','2018-06-14 00:00:00','SH_CLERK',3800.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jennifer','Dilly','JDILLY','650.505.2876','2018-08-13 00:00:00','SH_CLERK',3600.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Timothy','Gates','TGATES','650.505.3876','2019-07-11 00:00:00','SH_CLERK',2900.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Randall','Perkins','RPERKINS','650.505.4876','2020-12-19 00:00:00','SH_CLERK',2500.00,NULL,67,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Sarah','Bell','SBELL','650.501.1876','2018-02-04 00:00:00','SH_CLERK',4000.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Britney','Everett','BEVERETT','650.501.2876','2018-03-03 00:00:00','SH_CLERK',3900.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Samuel','McCain','SMCCAIN','650.501.3876','2019-07-01 00:00:00','SH_CLERK',3200.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Vance','Jones','VJONES','650.501.4876','2020-03-17 00:00:00','SH_CLERK',2800.00,NULL,70,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Alana','Walsh','AWALSH','650.507.9811','2019-04-24 00:00:00','SH_CLERK',3100.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Kevin','Feeney','KFEENEY','650.507.9822','2019-05-23 00:00:00','SH_CLERK',3000.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Donald','OConnell','DOCONNEL','650.507.9833','2020-06-21 00:00:00','SH_CLERK',2600.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Douglas','Grant','DGRANT','650.507.9844','2021-01-13 00:00:00','SH_CLERK',2600.00,NULL,73,13);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Jennifer','Whalen','JWHALEN','515.123.4444','2017-09-17 00:00:00','AD_ASST',4400.00,NULL,4,1);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Michael','Hartstein','MHARTSTE','515.123.5555','2018-02-17 00:00:00','MK_MAN',13000.00,NULL,1,4);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Pat','Fay','PFAY','603.123.6666','2018-08-17 00:00:00','MK_REP',6000.00,NULL,4,4);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Susan','Mavris','SMAVRIS','515.123.7777','2021-06-07 00:00:00','HR_REP',6500.00,NULL,4,10);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Hermann','Baer','HBAER','515.123.8888','2021-06-07 00:00:00','PR_REP',10000.00,NULL,4,19);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('Shelley','Higgins','SHIGGINS','515.123.8080','2021-06-07 00:00:00','AC_MGR',12021.00,NULL,4,14);
INSERT INTO hrdb.employees (first_name,last_name,email,phone_number,hire_date,job_id,salary,commission_pct,manager_id,department_id) VALUES ('William','Gietz','WGIETZ','515.123.8181','2021-06-07 00:00:00','AC_ACCOUNT',8300.00,NULL,16,14);

select count(*) num_rows from employees;

-- Job History data
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (4,'2018-09-21 00:00:00','2020-10-27 00:00:00','AC_ACCOUNT',27);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (4,'2020-10-28 00:00:00','2021-03-15 00:00:00','AC_MGR',27);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (7,'2019-01-13 00:00:00','2020-07-24 00:00:00','IT_PROG',16);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (29,'2018-03-24 00:00:00','2019-12-31 00:00:00','SA_REP',22);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (29,'2020-01-01 00:00:00','2020-12-31 00:00:00','SA_MAN',22);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (43,'2019-03-24 00:00:00','2020-12-31 00:00:00','ST_CLERK',13);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (67,'2019-01-01 00:00:00','2020-12-31 00:00:00','ST_CLERK',13);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (101,'2014-09-17 00:00:00','2020-06-17 00:00:00','AD_ASST',25);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (101,'2019-07-01 00:00:00','2021-12-31 00:00:00','AC_ACCOUNT',25);
INSERT INTO hrdb.job_history (employee_id,start_date,end_date,job_id,department_id) VALUES (104,'2018-02-17 00:00:00','2020-12-19 00:00:00','MK_REP',4);

commit;

select count(*) num_rows from job_history;

-- foreign keys

alter table countries add constraint country_region_fk foreign key ( region_id )
  references regions( region_id );

alter table locations add constraint location_country_fk foreign key ( country_id )
  references countries( country_id );

alter table departments add constraint department_location_fk foreign key ( location_id )
  references locations ( location_id );

alter table departments add constraint department_employee_fk foreign key ( manager_id )
  references employees ( employee_id );

alter table employees add constraint employee_job_fk foreign key ( job_id )
  references jobs ( job_id );

alter table employees add constraint employee_employee_fk foreign key ( manager_id )
  references employees ( employee_id ) on delete set null;

alter table employees add constraint employee_department_fk foreign key (department_id)
  references departments ( department_id );

alter table job_history add constraint jobhist_job_fk foreign key( job_id )
  references jobs( job_id );

alter table job_history add constraint jobhist_employee_fk foreign key( employee_id )
  references employees( employee_id );

alter table job_history add constraint jobhist_department_fk foreign key( department_id )
  references departments( department_id );
