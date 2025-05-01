-- How many products can you find in the Production.Product table?
SELECT COUNT(*) AS CountedProducts
FROM Production.Product p;
-- Write a query that retrieves the number of products in the Production.Product table that are included in a subcategory. 
-- The rows that have NULL in column ProductSubcategoryID are considered to not be a part of any subcategory.
SELECT COUNT(*) AS CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL;
-- How many Products reside in each SubCategory? Write a query to display the results with the following titles.
-- ProductSubcategoryID CountedProducts
-- ------------------ ---------------
SELECT p.ProductSubcategoryID, COUNT(*) AS CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;
-- How many products that do not have a product subcategory.
SELECT COUNT(*) AS CountedProducts
FROM Production.Product p
WHERE p.ProductSubcategoryID IS NULL;
-- Write a query to list the sum of products quantity in the Production.ProductInventory table.
SELECT SUM(p.quantity) AS TheSum
FROM Production.ProductInventory p;
-- Write a query to list the sum of products in the Production.ProductInventory table and 
-- LocationID set to 40 and limit the result to include just summarized quantities less than 100.
-- ProductID    TheSum
-- ---------    ----------
SELECT p.ProductID, SUM(p.quantity) AS TheSum
FROM Production.ProductInventory p
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(p.quantity) < 100;
-- Write a query to list the sum of products with the shelf information in the Production.ProductInventory table and 
-- LocationID set to 40 and limit the result to include just summarized quantities less than 100
-- Shelf      ProductID    TheSum
-- --------   -----------  -----------
SELECT p.Shelf, p.ProductID, SUM(p.quantity) AS TheSum
FROM Production.ProductInventory p
WHERE LocationID = 40
GROUP BY p.Shelf, p.ProductID
HAVING SUM(p.quantity) < 100;
-- Write the query to list the average quantity for products where 
-- column LocationID has the value of 10 from the table Production.ProductInventory table.
SELECT AVG(p.quantity) AS TheAvg
FROM Production.ProductInventory p
WHERE LocationID = 10;
-- Write query  to see the average quantity  of  products by shelf  from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
-- --------- ---------- -----------
SELECT p.ProductID, p.Shelf, AVG(p.quantity) AS TheAvg
FROM Production.ProductInventory p
GROUP BY p.ProductID, p.Shelf;
-- Write query  to see the average quantity  of  products by shelf excluding rows that 
-- has the value of N/A in the column Shelf from the table Production.ProductInventory
-- ProductID   Shelf      TheAvg
-- --------- ---------- -----------
SELECT p.ProductID, p.Shelf, AVG(p.quantity) AS TheAvg
FROM Production.ProductInventory p
WHERE Shelf != 'N/A'
GROUP BY p.ProductID, p.Shelf;
-- List the members (rows) and average list price in the Production.Product table. 
-- This should be grouped independently over the Color and the Class column. Exclude the rows where Color or Class are null.
-- Color       Class      TheCount     AvgPrice
-- -----      ------      --------     ---------
SELECT p.Color, p.Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product p
WHERE p.Class IS NOT NULL AND p.Color IS NOT NULL
GROUP BY p.Color, p.Class;

-- Joins:
-- Write a query that lists the country and province names 
-- from person. CountryRegion and Person. StateProvince tables. 
-- Join them and produce a result set similar to the following.
-- Country     Province
-- ---------   ----------
-- CTE To get Country Name by using BusinessEntityID -> AddressID -> StateProvinceID -> CountryRegionCode -> Country Name
WITH CountryName AS 
	     (
		     SELECT b.BusinessEntityID, c.Name AS CountryName
			 FROM Person.BusinessEntityAddress b
		     -- get StateProvinceID by using AddressID
		     JOIN Person.Address a ON A.AddressID = b.AddressID
			 -- get CountryRegionCode by using StateProvinceID   
		     JOIN Person.StateProvince s ON a.StateProvinceID = s.StateProvinceID
			 -- get the country name by using CountryRegionCode
		     JOIN Person.CountryRegion c ON s.CountryRegionCode = c.CountryRegionCode
	     )
SELECT c.CountryName AS Country,
       p.FirstName + IIF(p.MiddleName IS NOT NULL, ' ' + p.MiddleName, '') + ',' + p.LastName AS Province
FROM Person.Person p
-- JOIN CTE & get Country name by using BusinessEntityID
JOIN CountryName c ON p.BusinessEntityID = c.BusinessEntityID

-- Write a query that lists the country and province names 
-- from person. CountryRegion and Person. StateProvince tables.
-- list the countries filter them by Germany and Canada. 
-- Join them and produce a result set similar to the following.
-- Country     Province
-- ---------   ----------
SELECT c.Name AS Country,
       p.FirstName + IIF(p.MiddleName IS NOT NULL, ' ' + p.MiddleName, '') + ',' + p.LastName AS Province
FROM Person.Person p
-- get AddressID by using BusinessEntityID
JOIN Person.BusinessEntityAddress b ON p.BusinessEntityID = b.BusinessEntityID
-- get StateProvinceID by using AddressID
JOIN Person.Address a ON b.AddressID = a.AddressID
-- get CountryRegionCode by using StateProvinceID
JOIN Person.StateProvince s ON a.StateProvinceID = s.StateProvinceID
-- get the country name by using CountryRegionCode
JOIN Person.CountryRegion c ON s.CountryRegionCode = c.CountryRegionCode
WHERE c.Name = 'Germany' OR c.Name = 'Canada'
ORDER BY Country;
