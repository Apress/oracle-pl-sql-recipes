Rem
Rem $Header: hr_dn_d.sql 03-mar-2001.10:05:14 ahunold Exp $
Rem
Rem hr_dn_d.sql
Rem
Rem  Copyright (c) Oracle Corporation 2001. All Rights Reserved.
Rem
Rem    NAME
Rem      hr_dn_d.sql - Drop DN column from EMPLOYEES and DEPARTMENTS
Rem
Rem    DESCRIPTION
Rem      the DN (distinguished Name) column is used by OID.
Rem      This script drops the column from the HR schema. 
Rem
Rem    NOTES
Rem      Use this to undo changes made by hr_dn_c.sql
Rem
Rem    MODIFIED   (MM/DD/YY)
Rem    ahunold     03/03/01 - HR simplification, REGIONS table
Rem    ahunold     02/20/01 - Merged ahunold_american
Rem    ahunold     02/20/01 - Created
Rem

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO ON

ALTER TABLE departments
 DROP COLUMN dn ;

ALTER TABLE employees
 DROP COLUMN dn ; 