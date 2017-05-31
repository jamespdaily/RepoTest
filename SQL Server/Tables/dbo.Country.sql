SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country] (
		[CountryId]            [int] IDENTITY(1, 1) NOT NULL,
		[Continent]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CountryCode]          [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Country]              [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FreeFormLocation]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsHVEC]               [bit] NULL,
		CONSTRAINT [PK8]
		PRIMARY KEY
		NONCLUSTERED
		([CountryId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country] SET (LOCK_ESCALATION = TABLE)
GO
