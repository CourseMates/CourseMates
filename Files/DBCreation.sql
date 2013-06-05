USE [master]
GO
/****** Object:  Database [CourseMates]    Script Date: 06/05/2013 12:14:30 ******/
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
/****** Object:  User [sys_cm1]    Script Date: 06/05/2013 12:14:30 ******/
CREATE USER [sys_cm1] FOR LOGIN [sys_cm1] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [eliranye]    Script Date: 06/05/2013 12:14:30 ******/
CREATE USER [eliranye] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblFileType]    Script Date: 06/05/2013 12:14:31 ******/
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
SET IDENTITY_INSERT [dbo].[tblFileType] ON
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (1, N'Folder', N'Images\FileType\folder.png', NULL)
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (2, N'Word 2003', N'Images\FileType\doc.png', N'doc')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (3, N'Word 2007', N'Images\FileType\docx.png', N'docx')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (4, N'Excel 2003', N'Images\FileType\xls.png', N'xls')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (5, N'Excel 2007', N'Images\FileType\xlsx.png', N'xlsx')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (6, N'Power Point 2003', N'Images\FileType\ppt.png', N'ppt')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (7, N'Power Point 2007', N'Images\FileType\pptx.png', N'pptx')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (8, N'Acrobat Reader', N'Images\FileType\pdf.png', N'pdf')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (9, N'JPG Image', N'Images\FileType\jpg.png', N'jpg')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (10, N'PNG Image', N'Images\FileType\png.png', N'png')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (11, N'GIF Image', N'Images\FileType\gif.png', N'gif')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (12, N'BMP Image', N'Images\FileType\bmp.png', N'bmp')
INSERT [dbo].[tblFileType] ([Id], [Type], [ImageUrl], [Extension]) VALUES (13, N'Text File', N'Images\FileType\txt.png', N'txt')
SET IDENTITY_INSERT [dbo].[tblFileType] OFF
/****** Object:  Table [dbo].[tblCourse]    Script Date: 06/05/2013 12:14:31 ******/
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
SET IDENTITY_INSERT [dbo].[tblCourse] ON
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (15, N'New Course', N'x-black-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (16, N'New Course 2', N'x-beige-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (17, N'SE-10078', N'x-lila-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (18, N'Blablabla', N'x-green-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (19, N'sadsdf', N'x-lila-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (20, N'New Course', N'x-black-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (22, N'Stam', N'x-orange-folder')
INSERT [dbo].[tblCourse] ([Id], [Name], [IconClass]) VALUES (23, N'Test', N'x-blue-folder')
SET IDENTITY_INSERT [dbo].[tblCourse] OFF
/****** Object:  Table [dbo].[tblUser]    Script Date: 06/05/2013 12:14:31 ******/
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
SET IDENTITY_INSERT [dbo].[tblUser] ON
INSERT [dbo].[tblUser] ([Id], [FirstName], [LastName], [Email], [Password], [GCMId], [UserName], [IsVerify]) VALUES (1, N'Ben', N'Ohana', N'ben.ohana1@gmail.com', N'0263bcf70efc6b086280efe4c8d5bf2e', N'', N'benoh', 0)
INSERT [dbo].[tblUser] ([Id], [FirstName], [LastName], [Email], [Password], [GCMId], [UserName], [IsVerify]) VALUES (5, N'Ben', N'Ohana', N'boby17@walla.com', N'25d55ad283aa400af464c76d713c07ad', N'', N'boby', 0)
INSERT [dbo].[tblUser] ([Id], [FirstName], [LastName], [Email], [Password], [GCMId], [UserName], [IsVerify]) VALUES (8, N'Eliran', N'Yehezkel', N'eliranyehezkel@gmail.com', N'25d55ad283aa400af464c76d713c07ad', NULL, N'eliranye', 0)
INSERT [dbo].[tblUser] ([Id], [FirstName], [LastName], [Email], [Password], [GCMId], [UserName], [IsVerify]) VALUES (9, N'Mor', N'Pilas', N'morpila@gmail.com', N'0263bcf70efc6b086280efe4c8d5bf2e', NULL, N'mpilas', 0)
SET IDENTITY_INSERT [dbo].[tblUser] OFF
/****** Object:  Table [dbo].[tblSessions]    Script Date: 06/05/2013 12:14:31 ******/
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
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'2ecefd2c-f865-4e60-a54a-3f8283a5c9e9', CAST(0x0000A1D100C891D5 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'6fafd35c-93a5-4f1e-a970-f0f14f85e92a', CAST(0x0000A1D100CF099F AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'58be32ae-81d6-4f1f-8345-3b42a9e8d55e', CAST(0x0000A1D100DB0D79 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'ba19e94f-ec83-48f3-87d8-d3b4a0bdcd16', CAST(0x0000A1D100DF2839 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'508458c7-fb9f-494a-b433-384d45054323', CAST(0x0000A1D100E577DD AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'f199b28b-aeeb-4011-80a4-28af9ebc3b80', CAST(0x0000A1D100E91FDF AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'5d554f8d-f058-49e3-a863-8c896fd8efab', CAST(0x0000A1D100EE6CF6 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'9e0caa7b-6a20-4690-affc-bf67635366d4', CAST(0x0000A1D100F72836 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'1f574fbf-2876-4775-baa0-898d1636c8ff', CAST(0x0000A1D10105B6E5 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'2d6dcc29-5274-4023-8020-854f905c6fae', CAST(0x0000A1D1011BAED1 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'f25b1d08-14a6-4e0f-8ab7-8259af294e82', CAST(0x0000A1D1011D6BEF AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'734843ed-286c-4dd4-a658-d21bcbe8295e', CAST(0x0000A1D1011DA822 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'1ccd416d-24f3-40ca-ad6d-64d8878d4c20', CAST(0x0000A1D1011EE8B2 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'd1b8b2df-cccd-4dc7-b954-ed8f28ad7484', CAST(0x0000A1D1011F12DD AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'29521cfc-4408-406e-a751-a2a86ee0da1c', CAST(0x0000A1D1011FB789 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'229acf7e-cd0b-465f-a866-e94959f1fe28', CAST(0x0000A1D30018174F AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'9b2674ec-1e93-4b10-8ec8-032886934e8d', CAST(0x0000A1D3001A8274 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'1a4d1670-0966-4c9c-bebc-1653602bf2b3', CAST(0x0000A1D300C7D013 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'504ce3f2-3cad-4185-98b7-98bfe3dddf9f', CAST(0x0000A1D3013544CE AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'e2a4222d-02ad-46b0-ab7d-a1f4e2825cd2', CAST(0x0000A1D301408CFC AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'd434b9c4-7545-4390-b30b-d5f107edf620', CAST(0x0000A1D301434C5F AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'bd24a1c1-ea47-4cc8-9819-a3e6c4cf7b33', CAST(0x0000A1D301456EBD AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'928b78b7-f9a4-49ef-b152-108122ab6ad6', CAST(0x0000A1D301499439 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'889cbbc1-6800-48b2-8049-dc517821f8e1', CAST(0x0000A1D400E12BDD AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (8, N'2e5b7903-a572-4e79-8ee3-513bc115b8ff', CAST(0x0000A1D400E2CDB8 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'87317cfc-3e99-4719-8ecd-786621bd5f47', CAST(0x0000A1D400E39F55 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'a3e336e0-2fd7-45a4-acd7-f84021213038', CAST(0x0000A1D400EA53A0 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'c14775a0-aaee-45fd-915b-fb696fa14631', CAST(0x0000A1D400EB215C AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'e08c9cc4-e42b-4a8a-bc71-b5dbb5f190b9', CAST(0x0000A1D400ED17B8 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'1ba30e3c-25a5-4908-8f1d-434d22c7d2c5', CAST(0x0000A1D400EF31C8 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'b5f2201d-6b07-4a07-9266-d4ec360a89da', CAST(0x0000A1D101167386 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'3e0c30e2-487e-48df-bb4e-abccb776fee9', CAST(0x0000A1D3001D4128 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'3a3beea0-5430-4d77-b20f-7c18d04ba31a', CAST(0x0000A1D3001E0B9B AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'a423ea34-1a18-40ba-9e0c-0b084e41bb3b', CAST(0x0000A1D3001F10CA AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'6e152e32-81b7-42c0-9e17-8a5ed55e09f2', CAST(0x0000A1D300220A72 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'19c77823-bb89-43ea-ac5e-369ecc008226', CAST(0x0000A1D3002527D8 AS DateTime))
INSERT [dbo].[tblSessions] ([UserID], [SessionID], [ExperationDate]) VALUES (5, N'2829537f-2125-4900-9b34-ef5550c4a921', CAST(0x0000A1D30026A9B7 AS DateTime))
/****** Object:  Table [dbo].[tblParticipants]    Script Date: 06/05/2013 12:14:31 ******/
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
SET IDENTITY_INSERT [dbo].[tblParticipants] ON
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (15, 15, 1, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (16, 16, 1, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (17, 17, 1, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (18, 18, 1, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (19, 19, 1, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (20, 20, 5, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (22, 22, 5, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (23, 23, 5, 1)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (24, 23, 1, 0)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (25, 22, 1, 0)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (27, 20, 8, 0)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (29, 23, 8, 0)
INSERT [dbo].[tblParticipants] ([Id], [CourseID], [UserId], [IsAdmin]) VALUES (32, 22, 8, 0)
SET IDENTITY_INSERT [dbo].[tblParticipants] OFF
/****** Object:  Table [dbo].[tblForum]    Script Date: 06/05/2013 12:14:31 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetUserID]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  Table [dbo].[tblAction]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  Table [dbo].[tblFile]    Script Date: 06/05/2013 12:14:32 ******/
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
SET IDENTITY_INSERT [dbo].[tblFile] ON
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (1, 1, 15, NULL, N'Root', 1, 0, NULL, CAST(0x0000A1CC00E0F266 AS DateTime), 3, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (2, 5, 20, NULL, N'Root', 1, 0, NULL, CAST(0x0000A1CC0109B775 AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (3, 5, 20, N'', N'folde1', 1, 0, 2, CAST(0x0000A1CC011602F2 AS DateTime), 1, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (5, 5, 20, N'', N'File2.pdf', 8, 0, 3, CAST(0x0000A1CC011ED3A6 AS DateTime), 4, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (17, 5, 20, N'', N'folder2', 1, 0, 2, CAST(0x0000A1CD010F8AA4 AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (18, 1, 20, N'3bd0a0d2-746a-4200-a40f-65097a2577ad', N'txt.png', 10, 0, 17, CAST(0x0000A1CD010FC58A AS DateTime), 23800, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (21, 5, 22, NULL, N'Root', 1, 0, NULL, CAST(0x0000A1CD011E1C81 AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (22, 5, 23, NULL, N'Root', 1, 0, NULL, CAST(0x0000A1CD01205E8C AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (23, 5, 23, N'', N'test', 1, 0, 22, CAST(0x0000A1CD0120708B AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (24, 5, 23, N'509fb116-3e31-4dff-8422-9c9c2bbafe18', N'Ex1-benoh-300373560.docx', 3, 0, 23, CAST(0x0000A1CD012089D9 AS DateTime), 115325, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (25, 5, 22, N'', N'test1', 1, 0, 21, CAST(0x0000A1CD01286517 AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (28, 5, 23, N'02422ffd-e6b6-49d0-831b-ffc3f5666aa6', N'Ex4_Ben_Ohana_300373560.docx', 3, 0, 22, CAST(0x0000A1CD012D59D0 AS DateTime), 15569, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (31, 5, 22, N'89e4c201-250b-408c-b6a3-420ba38db0c0', N'web_for_pentester.pdf', 8, 0, 21, CAST(0x0000A1CF00CBB386 AS DateTime), 2506610, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (32, 5, 20, N'0e2b6b12-62e6-4651-92cf-76298a03302f', N'test1.txt', 13, 0, 2, CAST(0x0000A1CF00D6BCA8 AS DateTime), 10240, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (33, 5, 20, N'7c8de133-edc1-4ee1-90e4-a2290faa104b', N'test1.txt', 13, 0, 2, CAST(0x0000A1CF00D7C1E5 AS DateTime), 3145728, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (34, 5, 20, N'ff059710-3119-46df-a8d3-ce8162a6905e', N'test2.txt', 13, 0, 2, CAST(0x0000A1CF00D7FC75 AS DateTime), 4194304, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (35, 5, 20, N'7ea3b231-dd9e-41fc-af4f-c4cc842f267d', N'test5.txt', 13, 0, 2, CAST(0x0000A1CF00D8239B AS DateTime), 5242880, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (36, 5, 20, N'bc570a59-42b6-4f1a-9378-24a50e5c52bd', N'test7.txt', 13, 0, 2, CAST(0x0000A1CF00D862ED AS DateTime), 7864320, 0)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (41, 5, 22, N'', N'test13', 1, 0, 21, CAST(0x0000A1CF00DFB90C AS DateTime), 0, 1)
INSERT [dbo].[tblFile] ([Id], [UserId], [CourseId], [PhysicalPath], [FileName], [FileTypeId], [Rate], [ParentFileID], [LastModify], [Size], [IsFolder]) VALUES (43, 8, 22, N'', N'eliran', 1, 0, 21, CAST(0x0000A1D400B19684 AS DateTime), 0, 1)
SET IDENTITY_INSERT [dbo].[tblFile] OFF
/****** Object:  StoredProcedure [dbo].[SP_Register]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_InsertNewFileToCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
            Insert INTO tblFile VALUES (@UserID,@CourseID,@PhysicalPath,@FileName,@FileTypeID,0,@parentFileID,getdate(),@Size,@IsFolder)
            
            select 1 as 'Result'
      end
      else
            select 0 as 'Result'
end
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertAction]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_UpdateCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_SetUserAsAdmin]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ReturnParticipantsByCourseID]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_ReturnCouresebyUserID]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_GetFilesByCourseID]    Script Date: 06/05/2013 12:14:32 ******/
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
            SELECT f.Id, f.UserId, u.UserName, f.FileName, f.Rate, f.Size, 
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
/****** Object:  StoredProcedure [dbo].[SP_GetFilePhysicalPath]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteUserFromCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteFile]    Script Date: 06/05/2013 12:14:32 ******/
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
    set @fId = (SELECT f.Id from tblFile f
				left JOIN tblParticipants p on p.CourseID=f.CourseId
				where f.Id = @fId AND (f.UserId=@UserID OR (p.UserId=@UserID AND p.IsAdmin=1)))
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
/****** Object:  StoredProcedure [dbo].[SP_DeleteCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_CreateNewCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
      insert INTO tblFile VALUES (@UserID,@resultCourseID,null,'Root',1,0,NULL,getdate(),0,1)
      select @resultCourseID as Result
end
else
      select NULL as Result;
      
end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddSession]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  StoredProcedure [dbo].[SP_AddNewUserToCourse]    Script Date: 06/05/2013 12:14:32 ******/
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
/****** Object:  Default [DF__tblPartic__IsAdm__173876EA]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblParticipants] ADD  DEFAULT ((0)) FOR [IsAdmin]
GO
/****** Object:  Default [DF__tblForum__RootId__1920BF5C]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblForum] ADD  DEFAULT ((-1)) FOR [RootId]
GO
/****** Object:  ForeignKey [FK_tblSessions_tblUser]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblSessions]  WITH CHECK ADD  CONSTRAINT [FK_tblSessions_tblUser] FOREIGN KEY([UserID])
REFERENCES [dbo].[tblUser] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblSessions] CHECK CONSTRAINT [FK_tblSessions_tblUser]
GO
/****** Object:  ForeignKey [fk_paCourse]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblParticipants]  WITH CHECK ADD  CONSTRAINT [fk_paCourse] FOREIGN KEY([CourseID])
REFERENCES [dbo].[tblCourse] ([Id])
GO
ALTER TABLE [dbo].[tblParticipants] CHECK CONSTRAINT [fk_paCourse]
GO
/****** Object:  ForeignKey [fk_paUser]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblParticipants]  WITH CHECK ADD  CONSTRAINT [fk_paUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblParticipants] CHECK CONSTRAINT [fk_paUser]
GO
/****** Object:  ForeignKey [fk_forumCourse]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblForum]  WITH CHECK ADD  CONSTRAINT [fk_forumCourse] FOREIGN KEY([CourseId])
REFERENCES [dbo].[tblCourse] ([Id])
GO
ALTER TABLE [dbo].[tblForum] CHECK CONSTRAINT [fk_forumCourse]
GO
/****** Object:  ForeignKey [fk_forunUser]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblForum]  WITH CHECK ADD  CONSTRAINT [fk_forunUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblForum] CHECK CONSTRAINT [fk_forunUser]
GO
/****** Object:  ForeignKey [fk_root]    Script Date: 06/05/2013 12:14:31 ******/
ALTER TABLE [dbo].[tblForum]  WITH CHECK ADD  CONSTRAINT [fk_root] FOREIGN KEY([RootId])
REFERENCES [dbo].[tblForum] ([Id])
GO
ALTER TABLE [dbo].[tblForum] CHECK CONSTRAINT [fk_root]
GO
/****** Object:  ForeignKey [FK_tblAction_tblUser]    Script Date: 06/05/2013 12:14:32 ******/
ALTER TABLE [dbo].[tblAction]  WITH CHECK ADD  CONSTRAINT [FK_tblAction_tblUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
GO
ALTER TABLE [dbo].[tblAction] CHECK CONSTRAINT [FK_tblAction_tblUser]
GO
/****** Object:  ForeignKey [fk_fileCourse]    Script Date: 06/05/2013 12:14:32 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileCourse] FOREIGN KEY([CourseId])
REFERENCES [dbo].[tblCourse] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileCourse]
GO
/****** Object:  ForeignKey [fk_fileType]    Script Date: 06/05/2013 12:14:32 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileType] FOREIGN KEY([FileTypeId])
REFERENCES [dbo].[tblFileType] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileType]
GO
/****** Object:  ForeignKey [fk_fileUser]    Script Date: 06/05/2013 12:14:32 ******/
ALTER TABLE [dbo].[tblFile]  WITH CHECK ADD  CONSTRAINT [fk_fileUser] FOREIGN KEY([UserId])
REFERENCES [dbo].[tblUser] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tblFile] CHECK CONSTRAINT [fk_fileUser]
GO
