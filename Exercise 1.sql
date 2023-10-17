--1.1  Display the number of rerecords in the[SalesPerson] table.
select Count(*) as 'Total Records' from Sales.SalesPerson;



--1.2  Select both the FirstName and LastName of records from the Person table where the FirstName begins with the letter ‘B’. 
(Schema(s) involved: Person) 
Select FirstName+' '+LastName as 'Full Name' from Person.Person where FirstName Like 'B%';


--1.3  Select a list of FirstName and LastName for employees where Title is one of Design Engineer, Tool Designer or Marketing Assistant. (Schema(s) involved: HumanResources, Person) 
Select FirstName,LastName,JobTitle
From Person.Person 
INNER JOIN HumanResources.Employee
ON Person.Person.BusinessEntityID=HumanResources.Employee.BusinessEntityID
AND  JobTitle LIKE '%Design Engineer%' OR JobTitle LIKE '%Tool Designer %' OR JobTitle LIKE'%Marketing Assistant%';


--1.4  Display the Name and Color of the Product with the maximum weight. (Schema(s) involved: Production) 
Select Name,Color,Weight From Production.Product 
where Weight=(Select MAX(Weight) from Production.Product);


--1.5  Display Description and MaxQty fields from the SpecialOffer table. Some of the MaxQty values are NULL, in this case display the value 0.00 instead. (Schema(s) involved: Sales) 
Select SpecialOffer.Description,ISNULL(SpecialOffer.MaxQty,0.00) From Sales.SpecialOffer;


--1.6  Display the overall Average of the [CurrencyRate].[AverageRate] values for the exchange rate ‘USD’ to ‘GBP’ for the year 2005 i.e. FromCurrencyCode = ‘USD’ and ToCurrencyCode = ‘GBP’.
Select CurrencyRateDate,FromCurrencyCode,ToCurrencyCode,AverageRate
From Sales.CurrencyRate
Where datepart(year,CurrencyRateDate)=2007 and ToCurrencyCode='GBP'; 


--1.7  Display the FirstName and LastName of records from the Person table where FirstName contains the letters ‘ss’. Display an additional column with sequential numbers for each row returned beginning at integer 1. (Schema(s) involved: Person) 
SELECT ROW_NUMBER() over (order by FirstName asc) As RowNumber,FirstName,LastName
FROM Person.Person
where FirstName like '%ss%';


--1.8  Sales people receive various commission rates that belong to 1 of 4 bands.
SELECT BusinessEntityID,CommissionPct ,'Commission Band'=
CASE
	WHEN CommissionPct = 0 then 'Band 0'
    WHEN CommissionPct > 0 and CommissionPct <= 0.01 THEN 'Band 1'  
    WHEN CommissionPct > 0.01 and CommissionPct <= 0.015 then 'Band 2'
	WHEN CommissionPct > 0.015 then 'Band 3'
     
END FROM Sales.SalesPerson
Order by CommissionPct;


--1.9  Display the managerial hierarchy from Ruth Ellerbrock (person type – EM) up to CEO Ken Sanchez.  
Declare @id int;
Select @id = BusinessEntityID
From Person.Person
where FirstName='Ruth' and LastName ='Ellerbrock' and PersonType='EM'
Exec dbo.uspGetEmployeeManagers @BusinessEntityID=@ID;


--1.10  Display the ProductId of the product with the largest stock level.
Select Max(dbo.ufnGetStock(ProductID)) from Production.Product;
