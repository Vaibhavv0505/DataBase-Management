/*
Write a trigger for the Product table to ensure the list price can never be raised more than 15 Percent in a single change. Modify the above trigger to execute its
check code only if the ListPrice column is updated (Use AdventureWorks Database). 
*/

CREATE TRIGGER aProductForUpdate
ON Production.Product
FOR UPDATE
AS
BEGIN
	Declare @ListPrice money , @OldListPrice money
	Select @ListPrice=ListPrice FROM INSERTED
	Select @OldListPrice=ListPrice FROM DELETED
	if(@ListPrice>(@OldListPrice *1.15))
	BEGIN
		RAISERROR('You cannot increase LitPrice more than 15%',16,1)
		rollback
		return
	END
END

ALTER TRIGGER Production.aProductForUpdate
ON Production.Product
FOR UPDATE 
AS
BEGIN
	Declare @ListPrice money , @OldListPrice money
	Select @ListPrice=ListPrice FROM INSERTED
	Select @OldListPrice=ListPrice FROM DELETED
	IF(UPDATE(ListPrice))
	begin
		if(@ListPrice>@OldListPrice*1.15)
		begin
			raiserror('you cannot increase ListPrice more than 15%',16,1)
			rollback
			return
		end
	end
end

