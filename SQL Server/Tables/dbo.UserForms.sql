SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserForms] (
		[UserFormsId]     [int] IDENTITY(1, 1) NOT NULL,
		[FormID]          [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[UserId]          [int] NOT NULL,
		CONSTRAINT [PK37]
		PRIMARY KEY
		NONCLUSTERED
		([UserFormsId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UserForms]
	WITH CHECK
	ADD CONSTRAINT [RefForms98]
	FOREIGN KEY ([FormID]) REFERENCES [dbo].[Forms] ([FormID])
ALTER TABLE [dbo].[UserForms]
	CHECK CONSTRAINT [RefForms98]

GO
ALTER TABLE [dbo].[UserForms]
	WITH CHECK
	ADD CONSTRAINT [RefUsers97]
	FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
ALTER TABLE [dbo].[UserForms]
	CHECK CONSTRAINT [RefUsers97]

GO
ALTER TABLE [dbo].[UserForms] SET (LOCK_ESCALATION = TABLE)
GO
