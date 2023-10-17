/*Write a Procedure supplying name information from the Person.Person table and accepting a filter for the first name. Alter the above Store Procedure to supply Default Values
if user does not enter any value.
*/


GO
Create Proc Person.getNameByType @type nchar(5)='IN'
AS
Select FirstName From Person.Person Where PersonType=@type;
GO
 
Execute Person.getNameByType;