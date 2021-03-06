SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AwardStatus] (
		[AwardStatusId]     [int] IDENTITY(1, 1) NOT NULL,
		[AwardStatus]       [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK19]
		PRIMARY KEY
		NONCLUSTERED
		([AwardStatusId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AwardStatus] SET (LOCK_ESCALATION = TABLE)
GO
