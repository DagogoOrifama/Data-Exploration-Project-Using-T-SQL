/*
* File: Dagogo_Orifama.sql
* Title: Data Exploration project in using TSQL
* Author: Dagogo Orifama
* StudentID: @00704109
* Module: Advanced Databases
* -------------------------------------------------------------------------------
* *****************************************Description***************************
* -------------------------------------------------------------------------------
* This file contains the T-SQL for the data exploration solutions in task 2
* 
*/

--Create and use database
CREATE DATABASE PrescriptionsDB;
USE PrescriptionsDB;

--Creating primary keys of the various tables

-- adding the BNF_CODE as primary key to the Drugs table
ALTER TABLE dbo.Drugs
ADD CONSTRAINT PK_drug PRIMARY KEY (BNF_CODE);

-- adding the BNF_CODE as primary key to the Drugs table
ALTER TABLE dbo.Medical_Practice
ADD CONSTRAINT PK_Medical PRIMARY KEY (PRACTICE_CODE);

-- adding the PRESCRIPTION_CODE as primary key to the Drugs table
ALTER TABLE dbo.Prescriptions
ADD CONSTRAINT PK_Presc PRIMARY KEY (PRESCRIPTION_CODE);

-- Reference: FK_Presc_drug (table: dbo.Prescription)
ALTER TABLE dbo.Prescriptions ADD CONSTRAINT  FK_Presc_drug
    FOREIGN KEY (BNF_CODE)
    REFERENCES dbo.Drugs (BNF_CODE);

-- Reference: FK_Presc_Medical (table: dbo.Prescription)
ALTER TABLE dbo.Prescriptions ADD CONSTRAINT  FK_Presc_Medical
    FOREIGN KEY (PRACTICE_CODE)
    REFERENCES dbo.Medical_Practice (PRACTICE_CODE);



/*
Question 1
Write a query that returns details of all drugs which are in the form of tablets or
capsules. You can assume that all drugs in this form will have one of these words in the
BNF_DESCRIPTION column.
*/
SELECT * FROM dbo.Drugs 
WHERE BNF_DESCRIPTION 
LIKE '%tablets%' OR BNF_DESCRIPTION LIKE '%capsules%'

/*
Question 2
Write a query that returns the total quantity for each of prescriptions – this is given by
the number of items multiplied by the quantity. Some of the quantities are not integer
values and your client has asked you to round the result to the nearest integer value.
*/
SELECT PRESCRIPTION_CODE, BNF_CODE, ROUND(QUANTITY, 0) AS QUANTITY, ITEMS,
(ROUND(QUANTITY, 0)* ITEMS) AS TOTAL_PRESCRIPTION
FROM dbo.Prescriptions;


/*
Question 3
Write a query that returns a list of the distinct chemical substances which appear in
the Drugs table (the chemical substance is listed in the
CHEMICAL_SUBSTANCE_BNF_DESCR column)
*/
SELECT DISTINCT CHEMICAL_SUBSTANCE_BNF_DESCR 
FROM dbo.Drugs;


/*
Question 4
Write a query that returns the number of prescriptions for each
BNF_CHAPTER_PLUS_CODE, along with the average cost for that chapter code, and the
minimum and maximum prescription costs for that chapter code.
*/
SELECT dr.BNF_CHAPTER_PLUS_CODE, 
COUNT(dr.BNF_CHAPTER_PLUS_CODE) as 'PRESCRIPTIONS_PER_BNF_CHAPTER_PLUS_CODE', 
AVG(pr.ACTUAL_COST) AS AVERAGE_COST,
MIN(pr.ACTUAL_COST) AS MIN_COST,
MAX(pr.ACTUAL_COST) AS MAX_COST
FROM dbo.Prescriptions AS pr
INNER JOIN dbo.Drugs AS dr
ON pr.BNF_CODE = dr.BNF_CODE
GROUP BY dr.BNF_CHAPTER_PLUS_CODE;


/*
Question 5
Write a query that returns the most expensive prescription prescribed by each
practice, sorted in descending order by prescription cost (the ACTUAL_COST column in
the prescription table.) Return only those rows where the most expensive prescription
is more than £4000. You should include the practice name in your result.
*/

SELECT med.PRACTICE_NAME, pre.PRACTICE_CODE, 
MAX(pre.ACTUAL_COST) AS MOST_EXPENSIVE_PRESC_BY_PRACTICE
FROM dbo.Prescriptions AS pre
INNER JOIN dbo.Medical_Practice med
ON pre.PRACTICE_CODE = med.PRACTICE_CODE
GROUP BY pre.PRACTICE_CODE, med.PRACTICE_NAME
HAVING MAX(pre.ACTUAL_COST) > 4000
ORDER BY MAX(pre.ACTUAL_COST) DESC;

