SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[DetailedUtilization] (
		[SupplierName]                      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Date]                              [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ClientName]                        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Country]                           [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[City]                              [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProjectName]                       [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AwardValue]                        [decimal](18, 2) NULL,
		[Scope]                             [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[AwardDate]                         [date] NULL,
		[ShellTheme]                        [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CompletionDate]                    [date] NULL,
		[HoursExecuted]                     [decimal](18, 2) NULL,
		[CostAssociatedWithActualHours]     [decimal](18, 2) NULL,
		[Remark]                            [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DateLoaded]                        [datetime] NULL,
		[SourceFile]                        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [stage].[DetailedUtilization] SET (LOCK_ESCALATION = TABLE)
GO
