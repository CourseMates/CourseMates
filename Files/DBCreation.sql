USE [master]
GO
/****** Object:  Database [CourseMates]    Script Date: 06/22/2013 23:14:43 ******/
CREATE DATABASE [CourseMates] ON  PRIMARY 
( NAME = N'CourseMates', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CourseMates.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CourseMates_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\CourseMates_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CourseMates] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CourseMates].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CourseMates] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [CourseMates] SET ANSI_NULLS OFF
GO
ALTER DATABASE [CourseMates] SET ANSI_PADDING OFF
GO
ALTER DATABASE [CourseMates] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [CourseMates] SET ARITHABORT OFF
GO
ALTER DATABASE [CourseMates] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [CourseMates] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [CourseMates] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [CourseMates] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [CourseMates] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [CourseMates] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [CourseMates] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [CourseMates] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [CourseMates] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [CourseMates] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [CourseMates] SET  DISABLE_BROKER
GO
ALTER DATABASE [CourseMates] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [CourseMates] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [CourseMates] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [CourseMates] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [CourseMates] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [CourseMates] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [CourseMates] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [CourseMates] SET  READ_WRITE
GO
ALTER DATABASE [CourseMates] SET RECOVERY SIMPLE
GO
ALTER DATABASE [CourseMates] SET  MULTI_USER
GO
ALTER DATABASE [CourseMates] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [CourseMates] SET DB_CHAINING OFF
GO
USE [CourseMates]
GO
/****** Object:  User [sys_cm1]    Script Date: 06/22/2013 23:14:43 ******/
CREATE USER [sys_cm1] FOR LOGIN [sys_cm1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [eliranye]    Script Date: 06/22/2013 23:14:43 ******/
CREATE USER [eliranye] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblCourse]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCourse](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](45) NULL,
	[IconClass] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblFileType]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFileType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Type] [varchar](30) NULL,
	[ImageUrl] [varchar](100) NULL,
	[Extension] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](45) NULL,
	[LastName] [varchar](45) NULL,
	[Email] [varchar](150) NULL,
	[Password] [varchar](150) NULL,
	[GCMId] [varchar](100) NULL,
	[UserName] [varchar](45) NULL,
	[IsVerify] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSessions]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblSessions](
	[UserID] [int] NULL,
	[SessionID] [varchar](100) NULL,
	[ExperationDate] [datetime] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblParticipants]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblParticipants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NULL,
	[UserId] [int] NULL,
	[IsAdmin] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_paCourse_idx] ON [dbo].[tblParticipants] 
(
	[CourseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_paUser_idx] ON [dbo].[tblParticipants] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblNotifications]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblNotifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[Subject] [varchar](50) NULL,
	[Content] [varchar](300) NULL,
	[Time] [datetime] NULL,
	[OwnerID] [int] NULL,
 CONSTRAINT [PK_tblNotifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblForum]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblForum](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CourseId] [int] NULL,
	[Title] [varchar](45) NULL,
	[Content] [varchar](500) NULL,
	[RootId] [int] NULL,
	[UserId] [int] NULL,
	[Rate] [int] NULL,
	[TimeAdded] [datetime] NULL,
	[RatingUsers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [fk_forumCourse_idx] ON [dbo].[tblForum] 
(
	[CourseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_forunUser_idx] ON [dbo].[tblForum] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_root_idx] ON [dbo].[tblForum] 
(
	[RootId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFile]    Script Date: 06/22/2013 23:14:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[CourseId] [int] NULL,
	[PhysicalPath] [varchar](1000) NULL,
	[FileName] [varchar](100) NULL,
	[FileTypeId] [int] NULL,
	[Rate] [int] NULL,
	[ParentFileID] [int] NULL,
	[LastModify] [datetime] NULL,
	[Size] [int] NULL,
	[IsFolder] [bit] NULL,
	[RatingUsers] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [fk_fileCourse_idx] ON [dbo].[tblFile] 
(
	[CourseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_fileType_idx] ON [dbo].[tblFile] 
(
	[FileTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [fk_user_idx] ON [dbo].[tblFile] 
(
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_Register]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Register]
      -- Add the parameters for the stored procedure here
      @Firstname varchar (30),
      @lastname  varchar(30),
      @Email           varchar (50),
      @password varchar (32),
      @GCMid           varchar (100),
      @UserName  varchar(30)
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
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserID]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  Table [dbo].[tblAction]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[Action] [int] NULL,
	[IsUsed] [bit] NULL,
 CONSTRAINT [PK_tblAction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[SP_VerifyEmail]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_VerifyEmail]
	@SessionID varchar(100),
	@UserID int
AS
BEGIN
	declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
		update tblUser SET IsVerify=1 where Id=@UserID
      end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_UpdateCourse]
@SessionID varchar(50),
@userID int,
@CourseID int,
@newCourseName varchar(45),
@NewIconClass varchar(50)
as
begin 
declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select top 1  ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID] order BY ExperationDate desc)
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            declare @AdminCheck int
            set @AdminCheck =NULL;
            set @AdminCheck = (select CourseID from tblParticipants where UserId=@userID and @CourseID=CourseID and IsAdmin =1)
            if (@admincheck is not null) 
            BEGIN
                  update tblCourse SET 
                  Name =@newCourseName,
                  IconClass=@newIconClass
                  where Id=@CourseID 
            END
      end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_SetUserAsAdmin]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure [dbo].[SP_SetUserAsAdmin]

