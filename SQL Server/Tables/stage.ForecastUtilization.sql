SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[ForecastUtilization] (
		[SupplierName]            [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Date]                    [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ClientName]              [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProjectName]             [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Country]                 [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]                    [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ShellTheme]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Scope]                   [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AwardStatus]             [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[TotalEstimatedHours]     [decimal](18, 2) NULL,
		[HVECHours]               [decimal](18, 2) NULL,
		[EFAProject]              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DateLoaded]              [datetime] NULL,
		[SourceFile]              [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [stage].[ForecastUtilization] SET (LOCK_ESCALATION = TABLE)
GO
