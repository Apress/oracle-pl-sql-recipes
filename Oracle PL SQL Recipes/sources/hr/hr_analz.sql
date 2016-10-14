Rem
Rem $Header: hr_analz.sql 12-mar-2001.15:08:47 ahunold Exp $
Rem
Rem hr_analz.sql
Rem
Rem  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
Rem
Rem    NAME
Rem      hr_analz.sql - Gathering statistics for HR schema
Rem
Rem    DESCRIPTION
Rem      Staistics are used by the cost based optimizer to
Rem      choose the best physical access strategy
Rem
Rem    NOTES
Rem      Results can be viewed in columns of DBA_TABLES, 
Rem      DBA_TAB_COLUMNS and such
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ahunold     03/12/01 - cleanup b3
Rem    ahunold     03/07/01 - Merged ahunold_hr_analz
Rem    ahunold     03/07/01 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF

EXECUTE dbms_stats.gather_table_stats ('HR','COUNTRIES');
EXECUTE dbms_stats.gather_table_stats ('HR','DEPARTMENTS');
EXECUTE dbms_stats.gather_table_stats ('HR','EMPLOYEES');
EXECUTE dbms_stats.gather_table_stats ('HR','JOBS');
EXECUTE dbms_stats.gather_table_stats ('HR','JOB_HISTORY');
EXECUTE dbms_stats.gather_table_stats ('HR','LOCATIONS');
EXECUTE dbms_stats.gather_table_stats ('HR','REGIONS');