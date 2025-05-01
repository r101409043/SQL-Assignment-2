-- Using Northwind Database: (Use aliases for all the Joins)
-- List all Products that has been sold at least once in last 27 years.
WITH ProductID AS
	     (
		     SELECT od.ProductID, o.OrderID, o.OrderDate
		     FROM [Order Details] od
		     JOIN Orders O ON O.OrderID = od.OrderID
	     )
SELECT DISTINCT p.ProductName AS [Product Name]
FROM products p
JOIN ProductID id ON p.ProductID = id.ProductID
WHERE id.OrderDate >= DATEADD(YEAR, -27, GETDATE())
-- List top 5 locations (Zip Code) where the products sold most.
SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS Sold
FROM Orders o
GROUP BY o.ShipPostalCode
-- List top 5 locations (Zip Code) where the products sold most in last 27 years.
SELECT TOP 5 o.ShipPostalCode, COUNT(*) AS Sold
FROM Orders o
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY o.ShipPostalCode
-- List all city names and number of customers in that city.   
SELECT City, COUNT(*) AS CustomersNum
FROM Customers
GROUP BY City
-- List city names which have more than 2 customers, and number of customers in that city
SELECT City, COUNT(*) AS CustomersNum
FROM Customers
GROUP BY City
HAVING COUNT(*) > 2
-- List the names of customers who placed orders after 1/1/98 with order date.
SELECT DISTINCT c.CompanyName AS CustomersNames
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '1998-01-01'
-- List the names of all customers with most recent order dates
SELECT c.CompanyName AS CustomersName, MAX(o.OrderDate) AS OrderDates
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CompanyName
-- Display the names of all customers  along with the  count of products they bought
SELECT c.CompanyName AS CustomersName, SUM(od.Quantity) AS CountedProducts
FROM Orders o
-- get CustomersName by using CustomerID
JOIN Customers c ON o.CustomerID = c.CustomerID
-- get Order Quantity by using OrderID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName
-- Display the customer ids who bought more than 100 Products with count of products.
SELECT o.CustomerID AS CustomerID, SUM(od.Quantity) AS CountedProducts
FROM Orders o
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
HAVING SUM(od.Quantity) > 100
-- List all of the possible ways that suppliers can ship their products. Display the results as below
-- Supplier Company Name                Shipping Company Name
-- -------------------------            ----------------------------------
SELECT su.CompanyName AS "Supplier Company Name", sh.CompanyName AS "Shipping Company Name"
FROM Products p
-- get Supplier Company Name by using SupplierID
JOIN Suppliers su ON p.SupplierID = su.SupplierID
-- get OrderID by using ProductID
JOIN [Order Details] od ON p.ProductID = od.ProductID
-- get ShipVia by OrderID
JOIN Orders o ON od.OrderID = o.OrderID
-- get Shipping Company Name by using ShipVia/ShipperID
JOIN Shippers sh ON o.ShipVia = sh.ShipperID
-- Display the products order each day. Show Order date and Product Name.
SELECT o.OrderDate AS [Order date], p.ProductName AS [Product Name]
FROM Products p
-- get OrderID by using ProductID
JOIN [Order Details] od ON p.ProductID = od.ProductID
-- get OrderDate by using OrderID
JOIN Orders o ON od.OrderID = o.OrderID
-- Displays pairs of employees who have the same job title.
SELECT DISTINCT e1.TITLE AS [job title], e1.FirstName + ' ' + e1.LastName AS employees1,
                e2.FirstName + ' ' + e2.LastName AS employees2
FROM Employees e1
JOIN Employees e2 ON e1.Title = e2.Title AND e1.EmployeeID < e2.EmployeeID
-- Display all the Managers who have more than 2 employees reporting to them.
SELECT e.FirstName + ' ' + e.LastName AS Manager, e.Title
FROM Employees e
WHERE e.EmployeeID IN
      (
	      SELECT ReportsTo
	      FROM Employees
	      WHERE ReportsTo IS NOT NULL
	      GROUP BY ReportsTo
	      HAVING COUNT(*) > 2
      );
-- Display the customers and suppliers by city. The results should have the following columns
-- City, Name, Contact Name, Type (Customer or Supplier)
SELECT c.City AS City, c.CompanyName AS Name, c.ContactName AS [Contact Name], 'Customer' AS Type
FROM Customers c
UNION ALL
SELECT s.City AS City, s.CompanyName AS Name, s.ContactName AS [Contact Name], 'Supplier' AS Type
FROM Suppliers s 
ORDER BY City