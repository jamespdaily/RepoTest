SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person] (
		[PersonId]     [int] IDENTITY(1, 1) NOT NULL,
		[FullName]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK39]
		PRIMARY KEY
		NONCLUSTERED
		([PersonId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Person] SET (LOCK_ESCALATION = TABLE)
GO