/*
Question 6
Write a query that returns the number of prescriptions for each CHEMICAL_SUBSTANCE_BNF_DESCR, 
along with the average cost for that chapter code. Return only chemical substances with a number 
of prescriptions prescription greater than 100, it should be sorted alphabetically by the 
CHEMICAL_SUBSTANCE_BNF_DESCR.
*/
SELECT dr.CHEMICAL_SUBSTANCE_BNF_DESCR, 
COUNT(dr.CHEMICAL_SUBSTANCE_BNF_DESCR) as 'PRESCRIPTIONS_PER_CHEMICAL_SUBSTANCE_BNF_DESCR', 
AVG(pr.ACTUAL_COST) AS AVERAGE_COST
FROM dbo.Prescriptions AS pr
INNER JOIN dbo.Drugs AS dr
ON pr.BNF_CODE = dr.BNF_CODE
GROUP BY dr.CHEMICAL_SUBSTANCE_BNF_DESCR
HAVING COUNT(dr.CHEMICAL_SUBSTANCE_BNF_DESCR) > 100
ORDER BY dr.CHEMICAL_SUBSTANCE_BNF_DESCR;

/*
Question 7
Write a query that returns details of all drugs with above 100mg and belong to either the "01: Gastro-Intestinal System" or 
"05: Infections" BNF_CHAPTER_PLUS_CODE. Assume that all drugs in this form will have its mg specification 
in the BNF_DESCRIPTION column.
*/

SELECT * FROM dbo.Drugs
WHERE BNF_DESCRIPTION  LIKE '%_00mg%' AND 
BNF_CHAPTER_PLUS_CODE IN(SELECT DISTINCT BNF_CHAPTER_PLUS_CODE FROM dbo.Drugs 
									WHERE BNF_CHAPTER_PLUS_CODE LIKE '01%' OR BNF_CHAPTER_PLUS_CODE LIKE '05%')

/*
QUESTION 8
A query to return all medical practices in bolton, with a prescription quantity above 100
It should include the count for each medical practice.
*/
SELECT mprac.PRACTICE_CODE, 
COUNT(mprac.PRACTICE_CODE) AS FREQUENCY, 
mprac.ADDRESS_3
FROM dbo.Medical_Practice mprac
INNER JOIN dbo.Prescriptions pres
ON pres.PRACTICE_CODE = mprac.PRACTICE_CODE
WHERE ADDRESS_3 = 'BOLTON' AND EXISTS(
		SELECT * FROM dbo.Prescriptions
		WHERE pres.QUANTITY > 100
)
GROUP BY mprac.PRACTICE_CODE, mprac.ADDRESS_3
 
 --select * from Prescriptions where PRACTICE_CODE = 'P82652' and QUANTITY > 100
/*
QUESTION 9
Write a query that returns the total prescriptions for each BNF_CODE and their corresponding total quantity. 
Return only prescriptions with total quantity above 1000 and a prescription count greater than 15. .
*/
SELECT BNF_CODE, 
COUNT(BNF_CODE) AS TOTAL_PRESC_PER_BNF_CODE, 
(QUANTITY * ITEMS) AS TOTAL_QUANTITY
FROM dbo.Prescriptions
GROUP BY BNF_CODE, (QUANTITY * ITEMS)
HAVING (QUANTITY * ITEMS) > 1000 AND COUNT(BNF_CODE) > 15

/*
QUESTION 10
Write a query to return the number of chemical substances associated by a practice name
sorted in descending order by the frequency.
*/

SELECT mp.PRACTICE_NAME, dr.CHEMICAL_SUBSTANCE_BNF_DESCR, 
COUNT(dr.CHEMICAL_SUBSTANCE_BNF_DESCR) AS NUMBER_OF_CHEM_SUBST
FROM dbo.Drugs dr
INNER JOIN Prescriptions pr
ON dr.BNF_CODE = pr.BNF_CODE
INNER JOIN Medical_Practice mp
ON pr.PRACTICE_CODE = mp.PRACTICE_CODE
GROUP BY mp.PRACTICE_NAME, dr.CHEMICAL_SUBSTANCE_BNF_DESCR
ORDER BY NUMBER_OF_CHEM_SUBST DESC