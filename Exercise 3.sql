/*
Show the most recent five orders that were purchased from account numbers that have spent more than $70,000 with AdventureWorks. 
*/

Select Top 5 SalesOrderID,AccountNumber,OrderDate 
from Sales.SalesOrderHeader
where AccountNumber IN
	(Select AccountNumber from Sales.SalesOrderHeader 
	group by AccountNumber Having SUM(SubTotal)>70000)-- Show Account No Which Has Subtotal is > 70000
	Order By OrderDate;