USE [CourseMates]
GO
/****** Object:  StoredProcedure [dbo].[ReturnCouresebyUserID]    Script Date: 05/13/2013 16:26:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[ReturnCouresebyUserID]
@UserID int,
@SessionID varchar(100)
as --CourseID,Coursename,iconClass,IsAdmin
begin
	declare @SessionCheckExpr datetime 
	set @SessionCheckExpr = NULL;
	set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
	if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
	begin
			select c.Id,c.Name,c.iconClass,p.IsAdmin
			from tblCourse c join tblParticipants p
			on c.Id=p.CourseID
			where p.UserId=@UserID 
	end
	else select NULL
end