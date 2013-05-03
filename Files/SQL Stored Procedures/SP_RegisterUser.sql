CREATE PROCEDURE [dbo].[SP_Register]
	-- Add the parameters for the stored procedure here
	 @Firstname varchar (30),
	 @lastname	varchar(30),
	 @Email		varchar (50),
	 @password varchar (32),
	 @GCMid		varchar (100),
	 @UserName	varchar(30)
	 AS
BEGIN
	IF exists (SELECT id from tbluser where username=@username)
		select -1 as UserID
	else 
		IF exists (SELECT id from tbluser where @Email=email)
			select -2 as UserID
		else 
			begin
			insert INTO tbluser VALUES (@Firstname,@lastname,@Email,@password,@GCMid,@UserName,0)
			select @@identity as UserID
			end
	
END