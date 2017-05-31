SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DetailedUtilization] (
		[DetailiedUtilizationId]            [int] IDENTITY(1, 1) NOT NULL,
		[DateId]                            [int] NOT NULL,
		[ScopeId]                           [int] NOT NULL,
		[CountryCityId]                     [int] NOT NULL,
		[ProjectClientThemeId]              [int] NOT NULL,
		[LastModifiedDate]                  [date] NULL,
		[SubmitDate]                        [date] NULL,
		[AwardValue]                        [decimal](18, 2) NULL,
		[Hours]                             [decimal](18, 2) NULL,
		[CostAssociatedWithActualHours]     [decimal](18, 2) NULL,
		[Remark]                            [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AwardDate]                         [date] NULL,
		[CompletionDate]                    [date] NULL,
		[StatusId]                          [int] NULL,
		CONSTRAINT [PK10]
		PRIMARY KEY
		NONCLUSTERED
		([DetailiedUtilizationId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetailedUtilization]
	WITH CHECK
	ADD CONSTRAINT [fk_DetailedUtilization]
	FOREIGN KEY ([ProjectClientThemeId]) REFERENCES [dbo].[ProjectClientTheme] ([ProjectClientThemeId])
ALTER TABLE [dbo].[DetailedUtilization]
	CHECK CONSTRAINT [fk_DetailedUtilization]

GO
ALTER TABLE [dbo].[DetailedUtilization]
	WITH CHECK
	ADD CONSTRAINT [fk_DetailedUtilization_0]
	FOREIGN KEY ([CountryCityId]) REFERENCES [dbo].[CountryCity] ([CountryCityId])
ALTER TABLE [dbo].[DetailedUtilization]
	CHECK CONSTRAINT [fk_DetailedUtilization_0]

GO
ALTER TABLE [dbo].[DetailedUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefScope93]
	FOREIGN KEY ([ScopeId]) REFERENCES [dbo].[Scope] ([ScopeId])
ALTER TABLE [dbo].[DetailedUtilization]
	CHECK CONSTRAINT [RefScope93]

GO
ALTER TABLE [dbo].[DetailedUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefStatus38]
	FOREIGN KEY ([StatusId]) REFERENCES [dbo].[Status] ([StatusId])
ALTER TABLE [dbo].[DetailedUtilization]
	CHECK CONSTRAINT [RefStatus38]

GO
ALTER TABLE [dbo].[DetailedUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefSubmissionDate86]
	FOREIGN KEY ([DateId]) REFERENCES [dbo].[SubmissionDate] ([DateId])
ALTER TABLE [dbo].[DetailedUtilization]
	CHECK CONSTRAINT [RefSubmissionDate86]

GO
CREATE NONCLUSTERED INDEX [idx_DetailedUtilization]
	ON [dbo].[DetailedUtilization] ([ProjectClientThemeId])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_DetailedUtilization_0]
	ON [dbo].[DetailedUtilization] ([CountryCityId])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[DetailedUtilization] SET (LOCK_ESCALATION = TABLE)
GO
