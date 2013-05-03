create PROCEDURE [dbo].[SP_AddSession]
	-- Add the parameters for the stored procedure here
	@UserID int ,
	@SessionID varchar (100)
AS

	begin	
	insert INTO CourseMates.dbo.tblsessions VALUES (@UserID,@SessionID,dateadd(hh,3,getdate()))
	end
