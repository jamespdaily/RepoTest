SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubmissionDate] (
		[DateId]          [int] IDENTITY(1, 1) NOT NULL,
		[Year]            [int] NULL,
		[Quarter]         [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[YearQuarter]     [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[StartDate]       [date] NULL,
		CONSTRAINT [PK35]
		PRIMARY KEY
		NONCLUSTERED
		([DateId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SubmissionDate] SET (LOCK_ESCALATION = TABLE)
GO