@SessionID varchar(50),
@userID int,
@CourseID int,
@SetUserID int
as 
begin
      declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select top 1  ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID] order BY ExperationDate desc)
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            declare @AdminCheck int
            set @AdminCheck =NULL;
            set @AdminCheck = (select CourseID from tblParticipants where UserId=@userID and @CourseID=CourseID and IsAdmin =1)
            if (@admincheck is not null) 
            BEGIN
                  update tblParticipants SET IsAdmin =1
                  where CourseID=@CourseID and UserId= @SetUserID
                  select 1 as Result
            END
            else select -1 as Result
      end
      else select -1 as Result
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ReturnParticipantsByCourseID]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ReturnParticipantsByCourseID]

@SessionID varchar(50),
@userID int,
@CourseID int
as 
begin 
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select top 1  ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID] order BY ExperationDate desc)
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            Select u.Id, u.UserName,u.FirstName,u.LastName,u.Email,p.IsAdmin
            from tblUser u join tblParticipants p ON p.UserId = u.Id
            where p.CourseID =@CourseID
            
      end
else 
       select  -1 --Invalid session
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ReturnCouresebyUserID]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ReturnCouresebyUserID]
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
GO
/****** Object:  StoredProcedure [dbo].[SP_RestorePassword]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RestorePassword]
	@SessionID varchar(100),
	@UserID int,
	@NewPass varchar(100)
AS
begin
	declare @SessionCheckExpr datetime 
	set @SessionCheckExpr = NULL;
	set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
	if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
	begin
		update tblUser SET Password = @NewPass where Id=@UserID
	end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFilesByCourseID]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetFilesByCourseID]
@courseID int,
@SessionID varchar(50),
@UserID varchar(30)
as 
begin 
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            SELECT f.Id, f.UserId, u.UserName, f.FileName, f.Rate, f.Size,f.RatingUsers,
               f.ParentFileID, f.LastModify, f.IsFolder, t.Id as 'TypeID', 
               t.Type, t.ImageUrl, t.Extension 
                  FROM tblFile f 
                  LEFT JOIN tblUser u 
                              on f.UserId=u.Id 
                  LEFT JOIN tblFileType t 
                              on t.Id=f.FileTypeId 
            WHERE f.CourseId=@courseID
            ORDER BY f.IsFolder desc
      end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetFilePhysicalPath]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetFilePhysicalPath] 
	@SessionID varchar(50),
	@UserID int,
	@FileID int
AS
begin
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
begin
      SELECT PhysicalPath, FileName FROM tblFile
      WHERE Id=@FileID
end
else
      select null as PhysicalPath, null as FileName
      
end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCourseForum]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetCourseForum]
	@SessionID varchar(100),
	@UserID int,
	@CourseID int
AS
BEGIN
	declare @SessionCheckExpr datetime 
	set @SessionCheckExpr = NULL;
	set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
	if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
	begin
		Select F.Id, F.Title, F.Content, F.RootId, F.Rate, U.UserName, F.TimeAdded, F.RatingUsers
		from tblForum F
		left JOIN tblUser U on F.UserId=U.Id
		where CourseId = @CourseID
		order by F.TimeAdded
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteUserFromCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_DeleteUserFromCourse]
@SessionID varchar(50),
@userID int,
@CourseID int,
@DelUserID int
as 
begin
declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select top 1  ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID] order BY ExperationDate desc)
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            declare @AdminCheck int
            set @AdminCheck =NULL;
            set @AdminCheck = (select CourseID from tblParticipants where UserId=@userID and @CourseID=CourseID and IsAdmin =1)
            if (@admincheck is not null) 
            begin
                  delete FROM tblParticipants where @DelUserID = UserId and CourseID= @CourseID
                  select 1 as Result
            end
            else select -1 as Result
      end
      else select -1 as Result
ENd
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteForumItem]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteForumItem]
	@SessionID varchar(100),
	@UserID int,
	@CourseID int,
	@ItemID int
AS
BEGIN
	declare @SessionCheckExpr datetime 
	set @SessionCheckExpr = NULL;
	set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
	if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
	begin
		declare @isAdmin bit
		set @isAdmin = (SELECT IsAdmin from tblParticipants WHERE CourseID=@CourseID AND UserId=@UserID)
		IF (@isAdmin=1)
		begin
			WITH SubItemsCTE (Id)
			as
			(
			 select Id FROM tblForum WHERE Id=@ItemID
			 UNION all
				SELECT f.Id FROM tblForum f
				inner join SubItemsCTE s on s.Id=f.RootId
			)
			DELETE FROM tblForum where Id in (SELECT Id from SubItemsCTE)
		end
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteFile]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DeleteFile] 
	@SessionID varchar(50),
	@UserID int,
	@FileID int
AS
begin
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
begin
	declare @fId int
    set @fId = (SELECT DISTINCT f.Id from tblFile f
				left JOIN tblParticipants p on p.CourseID=f.CourseId
				where f.Id = @FileID AND (f.UserId=@UserID OR (p.UserId=@UserID AND p.IsAdmin=1)))
    IF (@fId is not null)
    begin
		IF ((select count(*) from tblFile Where ParentFileID=@fId) = 0)
		BEGIN
			DECLARE @PhysicalPath varchar(100)
			SET @PhysicalPath = (SELECT PhysicalPath FROM tblFile WHERE Id=@fId)
			DELETE from tblFile where Id=@fId
			select 1 as Result, @PhysicalPath as PhysicalPath
		end
		else
		begin
			select 4 as Result, NULL as PhysicalPath
		end		
    end
    else
    begin
		select 3 as Result, NULL as PhysicalPath
    end
end
else
      select 2 as Result, NULL as PhysicalPath
end
GO
/****** Object:  StoredProcedure [dbo].[SP_DeleteCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_DeleteCourse]
@CourseID int,
@UserID int,
@SessionID varchar(100)
as
begin
      declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
                  --get the courseid from courses.
                  declare @courseIDCheck int =-1
                  set @courseIDCheck =(SELECT [courseId] from CourseMates.dbo.tblParticipants where @UserID=[UserId] AND @CourseID=[CourseID] AND IsAdmin=1)
                  if (@CourseIDCheck!=-1)
                  begin
                        delete FROM CourseMates.dbo.tblForum where CourseId =@CourseID
                        delete from CourseMates.dbo.tblFile where CourseId = @CourseId
                        delete from coursemates.dbo.tblParticipants where @CourseID=CourseID
                        delete from CourseMates.dbo.tblForum where CourseId =@CourseID
                        delete from CourseMates.dbo.tblCourse where @CourseID=tblCourse.Id
                        select 1 as result
                  end
                  else select 0 as Result
      end
      else select 0 as result
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CreateNewCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_CreateNewCourse]
@SessionID varchar(50),
@userID int,
@CourseName varchar(45),
@IconClass varchar(50)

--Phase 1 : Checking the session valilidity( if exists, Check the 3 hours difference)
as 
begin
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
begin
      --Phase 2 :
      declare @resultCourseID int 
      insert INTO CourseMates.dbo.tblCourse VALUES (@CourseName,@IconClass)
      set @resultCourseID = @@identity
      --phase 3:
      insert INTO CourseMates.dbo.tblparticipants VALUES (@resultCourseID,@UserID,1)
      insert INTO tblFile VALUES (@UserID,@resultCourseID,null,'Root',1,0,NULL,getdate(),0,1,0)
      select @resultCourseID as Result
end
else
      select NULL as Result;
      
end
GO
/****** Object:  StoredProcedure [dbo].[SP_ClearSessions]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ClearSessions]
AS
BEGIN
	delete FROM tblSessions
	where DATEDIFF(hh, ExperationDate ,GETDATE()) > 0	
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ChangePassword]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChangePassword]
	@SessionID varchar(100),
	@UserID int,
	@OldPassword varchar(150),
	@NewPassword varchar(150)
AS
BEGIN
	declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
		declare @ID int
		set @ID = (select Id from tblUser where Id=@UserID and Password=@OldPassword)
		if (@ID is not null)
			update tblUser SET Password=@NewPassword where Id=@UserID
      end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_ChangeEmail]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ChangeEmail]
	@SessionID varchar(100),
	@UserID int,
	@OldEmail varchar(150),
	@NewEmail varchar(150)
AS
BEGIN
	declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
		declare @ID int
		declare @EmailExist int
		set @ID = (select Id from tblUser where Id=@UserID and Email=@OldEmail)
		set @EmailExist = (select Id from tblUser where Email=@NewEmail)
		if (@ID is not null and @EmailExist is null)
			update tblUser SET Email=@NewEmail where Id=@UserID
      end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddSession]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddSession]
      -- Add the parameters for the stored procedure here
      @UserID int ,
      @SessionID varchar (100)
AS

      begin 
      insert INTO CourseMates.dbo.tblsessions VALUES (@UserID,@SessionID,dateadd(hh,3,getdate()))
      end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewUserToCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewUserToCourse]
@SessionID varchar(100),
@UserID int,
@CourseID int,
@UserNameToAdd varchar(45)
as
Begin
      declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
		declare @IsAdmin bit
		set @IsAdmin = (select IsAdmin from tblParticipants where CourseID=@CourseID and UserId=@UserID)
		IF (@IsAdmin = 1)
		begin
			declare @AddUserID int
			declare @Part int
			set @AddUserID = (SELECT Id FROM tblUser WHERE UserName=@UserNameToAdd)
			set @Part = (SELECT Id FROM tblParticipants WHERE CourseID=@CourseID AND UserId=@AddUserID)
			IF(@Part is null)
			begin
				insert INTO tblParticipants VALUES (@CourseID, @AddUserID, 0)           
				select 1 as 'Result'
			end
			else
				select 0 as 'Result'
        end
		else
            select -1 as 'Result'		
      end
      else
            select -1 as 'Result'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewNotifications]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewNotifications]
@SessionID varchar(100),
@UserID int,
@CourseID int,
@Subject varchar(300),
@Content varchar(300)

AS
BEGIN

declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))

begin
	insert INTO tblNotifications VALUES (@CourseID, @Subject, @Content, GETDATE(), @UserID)
end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewNotification]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewNotification]
	@SessionID varchar(100),
	@UserID int,
	@CourseID int,
	@Subject varchar(50),
	@Content varchar(300)
as
begin
      declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
		insert into tblNotifications VALUES (@CourseID, @Subject, @Content, GETDATE(), @UserID)
      end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_AddNewForumItem]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddNewForumItem]
	@SessionID varchar(100),
	@UserID int,
	@CourseID int,
	@Title varchar(45),
	@Content varchar(500),
	@ParentID int
AS
BEGIN
	declare @SessionCheckExpr datetime 
	set @SessionCheckExpr = NULL;
	set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
	if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
	begin
		insert INTO tblForum VALUES (@CourseID, @Title, @Content, @ParentID, @UserID,0, getdate(),0)
	end
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertNewFileToCourse]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_InsertNewFileToCourse]
@UserID int,
@SessionID varchar(50),
@CourseID int,
@PhysicalPath varchar(1000),
@FileName varchar(100),
@FileTypeID int,
@parentFileID int,
@Size int,
@IsFolder bit
as
Begin
      declare @SessionCheckExpr datetime 
      set @SessionCheckExpr = NULL;
      set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
      if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
      begin
            Insert INTO tblFile VALUES (@UserID,@CourseID,@PhysicalPath,@FileName,@FileTypeID,0,@parentFileID,getdate(),@Size,@IsFolder,0)
            
            select 1 as 'Result'
      end
      else
            select 0 as 'Result'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertAction]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_InsertAction]
      -- Add the parameters for the stored procedure here
      @UserID int  = null,
      @Action int = null
      as 
begin
          insert INTO CourseMates.dbo.tblAction VALUES (@UserID,@Action,0)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserNotifications]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserNotifications]
@SessionID varchar(100),
@UserID int,
@LastNTime datetime

AS
BEGIN

declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @userID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))

begin
		declare @pTime datetime
		IF(@LastNTime is null)
			set @pTime = GETDATE()-7
		else
			set @pTime = @LastNTime
			
		SELECT		n.Subject, n.[Content], n.[Time], u1.UserName as Owner, c.Name as CourseName
		FROM		tblNotifications as n LEFT JOIN 
					tblParticipants as p ON p.CourseID = n.CourseID LEFT JOIN
					tblCourse as c on c.id = p.CourseID LEFT JOIN 
					tblUser as u on u.id = p.UserId LEFT JOIN 
					tblUser as u1 on u1.id = n.OwnerID
					
		WHERE		((p.UserId = @UserID) AND 
						((n.[Time] > @pTime) and (n.[Time] < GETDATE())))
					
		ORDER BY	n.[Time] desc
		
end
else
	select 0 as 'Result'
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RateForumItem]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_RateForumItem]
@SessionID varchar(50),
@UserID int,
@ItemID int,
@Rating int

as 
begin
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @UserID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
begin
	update tblForum SET Rate=Rate+@Rating, RatingUsers=RatingUsers+1
	where Id=@ItemID
end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_RateFile]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_RateFile]
@SessionID varchar(50),
@UserID int,
@FileID int,
@Rating int

as 
begin
declare @SessionCheckExpr datetime 
set @SessionCheckExpr = NULL;
set @SessionCheckExpr = (select ExperationDate from CourseMates.dbo.tblSessions where @SessionID =[SessionID] and @UserID =[userID])
if ((@SessionCheckExpr is not null) and ((datediff(mi,@SessionCheckExpr,getdate())<180)))
begin
	update tblFile SET Rate=Rate+@Rating, RatingUsers=RatingUsers+1
	where Id=@FileID
end
end
GO
/****** Object:  StoredProcedure [dbo].[SP_IsValidAction]    Script Date: 06/22/2013 23:14:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_IsValidAction]
	@UserID int,
	@UniqID varchar(32),
	@Action int
AS
BEGIN
	declare @act int
	set @act = (select Id from tblAction where UserId = @UserID and IsUsed=0 and Action=@Action)
	IF @act is not null	
	begin
		declare @hashMail varchar(32)
		set @hashMail = SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('MD5', (select Email from tblUser where Id=@UserID))), 3, 32)

		if @hashMail=@UniqID
		BEGIN
			declare @guid varchar(100)
			set @guid = CONVERT(varchar(255), NEWID())
			exec SP_AddSession @UserID, @guid
			update tblAction SET IsUsed=1 where Id=@act
			select @guid as SessionID
		end
	end		
END
GO
/****** Object:  Default [DF__tblPartic__IsAdm__173876EA]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblParticipants] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
/****** Object:  Default [DF__tblForum__RootId__1920BF5C]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblForum] ADD  DEFAULT ((-1)) FOR [RootId]
GO
/****** Object:  ForeignKey [FK_tblSessions_tblUser]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblSessions]  WITH CHECK ADD  CONSTRAINT [FK_tblSessions_tblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblSessions] CHECK CONSTRAINT [FK_tblSessions_tblUser]
GO
/****** Object:  ForeignKey [fk_paCourse]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblParticipants]  WITH CHECK ADD  CONSTRAINT [fk_paCourse] FOREIGN KEY([CourseID])
REFERENCES [dbo].[tblCourse] ([Id])
GO
ALTER TABLE [dbo].[tblParticipants] CHECK CONSTRAINT [fk_paCourse]
GO
/****** Object:  ForeignKey [fk_paUser]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblParticipants]  WITH CHECK ADD  CONSTRAINT [fk_paUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblParticipants] CHECK CONSTRAINT [fk_paUser]
GO
/****** Object:  ForeignKey [FK_tblNotifications_tblCourse]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblNotifications]  WITH CHECK ADD  CONSTRAINT [FK_tblNotifications_tblCourse] FOREIGN KEY([CourseID])
REFERENCES [dbo].[tblCourse] ([Id])
GO
ALTER TABLE [dbo].[tblNotifications] CHECK CONSTRAINT [FK_tblNotifications_tblCourse]
GO
/****** Object:  ForeignKey [fk_forumCourse]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblForum]  WITH CHECK ADD  CONSTRAINT [fk_forumCourse] FOREIGN KEY([CourseId])
REFERENCES [dbo].[tblCourse] ([Id])
GO
ALTER TABLE [dbo].[tblForum] CHECK CONSTRAINT [fk_forumCourse]
GO
/****** Object:  ForeignKey [fk_forunUser]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblForum]  WITH CHECK ADD  CONSTRAINT [fk_forunUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblForum] CHECK CONSTRAINT [fk_forunUser]
GO
/****** Object:  ForeignKey [fk_fileCourse]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileCourse] FOREIGN KEY([CourseId])
REFERENCES [dbo].[tblCourse] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileCourse]
GO
/****** Object:  ForeignKey [fk_fileType]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileType] FOREIGN KEY([FileTypeId])
REFERENCES [dbo].[tblFileType] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileType]
GO
/****** Object:  ForeignKey [fk_fileUser]    Script Date: 06/22/2013 23:14:44 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileUser]
GO
/****** Object:  ForeignKey [FK_tblAction_tblUser]    Script Date: 06/22/2013 23:14:46 ******/
ALTER TABLE [dbo].[tblAction]  WITH CHECK ADD  CONSTRAINT [FK_tblAction_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblAction] CHECK CONSTRAINT [FK_tblAction_tblUser]
GO
