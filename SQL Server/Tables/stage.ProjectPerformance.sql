SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[ProjectPerformance] (
		[Date]                      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProjectName]               [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SupplierName]              [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ContractValueRange]        [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SafetyScore]               [int] NULL,
		[SafetyComment]             [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CostScore]                 [int] NULL,
		[CostComment]               [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ScheduleScore]             [int] NULL,
		[ScheduleComment]           [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[QualityScore]              [int] NULL,
		[QualityComment]            [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResponsivenessScore]       [int] NULL,
		[ResponsivenessComment]     [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[InnovationScore]           [int] NULL,
		[InnovationComment]         [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProjectComment]            [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ShellPM]                   [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ShellCPFocalPoint]         [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ASContractorManager]       [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DateLoaded]                [datetime] NULL,
		[SourceFile]                [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [stage].[ProjectPerformance] SET (LOCK_ESCALATION = TABLE)
GO
