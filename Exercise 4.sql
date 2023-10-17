/*
Create a function that takes as inputs a SalesOrderID, a Currency Code, and a date, and returns a table of all the SalesOrderDetail rows for that Sales Order including
Quantity, ProductID, UnitPrice, and the unit price converted to the target currency based on the end of day rate for the date provided. Exchange rates can be found in the Sales.
CurrencyRate table. (Use AdventureWorks) 
*/


CREATE FUNCTION Sales.ccgetProducts(@SalesOrderID int, @CurrencyCode nchar(3) ,@CurrencyRateDate datetime)
	RETURNS TABLE 
AS
	RETURN
	WITH Products
	AS (
		SELECT *
		FROM Sales.SalesOrderDetail AS sod 
		WHERE sod.SalesOrderID = @SalesOrderID
	)
	SELECT p.ProductID, p.OrderQty, p.UnitPrice, p.UnitPrice*scr.EndOfDayRate AS 'Converted Price'
	FROM Products AS p, Sales.CurrencyRate AS scr
	WHERE scr.ToCurrencyCode = @CurrencyCode
		AND scr.CurrencyRateDate = @CurrencyRateDate
GO

SELECT * FROM Sales.ccgetProducts(43890, 'MXN', '2005-09-05 00:00:00.000');
