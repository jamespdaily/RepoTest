SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[ForecastUtilization] (
		[ForecastUtilizationId]     [int] IDENTITY(1, 1) NOT NULL,
		[ProjectClientThemeId]      [int] NOT NULL,
		[CountryCityId]             [int] NOT NULL,
		[ScopeId]                   [int] NOT NULL,
		[DateId]                    [int] NOT NULL,
		[AwardStatusId]             [int] NOT NULL,
		[LastModifiedDate]          [date] NULL,
		[SubmitDate]                [date] NULL,
		[Hours]                     [decimal](18, 2) NULL,
		[StatusId]                  [int] NULL,
		[EFAProject]                [int] NULL,
		CONSTRAINT [PK18]
		PRIMARY KEY
		NONCLUSTERED
		([ForecastUtilizationId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [fk_ForecastUtilization]
	FOREIGN KEY ([ProjectClientThemeId]) REFERENCES [dbo].[ProjectClientTheme] ([ProjectClientThemeId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [fk_ForecastUtilization]

GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [fk_ForecastUtilization_0]
	FOREIGN KEY ([CountryCityId]) REFERENCES [dbo].[CountryCity] ([CountryCityId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [fk_ForecastUtilization_0]

GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefAwardStatus35]
	FOREIGN KEY ([AwardStatusId]) REFERENCES [dbo].[AwardStatus] ([AwardStatusId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [RefAwardStatus35]

GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefScope92]
	FOREIGN KEY ([ScopeId]) REFERENCES [dbo].[Scope] ([ScopeId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [RefScope92]

GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefStatus37]
	FOREIGN KEY ([StatusId]) REFERENCES [dbo].[Status] ([StatusId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [RefStatus37]

GO
ALTER TABLE [dbo].[ForecastUtilization]
	WITH CHECK
	ADD CONSTRAINT [RefSubmissionDate84]
	FOREIGN KEY ([DateId]) REFERENCES [dbo].[SubmissionDate] ([DateId])
ALTER TABLE [dbo].[ForecastUtilization]
	CHECK CONSTRAINT [RefSubmissionDate84]

GO
CREATE NONCLUSTERED INDEX [idx_ForecastUtilization]
	ON [dbo].[ForecastUtilization] ([ProjectClientThemeId])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [idx_ForecastUtilization_0]
	ON [dbo].[ForecastUtilization] ([CountryCityId])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[ForecastUtilization] SET (LOCK_ESCALATION = TABLE)
GO
