
USE [master]
GO
/****** Object:  Database [sample]    Script Date: 3/9/2019 3:20:19 PM ******/
CREATE DATABASE [sample]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sample', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\sample.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sample_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\sample_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [sample] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sample].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sample] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sample] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sample] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sample] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sample] SET ARITHABORT OFF 
GO
ALTER DATABASE [sample] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [sample] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sample] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sample] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sample] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sample] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sample] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sample] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sample] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sample] SET  ENABLE_BROKER 
GO
ALTER DATABASE [sample] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sample] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sample] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sample] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sample] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sample] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sample] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sample] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [sample] SET  MULTI_USER 
GO
ALTER DATABASE [sample] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sample] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sample] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sample] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sample] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sample] SET QUERY_STORE = OFF
GO
USE [sample]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [sample]
GO
/****** Object:  Table [dbo].[ChildItems]    Script Date: 3/9/2019 3:20:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChildItems](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ItemID] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[Opened] [date] NULL,
	[Closed] [date] NULL,
	[priority] [int] NULL,
	[EndDate] [date] NULL,
 CONSTRAINT [PK_ChildItems] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[items]    Script Date: 3/9/2019 3:20:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[items](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](100) NULL,
	[Opened] [date] NULL,
	[Closed] [date] NULL,
	[Priority] [int] NULL,
	[EndDate] [date] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ChildItems] ON 
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (2, 3, N'Sub1', NULL, CAST(N'2019-03-07' AS Date), 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (3, 13, N'test1', NULL, CAST(N'2019-03-06' AS Date), 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (4, 14, N'kishore12', NULL, NULL, 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (6, 14, N'kishore16', NULL, NULL, 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (7, 14, N'kishore77', NULL, NULL, 1, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (8, 14, N'kishore143', NULL, NULL, 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (9, 14, N'deepak143', NULL, NULL, 2, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (10, 13, N'kishore12', NULL, CAST(N'2019-03-06' AS Date), 3, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (15, 13, N'kishore12', NULL, CAST(N'2019-03-07' AS Date), 3, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (16, 4, N'sub1`', NULL, CAST(N'2019-03-07' AS Date), 3, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (17, 5, N'kishore12', NULL, NULL, 1, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (18, 0, N'kishore12', NULL, NULL, 1, CAST(N'2019-07-03' AS Date))
GO
INSERT [dbo].[ChildItems] ([ID], [ItemID], [Description], [Opened], [Closed], [priority], [EndDate]) VALUES (19, 25, N'Sub1', NULL, NULL, 1, CAST(N'2019-07-03' AS Date))
GO
SET IDENTITY_INSERT [dbo].[ChildItems] OFF
GO
SET IDENTITY_INSERT [dbo].[items] ON 
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (13, N'test', NULL, CAST(N'2019-03-07' AS Date), 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (2, N'Water the lawn', CAST(N'2001-11-15' AS Date), CAST(N'2019-03-06' AS Date), 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (3, N'Wash the dog', CAST(N'2001-11-15' AS Date), CAST(N'2019-03-07' AS Date), 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (4, N'Feed the cat', CAST(N'2001-11-15' AS Date), CAST(N'2019-03-07' AS Date), 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (5, N'Read a good book', CAST(N'2001-11-15' AS Date), NULL, 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (14, N'kishore', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (7, N'Do something really important that I can''t quite remember right now', CAST(N'2001-11-15' AS Date), NULL, 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (25, N'Test123', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (33, N'ssss', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (17, N'tASK1', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (34, N'test12345', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (35, N'111111', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (37, N'balu5554454', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (39, N'fgffffffffff', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (11, N'balutest', NULL, NULL, 2, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (12, N'teeeee', NULL, CAST(N'2019-03-06' AS Date), 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (27, N'kishore12', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (36, N'balu12345', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
INSERT [dbo].[items] ([ID], [Description], [Opened], [Closed], [Priority], [EndDate]) VALUES (38, N'balu2222222222222', NULL, NULL, 1, CAST(N'2019-03-09' AS Date))
GO
SET IDENTITY_INSERT [dbo].[items] OFF
GO
/****** Object:  StoredProcedure [dbo].[SP_UPSERT_ITEMS_CHILEDITEMS]    Script Date: 3/9/2019 3:20:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPSERT_ITEMS_CHILEDITEMS]
	(
	    @CHILDID INT =0,
		@ITEMID INT = 0
	)
AS
BEGIN
		
        IF(@ITEMID = 0 AND @CHILDID > 0)
		 BEGIN
		        UPDATE ChildItems SET Closed = GETDATE() WHERE ID = @CHILDID
		        SET @ITEMID  = (SELECT ItemID FROM ChildItems WHERE ID = @CHILDID)
			    DECLARE @CHILDITEMLISTVALIDITED INT = (SELECT COUNT(1) AS N FROM ChildItems WHERE ItemID= @ITEMID AND Closed  IS NULL)

				IF(ISNULL(@CHILDITEMLISTVALIDITED,0) = 0)
				BEGIN
					UPDATE items SET Closed = GETDATE() WHERE ID = @ITEMID
				END
		 END
		ELSE
		BEGIN
		       UPDATE items SET Closed = GETDATE() WHERE ID = @ITEMID
			   UPDATE ChildItems SET Closed = GETDATE() WHERE ID = @ITEMID AND Closed IS NULL
        END
		

END

GO
USE [master]
GO
ALTER DATABASE [sample] SET  READ_WRITE 
GO
