SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [stage].[usp_INSERT_EngineeringProductivity]
AS

BEGIN TRANSACTION;

BEGIN TRY

	MERGE stage.EngineeringProductivity ep
	USING (
		SELECT
			(SELECT F5 FROM mirror.EngineeringProductivity WHERE F1 LIKE '%ENGINEERING PRODUCTIVITY KEY PERFORMANCE INDICATORS FOR%') AS Date
			, (SELECT F5 FROM mirror.EngineeringProductivity WHERE F1 LIKE '%PARENT CONTRACTOR%') AS SupplierName
			, F1 AS ProjectName
			, F2 AS ClientName
			, F3 AS ShellTheme
			, CAST(F4 AS DECIMAL(10,2)) AS EngineeringHoursPieceEquipment 
			, CAST(F5 AS DECIMAL(10,2)) AS ProcessHoursUniquePiece 
			, CAST(F6 AS DECIMAL(10,2)) AS MechanicalHoursIsometricDrawing 
			, CAST(F7 AS DECIMAL(10,2)) AS PipinghoursTonneOfPiping 
			, CAST(F8 AS DECIMAL(10,2)) AS PipingHoursLinearMetere 
			, CAST(F9 AS DECIMAL(10,2)) AS RevisionsIsometricDrawing 
			, CAST(F10 AS DECIMAL(10,2)) AS CivilHoursConcreteCubicMeter 
			, CAST(F11 AS DECIMAL(10,2)) AS CivilHoursTonneSteel 
			, CAST(F12 AS DECIMAL(10,2)) AS ElectricalHoursConsumer 
			, CAST(F13 AS DECIMAL(10,2)) AS ElectricalHoursInstalledKW 
			, CAST(F14 AS DECIMAL(10,2)) AS InstrumentHoursIO 
			, CAST(F15 AS DECIMAL(10,2)) AS ProcurementHoursUniquePiece 
			, DateLoaded
			, SourceFile
		FROM mirror.EngineeringProductivity
		WHERE F1 NOT LIKE '%ENGINEERING PRODUCTIVITY KEY PERFORMANCE INDICATORS FOR%'
			AND F1 NOT LIKE '%PARENT CONTRACTOR%'
			AND F1 NOT LIKE '%Project Name%'
	) AS src (Date, SupplierName, ProjectName, ClientName, ShellTheme
			, EngineeringHoursPieceEquipment
			, ProcessHoursUniquePiece
			, MechanicalHoursIsometricDrawing
			, PipinghoursTonneOfPiping
			, PipingHoursLinearMetere
			, RevisionsIsometricDrawing
			, CivilHoursConcreteCubicMeter
			, CivilHoursTonneSteel
			, ElectricalHoursConsumer
			, ElectricalHoursInstalledKW
			, InstrumentHoursIO
			, ProcurementHoursUniquePiece
			, DateLoaded, SourceFile)
		ON ep.Date = src.Date AND ep.SupplierName = src.SupplierName AND ep.ProjectName = src.ProjectName AND ep.ClientName = src.ClientName AND ep.ShellTheme = src.ShellTheme
	WHEN NOT MATCHED THEN
		INSERT (Date, SupplierName, ProjectName, ClientName, ShellTheme
			, EngineeringHoursPieceEquipment
			, ProcessHoursUniquePiece
			, MechanicalHoursIsometricDrawing
			, PipinghoursTonneOfPiping
			, PipingHoursLinearMetere
			, RevisionsIsometricDrawing
			, CivilHoursConcreteCubicMeter
			, CivilHoursTonneSteel
			, ElectricalHoursConsumer
			, ElectricalHoursInstalledKW
			, InstrumentHoursIO
			, ProcurementHoursUniquePiece
			, DateLoaded, SourceFile)
		VALUES (src.Date, src.SupplierName, src.ProjectName, src.ClientName, src.ShellTheme
			, src.EngineeringHoursPieceEquipment
			, src.ProcessHoursUniquePiece
			, src.MechanicalHoursIsometricDrawing
			, src.PipinghoursTonneOfPiping
			, src.PipingHoursLinearMetere
			, src.RevisionsIsometricDrawing
			, src.CivilHoursConcreteCubicMeter
			, src.CivilHoursTonneSteel
			, src.ElectricalHoursConsumer
			, src.ElectricalHoursInstalledKW
			, src.InstrumentHoursIO
			, src.ProcurementHoursUniquePiece
			, src.DateLoaded, src.SourceFile)
	WHEN MATCHED THEN
		UPDATE 
		SET EngineeringHoursPieceEquipment = src.EngineeringHoursPieceEquipment
			, ProcessHoursUniquePiece = src.ProcessHoursUniquePiece
			, MechanicalHoursIsometricDrawing = src.MechanicalHoursIsometricDrawing
			, PipinghoursTonneOfPiping = src.PipinghoursTonneOfPiping
			, PipingHoursLinearMetere = src.PipingHoursLinearMetere
			, RevisionsIsometricDrawing = src.RevisionsIsometricDrawing
			, CivilHoursConcreteCubicMeter = src.CivilHoursConcreteCubicMeter
			, CivilHoursTonneSteel = src.CivilHoursTonneSteel
			, ElectricalHoursConsumer = src.ElectricalHoursConsumer
			, ElectricalHoursInstalledKW = src.ElectricalHoursInstalledKW
			, InstrumentHoursIO = src.InstrumentHoursIO
			, ProcurementHoursUniquePiece = src.ProcurementHoursUniquePiece
			, DateLoaded = src.DateLoaded
			, SourceFile = src.SourceFile;

END TRY
BEGIN CATCH

	SELECT ERROR_NUMBER() AS ErrorNumber
		, ERROR_SEVERITY() AS ErrorSeverity
		, ERROR_STATE() AS ErrorState
		, ERROR_PROCEDURE() AS ErrorProcedure
		, ERROR_LINE() AS ErrorLine
		, ERROR_MESSAGE() AS ErrorMessage;

	IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION;
END CATCH;

IF @@TRANCOUNT>0
	COMMIT TRANSACTION;


GO
