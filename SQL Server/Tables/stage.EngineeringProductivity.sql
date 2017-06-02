SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[EngineeringProductivity] (
		[Date]                                [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SupplierName]                        [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ProjectName]                         [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ClientName]                          [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[ShellTheme]                          [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[EngineeringHoursPieceEquipment]      [decimal](10, 2) NULL,
		[ProcessHoursUniquePiece]             [decimal](10, 2) NULL,
		[MechanicalHoursIsometricDrawing]     [decimal](10, 2) NULL,
		[PipinghoursTonneOfPiping]            [decimal](10, 2) NULL,
		[PipingHoursLinearMetere]             [decimal](10, 2) NULL,
		[RevisionsIsometricDrawing]           [decimal](10, 2) NULL,
		[CivilHoursConcreteCubicMeter]        [decimal](10, 2) NULL,
		[CivilHoursTonneSteel]                [decimal](10, 2) NULL,
		[ElectricalHoursConsumer]             [decimal](10, 2) NULL,
		[ElectricalHoursInstalledKW]          [decimal](10, 2) NULL,
		[InstrumentHoursIO]                   [decimal](10, 2) NULL,
		[ProcurementHoursUniquePiece]         [decimal](10, 2) NULL,
		[DateLoaded]                          [datetime] NULL,
		[SourceFile]                          [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [stage].[EngineeringProductivity] SET (LOCK_ESCALATION = TABLE)
GO
