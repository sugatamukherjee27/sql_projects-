-- Create the customers table
CREATE TABLE customers (
    CustomerID INTEGER,
    Country TEXT
);

-- Create the products table
CREATE TABLE products (
    StockCode INTEGER,
    Description TEXT
);

-- Create the invoices table
CREATE TABLE invoices (
    InvoiceNo INTEGER,
    StockCode INTEGER,
    Quantity INTEGER,
    UnitPrice NUMERIC,
    CustomerID INTEGER
);

-- Easy Queries
SELECT * FROM customers
SELECT * FROM invoices
SELECT * FROM products

SELECT DISTINCT InvoiceNo FROM invoices;

SELECT p.Description 
FROM Invoices i 
JOIN Products p ON i.StockCode = p.StockCode 
WHERE i.InvoiceNo = 536365;

SELECT p.Description, i.Quantity, i.UnitPrice 
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
WHERE i.InvoiceNo = 536367;

SELECT * FROM Products 
WHERE Description LIKE 'WHITE%';

SELECT DISTINCT Description FROM Products;

-- Intermediate Queries
SELECT p.Description, SUM(i.Quantity) AS TotalQuantity
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
GROUP BY p.Description
ORDER BY TotalQuantity DESC;

SELECT p.Description, SUM(i.Quantity * i.UnitPrice) AS Revenue
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
GROUP BY p.Description
ORDER BY Revenue DESC;

SELECT c.CustomerID, SUM(i.Quantity * i.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Invoices i ON c.CustomerID = i.CustomerID
GROUP BY c.CustomerID
ORDER BY TotalSpent DESC;

SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS InvoiceCount
FROM Invoices
GROUP BY CustomerID;

SELECT p.Description, COUNT(*) AS TimesPurchased
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
GROUP BY p.Description
ORDER BY TimesPurchased DESC
LIMIT 5;

-- Advanced Queries
SELECT CustomerID
FROM Invoices
GROUP BY CustomerID
HAVING COUNT(DISTINCT StockCode) = 1;

SELECT CustomerID, AVG(UnitPrice) AS AvgPrice
FROM Invoices
GROUP BY CustomerID
HAVING AVG(UnitPrice) > 3.00;

SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS InvoiceTotal
FROM Invoices
GROUP BY InvoiceNo
ORDER BY InvoiceTotal DESC
LIMIT 5;

SELECT p.Description, SUM(i.Quantity * i.UnitPrice) AS Revenue
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
GROUP BY p.Description
ORDER BY Revenue DESC
LIMIT 5;

SELECT i.CustomerID, p.Description, SUM(i.Quantity) AS TotalQuantity
FROM Invoices i
JOIN Products p ON i.StockCode = p.StockCode
GROUP BY i.CustomerID, p.Description
ORDER BY TotalQuantity DESC
LIMIT 10;

SELECT InvoiceNo, CustomerID, StockCode, UnitPrice, COUNT(*)
FROM Invoices
GROUP BY InvoiceNo, CustomerID, StockCode, UnitPrice
HAVING COUNT(*) > 1;

-- Window Function Queries
SELECT 
    CustomerID,
    StockCode,
    SUM(Quantity * UnitPrice) AS Revenue,
    RANK() OVER (PARTITION BY CustomerID ORDER BY SUM(Quantity * UnitPrice) DESC) AS ProductRank
FROM Invoices
GROUP BY CustomerID, StockCode;

SELECT 
    CustomerID,
    InvoiceNo,
    SUM(Quantity * UnitPrice) AS InvoiceTotal,
    SUM(SUM(Quantity * UnitPrice)) OVER (PARTITION BY CustomerID ORDER BY InvoiceNo ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Invoices
GROUP BY CustomerID, InvoiceNo;

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY InvoiceNo DESC) AS rn
    FROM Invoices
) t
WHERE rn = 1;

SELECT 
    CustomerID,
    StockCode,
    InvoiceNo,
    UnitPrice,
    LAG(UnitPrice, 1) OVER (PARTITION BY StockCode ORDER BY InvoiceNo) AS PrevPrice,
    UnitPrice - LAG(UnitPrice, 1) OVER (PARTITION BY StockCode ORDER BY InvoiceNo) AS PriceDiff
FROM Invoices;

SELECT 
    StockCode,
    InvoiceNo,
    Quantity,
    SUM(Quantity) OVER (PARTITION BY StockCode ORDER BY InvoiceNo) AS CumulativeQuantity
FROM Invoices;

-- CTE Queries
WITH InvoiceRevenue AS (
    SELECT InvoiceNo, SUM(Quantity * UnitPrice) AS TotalRevenue
    FROM Invoices
    GROUP BY InvoiceNo
)
SELECT * FROM InvoiceRevenue
ORDER BY TotalRevenue DESC;

WITH CustomerSpending AS (
    SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalSpent
    FROM Invoices
    GROUP BY CustomerID
)
SELECT * FROM CustomerSpending
WHERE TotalSpent > 50;

WITH ProductRank AS (
    SELECT 
        CustomerID,
        StockCode,
        SUM(Quantity * UnitPrice) AS Revenue,
        RANK() OVER (PARTITION BY CustomerID ORDER BY SUM(Quantity * UnitPrice) DESC) AS rk
    FROM Invoices
    GROUP BY CustomerID, StockCode
)
SELECT * FROM ProductRank
WHERE rk = 1;

WITH AvgPrice AS (
    SELECT 
        StockCode,
        AVG(UnitPrice) AS AvgUnitPrice
    FROM Invoices
    GROUP BY StockCode
)
SELECT p.Description, a.AvgUnitPrice
FROM AvgPrice a
JOIN Products p ON a.StockCode = p.StockCode
ORDER BY a.AvgUnitPrice DESC;

WITH InvoiceItems AS (
    SELECT InvoiceNo, COUNT(DISTINCT StockCode) AS ItemCount
    FROM Invoices
    GROUP BY InvoiceNo
)
SELECT * FROM InvoiceItems
WHERE ItemCount > 3;
