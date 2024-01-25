-- SQL Script
-- This script is distributed on an "as is" basis
-- without warranties or conditions of any kind.
-- Feel free to modify or use it.

-- Analyze hrdb Schema Tables (update stats)
use hrdb;

analyze table regions;

analyze table countries;

analyze table locations;

analyze table departments;

analyze table jobs;

analyze table employees;

-- analyze table job_history;
