SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[EngineeringProductivity] (
		[EngineeringProductivityId]           [int] IDENTITY(1, 1) NOT NULL,
		[DateId]                              [int] NOT NULL,
		[ProjectClientThemeId]                [int] NOT NULL,
		[LastModifiedDate]                    [date] NULL,
		[SubmitDate]                          [date] NULL,
		[EngineeringHoursPieceEquipment]      [decimal](18, 2) NULL,
		[ProcessHoursUniquePiece]             [decimal](18, 2) NULL,
		[MechanicalHoursIsometricDrawing]     [decimal](18, 2) NULL,
		[PipinghoursTonneOfPiping]            [decimal](18, 2) NULL,
		[PipingHoursLinearMetere]             [decimal](10, 2) NULL,
		[RevisionsIsometricDrawing]           [decimal](10, 2) NULL,
		[CivilHoursConcreteCubicMeter]        [decimal](10, 2) NULL,
		[CivilHoursTonneSteel]                [decimal](18, 2) NULL,
		[ElectricalHoursConsumer]             [decimal](18, 2) NULL,
		[ElectricalHoursInstalledKW]          [decimal](18, 2) NULL,
		[InstrumentHoursIO]                   [decimal](18, 2) NULL,
		[ProcurementHoursUniquePiece]         [decimal](18, 2) NULL,
		CONSTRAINT [PK3_1]
		PRIMARY KEY
		NONCLUSTERED
		([EngineeringProductivityId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EngineeringProductivity]
	WITH CHECK
	ADD CONSTRAINT [RefProject64]
	FOREIGN KEY ([ProjectClientThemeId]) REFERENCES [dbo].[ProjectClientTheme] ([ProjectClientThemeId])
ALTER TABLE [dbo].[EngineeringProductivity]
	CHECK CONSTRAINT [RefProject64]

GO
ALTER TABLE [dbo].[EngineeringProductivity]
	WITH CHECK
	ADD CONSTRAINT [RefSubmissionDate85]
	FOREIGN KEY ([DateId]) REFERENCES [dbo].[SubmissionDate] ([DateId])
ALTER TABLE [dbo].[EngineeringProductivity]
	CHECK CONSTRAINT [RefSubmissionDate85]

GO
ALTER TABLE [dbo].[EngineeringProductivity] SET (LOCK_ESCALATION = TABLE)
GO
