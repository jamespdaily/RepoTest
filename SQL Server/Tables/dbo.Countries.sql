SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Countries] (
		[CountryId]            [int] IDENTITY(1, 1) NOT NULL,
		[CountryCode]          [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[ContinentName]        [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[CountryName]          [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[City]                 [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[State]                [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[FreeFormLocation]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[IsHVEC]               [bit] NOT NULL,
		CONSTRAINT [PK_Countries]
		PRIMARY KEY
		NONCLUSTERED
		([CountryId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Countries] SET (LOCK_ESCALATION = TABLE)
GO
