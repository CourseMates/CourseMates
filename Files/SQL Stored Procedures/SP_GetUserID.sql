CREATE PROCEDURE [dbo].[SP_GetUserID]
	-- Add the parameters for the stored procedure here
	@UserName varchar(20)  = null,
	@Password varchar(32) = null
AS
begin
	    
	declare @result int =null
	set @result = (SELECT ID from tbluser where @UserName=Username and @Password=password)
	select CASE WHEN (@result is null) THEN -1 ELSE @result  end as 'UserID'
END