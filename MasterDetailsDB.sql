USE [master]
GO
/****** Object:  Database [MasterDetailsDB]    Script Date: 25-Jun-21 11:09:08 PM ******/
CREATE DATABASE [MasterDetailsDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MasterDetailsDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BANNA\MSSQL\DATA\MasterDetailsDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MasterDetailsDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.BANNA\MSSQL\DATA\MasterDetailsDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [MasterDetailsDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MasterDetailsDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MasterDetailsDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MasterDetailsDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MasterDetailsDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MasterDetailsDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MasterDetailsDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MasterDetailsDB] SET  MULTI_USER 
GO
ALTER DATABASE [MasterDetailsDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MasterDetailsDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MasterDetailsDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MasterDetailsDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MasterDetailsDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MasterDetailsDB', N'ON'
GO
ALTER DATABASE [MasterDetailsDB] SET QUERY_STORE = OFF
GO
USE [MasterDetailsDB]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 25-Jun-21 11:09:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 25-Jun-21 11:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceId] [int] IDENTITY(1,1) NOT NULL,
	[SupplierId] [int] NULL,
	[RefId] [nvarchar](50) NULL,
	[PONo] [nvarchar](50) NULL,
	[PODate] [datetime] NULL,
	[ExpectedDate] [datetime] NULL,
	[Remarks] [nvarchar](200) NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetails]    Script Date: 25-Jun-21 11:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetails](
	[InvoiceDetailsId] [int] IDENTITY(1,1) NOT NULL,
	[ItemId] [int] NULL,
	[Quantity] [int] NULL,
	[Rate] [float] NULL,
	[InvoiceId] [int] NULL,
 CONSTRAINT [PK_InvoiceDetails] PRIMARY KEY CLUSTERED 
(
	[InvoiceDetailsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Item]    Script Date: 25-Jun-21 11:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item](
	[ItemID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 25-Jun-21 11:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderNo] [nvarchar](50) NULL,
	[CustomerID] [int] NULL,
	[PMethod] [nvarchar](50) NULL,
	[GTotal] [decimal](18, 0) NULL,
	[RefId] [nvarchar](50) NULL,
	[PONo] [nvarchar](50) NULL,
	[PODate] [datetime] NULL,
	[ExpectedDate] [datetime] NULL,
	[Remarks] [nvarchar](200) NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderItem]    Script Date: 25-Jun-21 11:09:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderItem](
	[OrderItemID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NULL,
	[ItemID] [int] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_OrderItem_1] PRIMARY KEY CLUSTERED 
(
	[OrderItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerID], [Name]) VALUES (1, N'Amir Sohel')
INSERT [dbo].[Customer] ([CustomerID], [Name]) VALUES (2, N'Raisul Islam')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([InvoiceId], [SupplierId], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (2, 1, N'100001', N'1000111113', CAST(N'2021-06-25T11:14:33.747' AS DateTime), CAST(N'2021-06-25T18:00:00.000' AS DateTime), N'Test')
INSERT [dbo].[Invoice] ([InvoiceId], [SupplierId], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (3, 2, N'asadd', N'10001111', CAST(N'2021-06-25T09:51:05.230' AS DateTime), CAST(N'2021-07-09T18:00:00.000' AS DateTime), N'test')
INSERT [dbo].[Invoice] ([InvoiceId], [SupplierId], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (4, 1, N'456123', N'1000111112', CAST(N'2021-06-25T10:28:16.170' AS DateTime), CAST(N'2021-06-22T06:00:00.000' AS DateTime), N'Test')
INSERT [dbo].[Invoice] ([InvoiceId], [SupplierId], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (5, 2, N'4512387', N'1000111114', CAST(N'2021-06-25T12:21:59.717' AS DateTime), CAST(N'2021-07-14T12:00:00.000' AS DateTime), N'Raislul Order')
SET IDENTITY_INSERT [dbo].[Invoice] OFF
SET IDENTITY_INSERT [dbo].[InvoiceDetails] ON 

INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (3, 1, 10, 50, 2)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (4, 2, 2, 30, 2)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (5, 4, 3, 30, 2)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (6, 1, 20, 10, 3)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (7, 3, 2, 30, 3)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (9, 1, 10, 20, 4)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (10, 3, 10, 2, 2)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (11, 1, 50, 50, 5)
INSERT [dbo].[InvoiceDetails] ([InvoiceDetailsId], [ItemId], [Quantity], [Rate], [InvoiceId]) VALUES (12, 2, 5, 30, 5)
SET IDENTITY_INSERT [dbo].[InvoiceDetails] OFF
SET IDENTITY_INSERT [dbo].[Item] ON 

INSERT [dbo].[Item] ([ItemID], [Name], [Price]) VALUES (1, N'A', CAST(50 AS Decimal(18, 0)))
INSERT [dbo].[Item] ([ItemID], [Name], [Price]) VALUES (2, N'B', CAST(100 AS Decimal(18, 0)))
INSERT [dbo].[Item] ([ItemID], [Name], [Price]) VALUES (3, N'C', CAST(150 AS Decimal(18, 0)))
INSERT [dbo].[Item] ([ItemID], [Name], [Price]) VALUES (4, N'D', CAST(200 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Item] OFF
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [OrderNo], [CustomerID], [PMethod], [GTotal], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (1, N'512649', 1, N'', CAST(400 AS Decimal(18, 0)), N'101', N'10000', CAST(N'2021-06-24T19:24:44.807' AS DateTime), CAST(N'2021-06-24T19:24:44.807' AS DateTime), N'Test')
INSERT [dbo].[Order] ([OrderID], [OrderNo], [CustomerID], [PMethod], [GTotal], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (2, N'248345', 2, N'', CAST(900 AS Decimal(18, 0)), N'100', N'1000', CAST(N'2021-06-24T19:48:52.863' AS DateTime), CAST(N'2021-06-24T19:48:52.863' AS DateTime), N'test')
INSERT [dbo].[Order] ([OrderID], [OrderNo], [CustomerID], [PMethod], [GTotal], [RefId], [PONo], [PODate], [ExpectedDate], [Remarks]) VALUES (3, N'273761', 1, N'', CAST(1000 AS Decimal(18, 0)), N'145', N'1000', CAST(N'2021-06-24T19:52:32.363' AS DateTime), CAST(N'2021-06-24T19:52:32.363' AS DateTime), N'Test')
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderItem] ON 

INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ItemID], [Quantity]) VALUES (1, 1, 1, 2)
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ItemID], [Quantity]) VALUES (2, 1, 2, 3)
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ItemID], [Quantity]) VALUES (3, 2, 3, 2)
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ItemID], [Quantity]) VALUES (4, 2, 4, 3)
INSERT [dbo].[OrderItem] ([OrderItemID], [OrderID], [ItemID], [Quantity]) VALUES (5, 3, 1, 20)
SET IDENTITY_INSERT [dbo].[OrderItem] OFF
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customer] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customer]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_Invoice] FOREIGN KEY([InvoiceId])
REFERENCES [dbo].[Invoice] ([InvoiceId])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_Invoice]
GO
ALTER TABLE [dbo].[InvoiceDetails]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetails_Item] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[InvoiceDetails] CHECK CONSTRAINT [FK_InvoiceDetails_Item]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customer] ([CustomerID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customer]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ItemID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Item]
GO
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderItem] CHECK CONSTRAINT [FK_OrderItem_Order]
GO
USE [master]
GO
ALTER DATABASE [MasterDetailsDB] SET  READ_WRITE 
GO
