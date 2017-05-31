SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ProjectClientTheme] (
		[ProjectClientThemeId]     [int] IDENTITY(1, 1) NOT NULL,
		[ProjectId]                [int] NOT NULL,
		[ClientId]                 [int] NOT NULL,
		[ShellThemeId]             [int] NOT NULL,
		CONSTRAINT [Pk_ProjectClientTheme]
		PRIMARY KEY
		CLUSTERED
		([ProjectClientThemeId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProjectClientTheme]
	WITH CHECK
	ADD CONSTRAINT [fk_ProjectClientTheme]
	FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
ALTER TABLE [dbo].[ProjectClientTheme]
	CHECK CONSTRAINT [fk_ProjectClientTheme]

GO
ALTER TABLE [dbo].[ProjectClientTheme]
	WITH CHECK
	ADD CONSTRAINT [fk_ProjectClientTheme_0]
	FOREIGN KEY ([ClientId]) REFERENCES [dbo].[Client] ([ClientId])
ALTER TABLE [dbo].[ProjectClientTheme]
	CHECK CONSTRAINT [fk_ProjectClientTheme_0]

GO
ALTER TABLE [dbo].[ProjectClientTheme]
	WITH CHECK
	ADD CONSTRAINT [fk_ProjectClientTheme_1]
	FOREIGN KEY ([ShellThemeId]) REFERENCES [dbo].[ShellTheme] ([ShellThemeId])
ALTER TABLE [dbo].[ProjectClientTheme]
	CHECK CONSTRAINT [fk_ProjectClientTheme_1]

GO
CREATE NONCLUSTERED INDEX [idx_ProjectClientTheme]
	ON [dbo].[ProjectClientTheme] ([ProjectId])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ProjectClientTheme_0]
	ON [dbo].[ProjectClientTheme] ([ClientId])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ProjectClientTheme_1]
	ON [dbo].[ProjectClientTheme] ([ShellThemeId])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProjectClientTheme] SET (LOCK_ESCALATION = TABLE)
GO
