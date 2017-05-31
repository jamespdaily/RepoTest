SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Forms] (
		[FormID]       [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[FormName]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK36]
		PRIMARY KEY
		NONCLUSTERED
		([FormID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Forms] SET (LOCK_ESCALATION = TABLE)
GO