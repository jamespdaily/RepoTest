SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[lookup_EngineeringProductivity] (
		[ProductivityThresholdID]             [int] IDENTITY(1, 1) NOT NULL,
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
		[ProcurementHoursUniquePiece]         [decimal](18, 2) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lookup_EngineeringProductivity] SET (LOCK_ESCALATION = TABLE)
GO
