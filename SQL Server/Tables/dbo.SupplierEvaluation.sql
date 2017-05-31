SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SupplierEvaluation] (
		[SupplierEvaluationId]      [int] IDENTITY(1, 1) NOT NULL,
		[SupplierId]                [int] NOT NULL,
		[DateId]                    [int] NOT NULL,
		[SafetyScore]               [decimal](18, 2) NULL,
		[SafetyComment]             [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[CostScore]                 [decimal](18, 2) NULL,
		[CostComment]               [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ScheduleScore]             [decimal](18, 2) NULL,
		[ScheduleComment]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[QualityScore]              [decimal](18, 2) NULL,
		[QualityComment]            [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ResponsivenessScore]       [decimal](18, 2) NULL,
		[ResponsivenessComment]     [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[InnovationScore]           [decimal](18, 2) NULL,
		[InnovationComment]         [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SupplierComment]           [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LastModifiedDate]          [date] NULL,
		[SubmitDate]                [date] NULL,
		CONSTRAINT [PK8_1_1]
		PRIMARY KEY
		NONCLUSTERED
		([SupplierEvaluationId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefSubmissionDate113]
	FOREIGN KEY ([DateId]) REFERENCES [dbo].[SubmissionDate] ([DateId])
ALTER TABLE [dbo].[SupplierEvaluation]
	CHECK CONSTRAINT [RefSubmissionDate113]

GO
ALTER TABLE [dbo].[SupplierEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefSupplier112]
	FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Supplier] ([SupplierId])
ALTER TABLE [dbo].[SupplierEvaluation]
	CHECK CONSTRAINT [RefSupplier112]

GO
ALTER TABLE [dbo].[SupplierEvaluation] SET (LOCK_ESCALATION = TABLE)
GO
