SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectEvaluation] (
		[ProjectEvaluationId]       [int] IDENTITY(1, 1) NOT NULL,
		[DateId]                    [int] NULL,
		[ProjectId]                 [int] NULL,
		[ContractValueRange]        [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
		[ShellPM]                   [int] NULL,
		[ShellCPFocalPoint]         [int] NULL,
		[ASContractorManager]       [int] NULL,
		[ProjectComment]            [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[LastModifiedDate]          [date] NULL,
		[SubmitDate]                [date] NULL,
		CONSTRAINT [PK8_1]
		PRIMARY KEY
		NONCLUSTERED
		([ProjectEvaluationId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProjectEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefPerson109]
	FOREIGN KEY ([ASContractorManager]) REFERENCES [dbo].[Person] ([PersonId])
ALTER TABLE [dbo].[ProjectEvaluation]
	CHECK CONSTRAINT [RefPerson109]

GO
ALTER TABLE [dbo].[ProjectEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefPerson110]
	FOREIGN KEY ([ShellPM]) REFERENCES [dbo].[Person] ([PersonId])
ALTER TABLE [dbo].[ProjectEvaluation]
	CHECK CONSTRAINT [RefPerson110]

GO
ALTER TABLE [dbo].[ProjectEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefPerson111]
	FOREIGN KEY ([ShellCPFocalPoint]) REFERENCES [dbo].[Person] ([PersonId])
ALTER TABLE [dbo].[ProjectEvaluation]
	CHECK CONSTRAINT [RefPerson111]

GO
ALTER TABLE [dbo].[ProjectEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefProject63]
	FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
ALTER TABLE [dbo].[ProjectEvaluation]
	CHECK CONSTRAINT [RefProject63]

GO
ALTER TABLE [dbo].[ProjectEvaluation]
	WITH CHECK
	ADD CONSTRAINT [RefSubmissionDate87]
	FOREIGN KEY ([DateId]) REFERENCES [dbo].[SubmissionDate] ([DateId])
ALTER TABLE [dbo].[ProjectEvaluation]
	CHECK CONSTRAINT [RefSubmissionDate87]

GO
ALTER TABLE [dbo].[ProjectEvaluation] SET (LOCK_ESCALATION = TABLE)
GO
