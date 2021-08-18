-- ================================================================= --
-- Date: 17 February 2021
-- Author: Kyra E Alday
-- Topic: Databases (Week 3)
-- Description: SQL Database for RobsRentals (Assignment 2)
-- ================================================================= --

-- ================================================================= --
-- Create Database: Robs Rentals
-- ================================================================= --

USE master -- connect to the MASTER database
GO		   -- commits all of the preceeding statements to the database if not committed yet 

-- check if database exists - delete if does (DROP)
IF EXISTS( SELECT *
		   FROM	  master..sysdatabases
		   WHERE  name = 'RobsRentals'
		 )
DROP DATABASE RobsRentals;
GO

CREATE DATABASE RobsRentals;
GO
USE RobsRentals; -- connect RobsRentals database for all of what follows
GO 

-- CUSTOMER TABLE
CREATE TABLE CUSTOMER(
cust_num	NCHAR(4),
title		NVARCHAR(4),
cust_name	NVARCHAR(20)	-- multi-valued attribute (i.e. first and last names)

CONSTRAINT customer_PK PRIMARY KEY (cust_num)
);
GO

-- MODEL TABLE
CREATE TABLE MODEL(
model_code	NVARCHAR(5),
model_name	NVARCHAR(40),
mth_charge	MONEY

CONSTRAINT model_PK PRIMARY KEY (model_code)
);
GO

-- APPLIANCE TABLE
CREATE TABLE APPLIANCE(
stock_num	NCHAR(4),
model_num	NVARCHAR(5),
condition	NCHAR(1) NULL,	-- allow NULL
date_maint	DATETIME NULL

CONSTRAINT appliance_PK PRIMARY KEY (stock_num)
);
GO

-- HIRE TABLE
CREATE TABLE HIRE(
stock_num	NCHAR(4),
date_hired	DATETIME,
cust_num	NCHAR(4),
paid_till	DATETIME,
date_ret	DATETIME

CONSTRAINT hire_PK PRIMARY KEY (date_hired, stock_num)
CONSTRAINT hire_customer_FK FOREIGN KEY (cust_num) REFERENCES CUSTOMER
);
GO

-- ================================================================= --
-- Insert Test Data
-- ================================================================= --

USE RobsRentals;
GO
SET DATEFORMAT dmy;
GO

-- CUSTOMER data
INSERT INTO customer VALUES ('1001','Mr','Isaac Newton')
INSERT INTO customer VALUES ('1002','Ms','Freda Bloggs')
INSERT INTO customer VALUES ('1003','Dr','Stan Smith')
INSERT INTO customer VALUES ('1004','Ms','Alice Adams')
INSERT INTO customer VALUES ('1005','Mr','Max Miller')
INSERT INTO customer VALUES ('1006','Dr','Zeg Zebra')

-- MODEL data
INSERT INTO model VALUES ('AX323','50 cm National Colour TV',89)
INSERT INTO model VALUES ('AX747','90 cm Sanyo Colour TV',169)
INSERT INTO model VALUES ('BX111','4 channel integrated video rectifier',45)

-- APPLIANCE data
INSERT INTO appliance VALUES ('2001','AX323','E',NULL)
INSERT INTO appliance VALUES ('2002','AX323','S','07/07/1991')
INSERT INTO appliance VALUES ('2003','BX111','R',NULL)
INSERT INTO appliance VALUES ('2004','AX323','E','06/06/1991')
INSERT INTO appliance VALUES ('2005','AX747','E',NULL)
INSERT INTO appliance VALUES ('2006','AX747','R','08/08/1991')

-- HIRE data
INSERT INTO hire VALUES ('2001','01/01/1980','1005','01/02/1980','01/02/1980')
INSERT INTO hire VALUES ('2001','05/01/1990','1001','05/03/1990','05/03/1990')
INSERT INTO hire VALUES ('2001','08/03/1990','1002','07/06/1990','08/06/1990')
INSERT INTO hire VALUES ('2002','08/03/1990','1002','08/04/1990','08/04/1990')
INSERT INTO hire VALUES ('2003','05/01/1990','1001','05/07/1990','05/07/1990')
INSERT INTO hire VALUES ('2004','05/01/1990','1001','05/02/1990','05/02/1990')
INSERT INTO hire VALUES ('2004','01/02/1991','1001','02/02/1992',NULL)
INSERT INTO hire VALUES ('2005','10/02/1991','1003','12/12/1992',NULL)
INSERT INTO hire VALUES ('2006','01/07/1989','1003','30/11/1989','30/11/1989')


-- alter tables to add foreign keys
ALTER TABLE HIRE ADD CONSTRAINT hire_applicance_FK FOREIGN KEY (stock_num) REFERENCES APPLIANCE;
ALTER TABLE APPLIANCE ADD CONSTRAINT appliance_model_FK FOREIGN KEY (model_num) REFERENCES MODEL;
GO