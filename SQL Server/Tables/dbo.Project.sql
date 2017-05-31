SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Project] (
		[ProjectId]       [int] IDENTITY(1, 1) NOT NULL,
		[ProjectName]     [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Active]          [int] NULL,
		CONSTRAINT [PK4]
		PRIMARY KEY
		NONCLUSTERED
		([ProjectId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Project] SET (LOCK_ESCALATION = TABLE)
GO
