USE [DB_A3AAAD_goldencape]
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
USE [DB_A3AAAD_goldencape]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 02/05/2018 2:34:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountNo] [nvarchar](50) NULL,
	[AccountName] [nvarchar](100) NULL,
	[BankName] [nvarchar](50) NULL,
	[Branch] [nvarchar](50) NULL,
	[Status] [nvarchar](20) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetails]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetails](
	[BookingDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NULL,
	[MainTable] [nvarchar](100) NULL,
	[MainTableQty] [nvarchar](10) NULL,
	[EightSeater] [nvarchar](100) NULL,
	[Monoblock] [nvarchar](100) NULL,
	[KiddieTables] [nvarchar](100) NULL,
	[BuffetTables] [nvarchar](100) NULL,
	[Utensils] [nvarchar](100) NULL,
	[RollTop] [nvarchar](100) NULL,
	[ChafingDish] [nvarchar](100) NULL,
	[Flowers] [nvarchar](100) NULL,
	[HeadWaiter] [nvarchar](100) NULL,
	[WaterIce] [nvarchar](100) NULL,
	[EightSeaterRound] [nvarchar](100) NULL,
	[Napkin] [nvarchar](100) NULL,
	[ChairCover] [nvarchar](100) NULL,
	[BuffetDir] [nvarchar](100) NULL,
	[BuffetSkir] [nvarchar](100) NULL,
	[BuffetCrump] [nvarchar](100) NULL,
	[UserID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_BookingDetails] PRIMARY KEY CLUSTERED 
(
	[BookingDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingLinen]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingLinen](
	[BookingLinenID] [int] IDENTITY(1,1) NOT NULL,
	[StockID] [nvarchar](50) NULL,
	[Qty] [int] NULL,
	[BookingDetailsID] [int] NULL,
	[UserID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_BookingLinen] PRIMARY KEY CLUSTERED 
(
	[BookingLinenID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingID] [int] IDENTITY(1,1) NOT NULL,
	[EventDateTime] [datetime] NULL,
	[IngressTime] [time](7) NULL,
	[EatingTime] [time](7) NULL,
	[EventAddress] [nvarchar](max) NULL,
	[Theme] [nvarchar](100) NULL,
	[AdultGuest] [nvarchar](10) NULL,
	[KidGuest] [nvarchar](10) NULL,
	[ClientID] [int] NULL,
	[Remarks] [nvarchar](max) NULL,
	[UserID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Bookings] PRIMARY KEY CLUSTERED 
(
	[BookingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cheques]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cheques](
	[ChequeID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NULL,
	[CheckNo] [nvarchar](50) NULL,
	[PayableTo] [nvarchar](100) NULL,
	[CheckAmount] [decimal](18, 2) NULL,
	[CheckDate] [datetime] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Cheques] PRIMARY KEY CLUSTERED 
(
	[ChequeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[ContactFirstName] [nvarchar](50) NULL,
	[ContactLastName] [nvarchar](50) NULL,
	[ContactNo] [nvarchar](50) NULL,
	[EmailAddress] [nvarchar](100) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[InvoiceDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[SupplierID] [nchar](10) NULL,
	[CheckID] [int] NULL,
	[Status] [nvarchar](10) NULL,
	[UserID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Logs]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[LogTitle] [nvarchar](50) NULL,
	[LogContent] [nvarchar](250) NULL,
	[LogType] [nvarchar](50) NULL,
	[UserID] [int] NULL,
	[LogDate] [datetime] NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[MenuID] [int] IDENTITY(1,1) NOT NULL,
	[MenuName] [nvarchar](100) NULL,
	[Guest] [nvarchar](50) NULL,
	[BookingDetailsID] [int] NULL,
	[UserID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Menuu] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OtherDetails]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherDetails](
	[OtherDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[BookingDetailsID] [int] NULL,
	[Stylist] [nvarchar](100) NULL,
	[Host] [nvarchar](100) NULL,
	[Planner] [nvarchar](100) NULL,
	[Media] [nvarchar](100) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_OtherDetails] PRIMARY KEY CLUSTERED 
(
	[OtherDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[BasicFee] [decimal](18, 2) NULL,
	[MiscFee] [decimal](18, 2) NULL,
	[MiscDesc] [nvarchar](100) NULL,
	[OtherFee] [decimal](18, 2) NULL,
	[DownPayment] [decimal](18, 2) NULL,
	[PaymentMethod] [nvarchar](100) NULL,
	[Balance] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[VAT] [nvarchar](10) NULL,
	[Status] [nvarchar](10) NULL,
	[BookingID] [int] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Payments] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Scheduler]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Scheduler](
	[SchedulerID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [int] NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[AllDay] [bit] NULL,
	[Subject] [nvarchar](100) NULL,
	[Location] [nvarchar](100) NULL,
	[OriginalOccurrenceStart] [smalldatetime] NULL,
	[OriginalOccurrenceEnd] [smalldatetime] NULL,
	[Description] [nvarchar](100) NULL,
	[Status] [int] NULL,
	[Label] [int] NULL,
	[ResourceID] [int] NULL,
	[ResourceIDs] [nvarchar](max) NULL,
	[ReminderInfo] [nvarchar](max) NULL,
	[RecurrenceInfo] [nvarchar](max) NULL,
	[CustomField] [nvarchar](max) NULL,
	[TimeZoneId] [nvarchar](50) NULL,
 CONSTRAINT [PK_OpportunityActivity] PRIMARY KEY CLUSTERED 
(
	[SchedulerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stocks]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stocks](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[StockTypeID] [nvarchar](50) NULL,
	[StockName] [nvarchar](50) NULL,
	[StockDescription] [nvarchar](50) NULL,
	[Qty] [decimal](18, 0) NULL,
	[Status] [nvarchar](10) NULL,
	[DateModified] [datetime] NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Linens] PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockType]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockType](
	[StockTypeID] [int] IDENTITY(1,1) NOT NULL,
	[StockTypeName] [nvarchar](50) NULL,
	[Status] [nvarchar](10) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_StockType] PRIMARY KEY CLUSTERED 
(
	[StockTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[SupplierName] [nvarchar](100) NULL,
	[ContactNo] [nvarchar](50) NULL,
	[Address] [nvarchar](250) NULL,
	[ContactPerson] [nvarchar](100) NULL,
	[Status] [nvarchar](50) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Password] [nvarchar](max) NULL,
	[UserName] [nvarchar](50) NULL,
	[TypeID] [int] NULL,
	[Status] [nvarchar](50) NULL,
	[DateAdded] [datetime] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTypes]    Script Date: 02/05/2018 2:34:51 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTypes](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserType] [nvarchar](50) NULL,
 CONSTRAINT [PK_UserTypes] PRIMARY KEY CLUSTERED 
(
	[TypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Accounts] ON 

INSERT [dbo].[Accounts] ([AccountID], [AccountNo], [AccountName], [BankName], [Branch], [Status], [DateAdded]) VALUES (1, N'0045899754512', N'Steven Tomas', N'BDO', N'Pablo Ocampo', N'Active', CAST(N'2018-04-21T14:30:09.183' AS DateTime))
INSERT [dbo].[Accounts] ([AccountID], [AccountNo], [AccountName], [BankName], [Branch], [Status], [DateAdded]) VALUES (2, N'7845112457', N'Steven Tomas 2', N'BPI', N'Vito Cruz', N'Active', CAST(N'2018-04-22T01:34:45.657' AS DateTime))
SET IDENTITY_INSERT [dbo].[Accounts] OFF
SET IDENTITY_INSERT [dbo].[BookingDetails] ON 

INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (4, 11, N'10 Seater Round', NULL, N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-18T02:17:22.847' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (9, 16, N'Cocktail Table', NULL, N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-18T02:37:32.310' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (10, 17, N'10 Seater Round', NULL, N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-18T02:42:59.630' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (11, 20, N'10 Seater Round', NULL, N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 1, CAST(N'2018-04-19T02:17:23.407' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (12, 21, N'Party Tray', NULL, N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-19T22:01:05.843' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (14, 24, N'10 Seater Round', N'21', N'', N'210', N'Yes (15 pcs)', N'Yes (2 way)', N'Yes', N'Yes', N'', N'Flower Moms / Carnation', N'Yes', N'Yes', N'', N'Blue', N'White', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-24T12:02:12.830' AS DateTime))
INSERT [dbo].[BookingDetails] ([BookingDetailsID], [BookingID], [MainTable], [MainTableQty], [EightSeater], [Monoblock], [KiddieTables], [BuffetTables], [Utensils], [RollTop], [ChafingDish], [Flowers], [HeadWaiter], [WaterIce], [EightSeaterRound], [Napkin], [ChairCover], [BuffetDir], [BuffetSkir], [BuffetCrump], [UserID], [DateAdded]) VALUES (15, 1022, N'10 Seater Round', N'10', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', N'Yes', 1, CAST(N'2018-04-28T22:27:04.400' AS DateTime))
SET IDENTITY_INSERT [dbo].[BookingDetails] OFF
SET IDENTITY_INSERT [dbo].[BookingLinen] ON 

INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (33, N'2', 2, 4, 1, CAST(N'2018-04-18T02:16:12.490' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (34, N'7', 2, 4, 1, CAST(N'2018-04-18T02:16:31.077' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (35, N'3', 2, 4, 1, CAST(N'2018-04-18T02:16:47.527' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (36, N'2', 2, 9, 1, CAST(N'2018-04-18T02:29:36.377' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (37, N'7', 2, 9, 1, CAST(N'2018-04-18T02:29:42.097' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (38, N'7', 2, 9, 1, CAST(N'2018-04-18T02:34:39.997' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (42, N'7', 5, 12, 1, CAST(N'2018-04-19T22:00:42.097' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (43, N'5', 5, 12, 1, CAST(N'2018-04-19T22:00:54.253' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (49, N'2', 4, 10, 1, CAST(N'2018-04-20T14:42:34.933' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (50, N'7', 6, 10, 1, CAST(N'2018-04-20T14:42:40.937' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (51, N'2', 6, 11, 1, CAST(N'2018-04-20T14:53:34.720' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1050, N'9', 2, 14, 1, CAST(N'2018-04-24T12:05:58.460' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1051, N'10', 2, 14, 1, CAST(N'2018-04-24T12:06:08.073' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1052, N'11', 2, 14, 1, CAST(N'2018-04-24T12:06:16.540' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1053, N'12', 2, 14, 1, CAST(N'2018-04-24T12:06:22.540' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1054, N'13', 2, 14, 1, CAST(N'2018-04-24T12:06:29.513' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1055, N'14', 2, 14, 1, CAST(N'2018-04-24T12:06:31.493' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (2044, N'7', 2, 15, 1, CAST(N'2018-04-28T22:14:01.453' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (2045, N'13', 2, 15, 1, CAST(N'2018-04-28T22:14:10.080' AS DateTime))
INSERT [dbo].[BookingLinen] ([BookingLinenID], [StockID], [Qty], [BookingDetailsID], [UserID], [DateAdded]) VALUES (2046, N'11', 2, 15, 1, CAST(N'2018-04-28T22:14:12.350' AS DateTime))
SET IDENTITY_INSERT [dbo].[BookingLinen] OFF
SET IDENTITY_INSERT [dbo].[Bookings] ON 

INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (11, CAST(N'2018-04-19T09:00:00.000' AS DateTime), CAST(N'09:00:00' AS Time), CAST(N'09:00:00' AS Time), NULL, N'Avengers', N'100', N'50', 3, N'Lechon', 1, CAST(N'2018-04-18T02:17:22.830' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (16, CAST(N'2018-04-23T18:00:00.000' AS DateTime), CAST(N'16:00:00' AS Time), CAST(N'16:00:00' AS Time), NULL, N'Hollywood', N'100', N'50', 3, N'Nothing', 1, CAST(N'2018-04-18T02:37:32.270' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (17, CAST(N'2018-04-18T10:00:00.000' AS DateTime), CAST(N'10:00:00' AS Time), CAST(N'10:00:00' AS Time), NULL, N'Avengers', N'100', N'100', 3, N'', 1, CAST(N'2018-04-18T02:42:59.620' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (18, CAST(N'2018-04-21T08:30:00.000' AS DateTime), CAST(N'08:30:00' AS Time), CAST(N'08:30:00' AS Time), NULL, N'', N'', N'', 3, N'', 1, CAST(N'2018-04-19T02:09:12.680' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (19, CAST(N'2018-04-24T07:54:00.000' AS DateTime), CAST(N'07:54:00' AS Time), CAST(N'07:54:00' AS Time), NULL, N'', N'', N'', 3, N'Test', 1, CAST(N'2018-04-19T02:11:36.380' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (20, CAST(N'2018-04-23T19:00:00.000' AS DateTime), CAST(N'19:00:00' AS Time), CAST(N'19:00:00' AS Time), NULL, N'', N'', N'', 3, N'Something', 1, CAST(N'2018-04-19T02:17:23.367' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (21, CAST(N'2018-05-01T16:00:00.000' AS DateTime), CAST(N'15:00:00' AS Time), CAST(N'15:00:00' AS Time), NULL, N'Iron Man', N'100', N'200', 3, N'Nothing', 1, CAST(N'2018-04-19T22:01:05.827' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (24, CAST(N'2018-04-08T11:00:00.000' AS DateTime), CAST(N'11:00:00' AS Time), CAST(N'11:00:00' AS Time), N'Valle Verde Clubhouse', N'Kiddie Birthday Party – Hawaiian Theme', N'190', N'60', 1002, N'Client will have lechon, cake table, gift, prize, loot bag, client will provide table number', 1, CAST(N'2018-04-24T12:02:11.580' AS DateTime))
INSERT [dbo].[Bookings] ([BookingID], [EventDateTime], [IngressTime], [EatingTime], [EventAddress], [Theme], [AdultGuest], [KidGuest], [ClientID], [Remarks], [UserID], [DateAdded]) VALUES (1022, CAST(N'2018-04-28T15:00:00.000' AS DateTime), CAST(N'15:00:00' AS Time), CAST(N'15:00:00' AS Time), N'Makati City', N'Themester', N'150', N'100', 3, N'with lechon', 1, CAST(N'2018-04-28T22:27:04.350' AS DateTime))
SET IDENTITY_INSERT [dbo].[Bookings] OFF
SET IDENTITY_INSERT [dbo].[Cheques] ON 

INSERT [dbo].[Cheques] ([ChequeID], [AccountID], [CheckNo], [PayableTo], [CheckAmount], [CheckDate], [DateAdded]) VALUES (1, 1, N'4454114578', N'Bruce Banner', CAST(10000000.00 AS Decimal(18, 2)), CAST(N'2018-04-23T00:00:00.000' AS DateTime), CAST(N'2018-04-22T02:05:23.297' AS DateTime))
INSERT [dbo].[Cheques] ([ChequeID], [AccountID], [CheckNo], [PayableTo], [CheckAmount], [CheckDate], [DateAdded]) VALUES (2, 2, N'007784114', N'Iron man', CAST(150000.00 AS Decimal(18, 2)), CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(N'2018-04-22T02:47:04.027' AS DateTime))
INSERT [dbo].[Cheques] ([ChequeID], [AccountID], [CheckNo], [PayableTo], [CheckAmount], [CheckDate], [DateAdded]) VALUES (1002, 1, N'445457', N'Microsoft', CAST(58500.00 AS Decimal(18, 2)), CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(N'2018-04-30T01:02:08.190' AS DateTime))
SET IDENTITY_INSERT [dbo].[Cheques] OFF
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (1, N'Bruce', N'Banner', N'094231232', N'thehulk@gmail.com', CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (2, N'Captain', N'America', N'09321234232', N'camerica@live.com', CAST(N'2018-04-12T18:44:29.873' AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (3, N'Steven', N'Tomas', N'09231234242', N'steventms@gmail.com', CAST(N'2018-04-12T18:48:11.170' AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (4, N'Jennifer', N'Lee', N'09142321233', N'jen@gmail.com', CAST(N'2018-04-12T18:50:53.773' AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (5, N'Juan', N'Dela Cruz', N'09942325677', N'jcruz@gmail.com', CAST(N'2018-04-12T18:58:25.383' AS DateTime))
INSERT [dbo].[Clients] ([ClientID], [ContactFirstName], [ContactLastName], [ContactNo], [EmailAddress], [DateAdded]) VALUES (1002, N'Rachelle', N'Lam', N'09778290425', N'Rachellela@yahoo.com', CAST(N'2018-04-24T11:47:56.900' AS DateTime))
SET IDENTITY_INSERT [dbo].[Clients] OFF
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([InvoiceID], [InvoiceNumber], [Description], [InvoiceDate], [Amount], [SupplierID], [CheckID], [Status], [UserID], [DateAdded]) VALUES (12, N'1121245', N'', CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'1         ', 1002, N'Active', 1, CAST(N'2018-04-30T00:44:33.597' AS DateTime))
INSERT [dbo].[Invoice] ([InvoiceID], [InvoiceNumber], [Description], [InvoiceDate], [Amount], [SupplierID], [CheckID], [Status], [UserID], [DateAdded]) VALUES (13, N'224245', N'', CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(10000.00 AS Decimal(18, 2)), N'1         ', 1002, N'Active', 1, CAST(N'2018-04-30T00:44:36.427' AS DateTime))
INSERT [dbo].[Invoice] ([InvoiceID], [InvoiceNumber], [Description], [InvoiceDate], [Amount], [SupplierID], [CheckID], [Status], [UserID], [DateAdded]) VALUES (14, N'778784', N'', CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(16000.00 AS Decimal(18, 2)), N'1         ', 1002, N'Active', 1, CAST(N'2018-04-30T00:44:41.680' AS DateTime))
INSERT [dbo].[Invoice] ([InvoiceID], [InvoiceNumber], [Description], [InvoiceDate], [Amount], [SupplierID], [CheckID], [Status], [UserID], [DateAdded]) VALUES (15, N'221121', N'', CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(5000.00 AS Decimal(18, 2)), N'1         ', 1002, N'Active', 1, CAST(N'2018-04-30T00:44:44.943' AS DateTime))
INSERT [dbo].[Invoice] ([InvoiceID], [InvoiceNumber], [Description], [InvoiceDate], [Amount], [SupplierID], [CheckID], [Status], [UserID], [DateAdded]) VALUES (16, N'778784', N'', CAST(N'2018-04-30T00:00:00.000' AS DateTime), CAST(17500.00 AS Decimal(18, 2)), N'1         ', 1002, N'Active', 1, CAST(N'2018-04-30T00:44:50.247' AS DateTime))
SET IDENTITY_INSERT [dbo].[Invoice] OFF
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1, N'Add Client', N'Added client Anthony, Mark', N'', 1, CAST(N'2018-04-12T18:54:47.383' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (2, N'Add Client', N'Added client Anthony, Mark', N'', 1, CAST(N'2018-04-12T18:55:26.683' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3, N'Add Client', N'Added client Dela Cruz, Juan', N'', 1, CAST(N'2018-04-12T18:56:25.863' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (4, N'Add Client', N'Added client Dela Cruz, Juan', N'', 1, CAST(N'2018-04-12T18:57:47.720' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (5, N'Add Client', N'Added client Dela Cruz, Juan', N'', 1, CAST(N'2018-04-12T18:58:25.400' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (6, N'Add Stock Type', N'Added new stock type asd', N'', 1, CAST(N'2018-04-12T21:01:52.513' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (7, N'Add Stock', N'Added new stock Red', N'with stains', 1, CAST(N'2018-04-12T22:09:29.933' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1002, N'Add Stock', N'Added new stock red', N'', 1, CAST(N'2018-04-14T18:25:58.693' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1003, N'Add Stock', N'Added new stock Blue', N'', 1, CAST(N'2018-04-17T01:24:39.260' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1004, N'Add Booking', N'Added new booking Tomas, Steven Marikina City 2018-04-23T15:00', N'', 1, CAST(N'2018-04-18T02:37:32.573' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1005, N'Add Booking', N'Added new booking Tomas, Steven - Marikina City - 18/04/2018 10:00:00 AM', N'', 1, CAST(N'2018-04-18T02:42:59.763' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1006, N'Add Booking', N'Added new booking: Tomas, Steven - Marikina City - 21/04/2018 8:30:00 AM', N'', 1, CAST(N'2018-04-19T02:09:18.103' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1007, N'Add Booking', N'Added new booking: Tomas, Steven - Marikina City - 24/04/2018 7:54:00 AM', N'', 1, CAST(N'2018-04-19T02:11:36.443' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1008, N'Add Booking', N'Added new booking: Tomas, Steven - Marikina City - 23/04/2018 7:00:00 PM', N'', 1, CAST(N'2018-04-19T02:17:23.517' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1009, N'Add Booking', N'Added new booking: ,  -  - 01/05/2018 3:00:00 PM', N'', 1, CAST(N'2018-04-19T22:01:06.053' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1010, N'Add Supplier', N'Added supplier: Microsoft', N'', 1, CAST(N'2018-04-20T12:20:00.297' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (1011, N'Add Account', N'Added new account: BDO Steven Tomas', N'', 1, CAST(N'2018-04-21T14:30:09.227' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (2010, N'Add Account', N'Added new account: BPI Steven Tomas', N'', 1, CAST(N'2018-04-22T01:34:45.743' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (2011, N'Add Cheque', N'Added new cheque: Steven Tomas  Bruce Banner', N'', 1, CAST(N'2018-04-22T02:05:23.393' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (2012, N'Add Cheque', N'Added new cheque: Steven Tomas 2  Iron man', N'', 1, CAST(N'2018-04-22T02:47:04.040' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3010, N'Add Client', N'Added client: Lam, Rachelle', N'', 1, CAST(N'2018-04-24T11:47:56.970' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3011, N'Add Stock', N'Added new stock: Baby Pink', N'', 1, CAST(N'2018-04-24T11:53:41.147' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3012, N'Add Stock', N'Added new stock: Gold', N'', 1, CAST(N'2018-04-24T11:53:49.710' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3013, N'Add Stock', N'Added new stock: Red', N'', 1, CAST(N'2018-04-24T11:53:57.133' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3014, N'Add Stock', N'Added new stock: Blue', N'', 1, CAST(N'2018-04-24T11:54:07.120' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3015, N'Add Stock', N'Added new stock: Apple Green', N'', 1, CAST(N'2018-04-24T11:54:15.167' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3016, N'Add Stock', N'Added new stock: Aqua Blue', N'', 1, CAST(N'2018-04-24T11:54:23.050' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (3017, N'Add Booking', N'Added new booking: Lam, Rachelle - Valle Verde 3 Clubhouse  - 08/04/2018 11:00:00 AM', N'', 1, CAST(N'2018-04-24T12:02:15.617' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (4010, N'Add Booking', N'Added new booking: Tomas, Steven - Marikina City - 28/04/2018 3:00:00 PM', N'', 1, CAST(N'2018-04-28T22:27:04.603' AS DateTime))
INSERT [dbo].[Logs] ([LogID], [LogTitle], [LogContent], [LogType], [UserID], [LogDate]) VALUES (4011, N'Add Cheque', N'Added new cheque: Steven Tomas 0045899754512 Microsoft', N'', 1, CAST(N'2018-04-30T01:02:08.223' AS DateTime))
SET IDENTITY_INSERT [dbo].[Logs] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1, N'Egg', N'Adult', 4, 1, CAST(N'2018-04-17T02:42:05.277' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (2, N'Chicken', N'Adult', 4, 1, CAST(N'2018-04-17T02:43:07.483' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (3, N'Rice', N'Adult', 4, 1, CAST(N'2018-04-17T02:43:12.630' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (4, N'Spaghetti', N'Kid', 4, 1, CAST(N'2018-04-17T02:43:16.747' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (6, N'Iced Cream', N'Kid', 4, 1, CAST(N'2018-04-17T02:43:23.407' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (7, N'Iced Cream', N'Kid', 4, 1, CAST(N'2018-04-17T02:43:26.707' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (8, N'Chicken', N'Adult', 9, 1, CAST(N'2018-04-18T02:28:13.777' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (9, N'Spaghetti', N'Kid', 9, 1, CAST(N'2018-04-18T02:28:19.007' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (10, N'Chicken', N'Adult', 10, 1, CAST(N'2018-04-18T02:42:45.120' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (11, N'Chicken', N'Adult', NULL, 1, CAST(N'2018-04-19T02:07:25.117' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (12, N'Chicken', N'Adult', NULL, 1, CAST(N'2018-04-19T02:07:31.410' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (14, N'Jobee', N'Adult', NULL, 1, CAST(N'2018-04-19T02:11:30.550' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (15, N'Coke', N'Adult', NULL, 1, CAST(N'2018-04-19T02:11:34.573' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (16, N'Chicken', N'Adult', 11, 1, CAST(N'2018-04-19T02:17:14.830' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (17, N'RH', N'Adult', 11, 1, CAST(N'2018-04-19T02:17:16.930' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (18, N'Beer', N'Adult', 11, 1, CAST(N'2018-04-19T02:17:18.840' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (39, N'1', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:47.330' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (40, N'2', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:48.017' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (41, N'3', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:48.710' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (42, N'4', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:49.410' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (43, N'5', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:50.273' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (44, N'6', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:51.293' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (45, N'7', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:52.160' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (46, N'8', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:55.570' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (47, N'9', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:56.763' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (48, N'10', N'Adult', 12, 1, CAST(N'2018-04-23T20:32:58.447' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (49, N'1', N'Kid', 12, 1, CAST(N'2018-04-23T20:32:59.867' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (50, N'2', N'Kid', 12, 1, CAST(N'2018-04-23T20:33:00.730' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (51, N'3', N'Kid', 12, 1, CAST(N'2018-04-23T20:33:01.567' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (52, N'4', N'Kid', 12, 1, CAST(N'2018-04-23T20:33:02.407' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (53, N'5', N'Kid', 12, 1, CAST(N'2018-04-23T20:33:03.293' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (54, N'1. Shanghai Fried rice', N'Adult', 14, 1, CAST(N'2018-04-24T11:48:17.647' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (55, N'2. Oven Baked Salmon', N'Adult', 14, 1, CAST(N'2018-04-24T11:48:24.250' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (56, N'3. Baby Back Ribs', N'Adult', 14, 1, CAST(N'2018-04-24T11:48:32.153' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (57, N'4. Beef Salpicao (COS)', N'Adult', 14, 1, CAST(N'2018-04-24T11:48:44.410' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (58, N'5. Boneless Chicken Teriyaki', N'Adult', 14, 1, CAST(N'2018-04-24T11:49:01.233' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (59, N'6. Brocolli with 2 kinds of Mushroom', N'Adult', 14, 1, CAST(N'2018-04-24T11:49:14.773' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (60, N'7. Prawn Tempura (COS)', N'Adult', 14, 1, CAST(N'2018-04-24T11:49:38.410' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (62, N'8. Chinese Cha Miswa Guisado', N'Adult', 14, 1, CAST(N'2018-04-24T11:50:18.513' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (63, N'9. Buco and Pandan Salad', N'Adult', 14, 1, CAST(N'2018-04-24T11:50:29.010' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (64, N'10. Brownies', N'Adult', 14, 1, CAST(N'2018-04-24T11:50:37.577' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (65, N'11. Soda', N'Adult', 14, 1, CAST(N'2018-04-24T11:50:42.230' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (66, N'1. Spaghetti with Meatsauce', N'Kid', 14, 1, CAST(N'2018-04-24T11:51:10.900' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (67, N'2. Chicken lollipops', N'Kid', 14, 1, CAST(N'2018-04-24T11:51:18.077' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (68, N'3. Hotdog with Mallows (1stick)', N'Kid', 14, 1, CAST(N'2018-04-24T11:51:29.810' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (69, N'4. Brownies', N'Kid', 14, 1, CAST(N'2018-04-24T11:51:35.367' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (70, N'5. Iced Tea', N'Kid', 14, 1, CAST(N'2018-04-24T11:51:40.247' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1054, N'Chicken', N'Adult', 15, 1, CAST(N'2018-04-28T22:09:54.357' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1055, N'Beef', N'Kid', 15, 1, CAST(N'2018-04-28T22:09:57.667' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1056, N'Pork', N'Kid', 15, 1, CAST(N'2018-04-28T22:10:01.187' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1057, N'Rice', N'Kid', 15, 1, CAST(N'2018-04-28T22:10:03.893' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1058, N'Fish', N'Adult', 15, 1, CAST(N'2018-04-28T22:10:07.740' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1059, N'Water', N'Adult', 15, 1, CAST(N'2018-04-28T22:10:09.253' AS DateTime))
INSERT [dbo].[Menu] ([MenuID], [MenuName], [Guest], [BookingDetailsID], [UserID], [DateAdded]) VALUES (1060, N'Rice', N'Adult', 15, 1, CAST(N'2018-04-28T22:10:11.080' AS DateTime))
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[OtherDetails] ON 

INSERT [dbo].[OtherDetails] ([OtherDetailsID], [BookingDetailsID], [Stylist], [Host], [Planner], [Media], [DateAdded]) VALUES (2, 9, N'None', N'None', N'None', N'None', CAST(N'2018-04-18T02:37:32.467' AS DateTime))
INSERT [dbo].[OtherDetails] ([OtherDetailsID], [BookingDetailsID], [Stylist], [Host], [Planner], [Media], [DateAdded]) VALUES (3, 10, N'None', N'None', N'None', N'None', CAST(N'2018-04-18T02:42:59.703' AS DateTime))
INSERT [dbo].[OtherDetails] ([OtherDetailsID], [BookingDetailsID], [Stylist], [Host], [Planner], [Media], [DateAdded]) VALUES (4, 12, N'', N'', N'', N'', CAST(N'2018-04-19T22:01:05.983' AS DateTime))
INSERT [dbo].[OtherDetails] ([OtherDetailsID], [BookingDetailsID], [Stylist], [Host], [Planner], [Media], [DateAdded]) VALUES (6, 14, N'Willa Lao (9178381336)', N'Willa Lao (9178381336)', N'Willa Lao (9178381336)', N'Willa Lao (9178381336)', CAST(N'2018-04-24T12:02:13.353' AS DateTime))
INSERT [dbo].[OtherDetails] ([OtherDetailsID], [BookingDetailsID], [Stylist], [Host], [Planner], [Media], [DateAdded]) VALUES (1005, 15, N'', N'', N'', N'', CAST(N'2018-04-28T22:27:04.540' AS DateTime))
SET IDENTITY_INSERT [dbo].[OtherDetails] OFF
SET IDENTITY_INSERT [dbo].[Payments] ON 

INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (1, CAST(50000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(1000.00 AS Decimal(18, 2)), CAST(25000.00 AS Decimal(18, 2)), NULL, CAST(31000.00 AS Decimal(18, 2)), CAST(56000.00 AS Decimal(18, 2)), NULL, N'Paid', 16, CAST(N'2018-04-18T02:37:32.477' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (2, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, N'Pending', 17, CAST(N'2018-04-18T02:42:59.723' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (3, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), NULL, N'Pending', 18, CAST(N'2018-04-19T02:09:16.267' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (4, CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, CAST(10000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), NULL, N'Pending', 19, CAST(N'2018-04-19T02:11:36.403' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (5, CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), NULL, CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), NULL, CAST(15000.00 AS Decimal(18, 2)), CAST(15000.00 AS Decimal(18, 2)), NULL, N'Paid', 20, CAST(N'2018-04-19T02:17:23.473' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (6, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), NULL, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), NULL, CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), NULL, N'Pending', 21, CAST(N'2018-04-19T22:01:05.993' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (8, CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'', CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'', CAST(5000.00 AS Decimal(18, 2)), CAST(5000.00 AS Decimal(18, 2)), N'Yes', N'Pending', 24, CAST(N'2018-04-24T12:02:13.557' AS DateTime))
INSERT [dbo].[Payments] ([PaymentID], [BasicFee], [MiscFee], [MiscDesc], [OtherFee], [DownPayment], [PaymentMethod], [Balance], [Total], [VAT], [Status], [BookingID], [DateAdded]) VALUES (9, CAST(5000.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'Something Fee', CAST(2500.00 AS Decimal(18, 2)), CAST(10000.00 AS Decimal(18, 2)), N'Bank deposit', CAST(9600.00 AS Decimal(18, 2)), CAST(19600.00 AS Decimal(18, 2)), N'Yes', N'Pending', 1022, CAST(N'2018-04-28T22:27:04.550' AS DateTime))
SET IDENTITY_INSERT [dbo].[Payments] OFF
SET IDENTITY_INSERT [dbo].[Scheduler] ON 

INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (9, 0, CAST(N'2018-04-19T07:00:00' AS SmallDateTime), CAST(N'2018-04-19T10:00:00' AS SmallDateTime), 0, N'Steven Tomas', N'Marikina City', CAST(N'2018-04-19T07:00:00' AS SmallDateTime), CAST(N'2018-04-19T10:00:00' AS SmallDateTime), N'w/ Lechon', 2, 0, NULL, NULL, NULL, NULL, NULL, N'Singapore Standard Time')
INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (10, 0, CAST(N'2018-04-24T07:54:00' AS SmallDateTime), CAST(N'2018-04-24T10:54:00' AS SmallDateTime), 0, N'Steven Tomas', N'Marikina City', CAST(N'2018-04-24T07:54:00' AS SmallDateTime), CAST(N'2018-04-24T10:54:00' AS SmallDateTime), N'Test', 2, 0, NULL, NULL, NULL, NULL, NULL, N'Singapore Standard Time')
INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (11, 0, CAST(N'2018-04-23T19:00:00' AS SmallDateTime), CAST(N'2018-04-23T22:00:00' AS SmallDateTime), 0, N'Steven Tomas', N'Marikina City', CAST(N'2018-04-23T19:00:00' AS SmallDateTime), CAST(N'2018-04-23T22:00:00' AS SmallDateTime), N'Something', 2, 0, NULL, NULL, NULL, NULL, NULL, N'Singapore Standard Time')
INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (12, 0, CAST(N'2018-05-01T15:00:00' AS SmallDateTime), CAST(N'2018-05-01T18:00:00' AS SmallDateTime), 0, N' ', N'', CAST(N'2018-05-01T15:00:00' AS SmallDateTime), CAST(N'2018-05-01T18:00:00' AS SmallDateTime), N'Nothing', 2, 0, NULL, NULL, NULL, NULL, N'21', N'Singapore Standard Time')
INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (13, 0, CAST(N'2018-04-08T11:00:00' AS SmallDateTime), CAST(N'2018-04-08T14:00:00' AS SmallDateTime), 0, N'Rachelle Lam', N'Valle Verde 3 Clubhouse ', CAST(N'2018-04-08T11:00:00' AS SmallDateTime), CAST(N'2018-04-08T14:00:00' AS SmallDateTime), N'Client will have lechon, cake table, gift, prize, loot bag, client will provide table number', 2, 0, NULL, NULL, NULL, NULL, N'24', N'Singapore Standard Time')
INSERT [dbo].[Scheduler] ([SchedulerID], [Type], [StartDate], [EndDate], [AllDay], [Subject], [Location], [OriginalOccurrenceStart], [OriginalOccurrenceEnd], [Description], [Status], [Label], [ResourceID], [ResourceIDs], [ReminderInfo], [RecurrenceInfo], [CustomField], [TimeZoneId]) VALUES (1013, 0, CAST(N'2018-04-28T15:00:00' AS SmallDateTime), CAST(N'2018-04-28T18:00:00' AS SmallDateTime), 0, N'Steven Tomas', N'Marikina City', CAST(N'2018-04-28T15:00:00' AS SmallDateTime), CAST(N'2018-04-28T18:00:00' AS SmallDateTime), N'with lechon', 2, 0, NULL, NULL, NULL, NULL, N'1022', N'Singapore Standard Time')
SET IDENTITY_INSERT [dbo].[Scheduler] OFF
SET IDENTITY_INSERT [dbo].[Stocks] ON 

INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (1, N'1', N'Yellow', N'', CAST(100 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-14T18:35:02.273' AS DateTime), CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (2, N'1', N'Green', N'', CAST(90 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-20T14:54:00.007' AS DateTime), CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (3, N'1', N'Blue', N'', CAST(100 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-18T02:17:22.913' AS DateTime), CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (4, N'1', N'Blue', N'', CAST(100 AS Decimal(18, 0)), N'Inactive', CAST(N'2018-04-18T02:15:26.157' AS DateTime), CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (5, N'1', N'White', N'', CAST(100 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-19T22:01:05.950' AS DateTime), CAST(N'2018-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (6, N'1', N'Red', N'with stains', CAST(100 AS Decimal(18, 0)), N'Inactive', CAST(N'2018-04-18T02:15:17.973' AS DateTime), CAST(N'2018-04-12T22:09:29.883' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (7, N'1', N'Red', N'dirty', CAST(92 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-28T22:27:04.493' AS DateTime), CAST(N'2018-04-14T18:25:58.670' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (9, N'4', N'Baby Pink', N'', CAST(96 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-24T12:06:36.097' AS DateTime), CAST(N'2018-04-24T11:53:41.090' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (10, N'4', N'Gold', N'', CAST(96 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-24T12:06:36.103' AS DateTime), CAST(N'2018-04-24T11:53:49.687' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (11, N'4', N'Red', N'', CAST(94 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-28T22:27:04.523' AS DateTime), CAST(N'2018-04-24T11:53:57.107' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (12, N'4', N'Blue', N'', CAST(96 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-24T12:06:36.137' AS DateTime), CAST(N'2018-04-24T11:54:07.093' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (13, N'4', N'Apple Green', N'', CAST(94 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-28T22:27:04.517' AS DateTime), CAST(N'2018-04-24T11:54:15.143' AS DateTime))
INSERT [dbo].[Stocks] ([StockID], [StockTypeID], [StockName], [StockDescription], [Qty], [Status], [DateModified], [DateAdded]) VALUES (14, N'4', N'Aqua Blue', N'', CAST(96 AS Decimal(18, 0)), N'Active', CAST(N'2018-04-24T12:06:36.177' AS DateTime), CAST(N'2018-04-24T11:54:23.017' AS DateTime))
SET IDENTITY_INSERT [dbo].[Stocks] OFF
SET IDENTITY_INSERT [dbo].[StockType] ON 

INSERT [dbo].[StockType] ([StockTypeID], [StockTypeName], [Status], [DateAdded]) VALUES (1, N'10 Seater Recta', N'Active', CAST(N'2018-04-12T21:01:52.483' AS DateTime))
INSERT [dbo].[StockType] ([StockTypeID], [StockTypeName], [Status], [DateAdded]) VALUES (2, N'8 Seater Recta', N'Active', CAST(N'2018-04-12T21:01:52.483' AS DateTime))
INSERT [dbo].[StockType] ([StockTypeID], [StockTypeName], [Status], [DateAdded]) VALUES (3, N'10 Seater Topper', N'Active', CAST(N'2018-04-12T21:01:52.483' AS DateTime))
INSERT [dbo].[StockType] ([StockTypeID], [StockTypeName], [Status], [DateAdded]) VALUES (4, N'10 Seater Round', N'Active', CAST(N'2018-04-12T21:01:52.483' AS DateTime))
INSERT [dbo].[StockType] ([StockTypeID], [StockTypeName], [Status], [DateAdded]) VALUES (5, N'Test', N'Inactive', CAST(N'2018-04-12T21:01:52.483' AS DateTime))
SET IDENTITY_INSERT [dbo].[StockType] OFF
SET IDENTITY_INSERT [dbo].[Suppliers] ON 

INSERT [dbo].[Suppliers] ([SupplierID], [SupplierName], [ContactNo], [Address], [ContactPerson], [Status], [DateAdded]) VALUES (1, N'Microsoft', N'09784512247', N'Quezon City', N'Bill Gates', N'Active', CAST(N'2018-04-20T12:20:00.253' AS DateTime))
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Password], [UserName], [TypeID], [Status], [DateAdded]) VALUES (1, N'Robert Steven', N'Tomas', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'steven', 1, N'Active', CAST(N'2018-03-28T00:00:00.000' AS DateTime))
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Password], [UserName], [TypeID], [Status], [DateAdded]) VALUES (2, N'Tony', N'Stark', N'1ARVn2Auq2/WAqx2gNrL+q3RNjAzXpUfCXrzkA6d4Xa22yhRLy4AC50E+6UTPoscbo31nbOoq51gvkuXzJ6B2w==', N'ironman', 2, N'Active', CAST(N'2018-04-12T16:25:02.403' AS DateTime))
SET IDENTITY_INSERT [dbo].[Users] OFF
SET IDENTITY_INSERT [dbo].[UserTypes] ON 

INSERT [dbo].[UserTypes] ([TypeID], [UserType]) VALUES (1, N'Admin A')
INSERT [dbo].[UserTypes] ([TypeID], [UserType]) VALUES (2, N'Admin B')
SET IDENTITY_INSERT [dbo].[UserTypes] OFF
USE [master]
GO
ALTER DATABASE [Catering] SET  READ_WRITE 
GO
