USE `Project#1`;

#1. How has profit changed over time?

SELECT Year(`Order Date`) AS OrderYear, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfits 
FROM Orders
GROUP BY OrderYear
ORDER BY OrderYear;

#2. Which product categories, sub-categories, and products generate the highest profits?

#Categories, Total Sales, and Total Profits
SELECT Category, SUM(Sales) As TotalSales, SUM(Profit) AS TotalProfits 
FROM Orders
GROUP BY Category
ORDER BY TotalProfits DESC, TotalSales DESC;

#Sub-Categories, Total Sales, and Total Profits
SELECT `Sub-Category` AS SubCategory, SUM(Sales) As TotalSales, SUM(Profit) AS TotalProfits 
FROM Orders
GROUP BY SubCategory
ORDER BY TotalProfits DESC, TotalSales DESC;

#Products, Total Sales, and Total Profits
SELECT `Product Name` AS ProductName, SUM(Sales) As TotalSales, SUM(Profit) AS TotalProfits 
FROM Orders
GROUP BY ProductName
ORDER BY TotalProfits DESC, TotalSales DESC;

#3. Which regions generate the highest profits, and which regions underperform?
SELECT Region, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfits
FROM Orders
GROUP BY Region
ORDER BY TotalProfits DESC;

#4. Which customer segments and individual customers generate the highest profits?

#Segment, Total Sales, and Total Profits
SELECT Segment, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfits
FROM Orders
GROUP BY Segment
ORDER BY TotalProfits DESC, TotalSales DESC;

#CustomerName, Total Sales, and Total Profits
SELECT `Customer Name` AS CustomerName, SUM(Sales) AS TotalSales, SUM(Profit) AS TotalProfits
FROM Orders
GROUP BY CustomerName
ORDER BY TotalProfits DESC, TotalSales DESC;

#5. Which regional manager oversees the highest-profit region?

SELECT p.`Regional Manager` AS RegionalManager, p.Region, SUM(o.Sales) AS TotalSales, SUM(o.Profit) AS TotalProfits
FROM Orders o
JOIN people p
ON o.Region = p.Region
GROUP BY RegionalManager, p.Region
ORDER BY TOtalProfits DESC, TotalSales DESC;

#6. Which regions have the highest return rates, and how do returns affect profitability across regional managers?

#DISTINT is used on Order ID as multiple products can link to the same Order ID
SELECT
    p.`Regional Manager` AS RegionalManager,
    p.Region,
    COUNT(DISTINCT o.`Order ID`) AS TotalOrders,
    COUNT(DISTINCT CASE WHEN r.Returned = 'Yes' THEN o.`Order ID` END) AS TotalReturned,
    ROUND(COUNT(DISTINCT CASE WHEN r.Returned = 'Yes' THEN o.`Order ID` END) * 100.0 / COUNT(DISTINCT o.`Order ID`), 2) AS ReturnRate,
    SUM(o.Sales) AS TotalSales,
    SUM(o.Profit) AS TotalProfits
FROM Orders o
LEFT JOIN People p ON o.Region = p.Region
LEFT JOIN Returns r ON o.`Order ID` = r.`Order ID`
GROUP BY p.`Regional Manager`, p.Region
ORDER BY ReturnRate DESC;



