SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		iVEDiX inc.
-- Create date: 4/18/2017
-- Description:	EngineeringProductivity Transaction
-- =============================================
CREATE PROCEDURE [dbo].[usp_TRANSACTION_EngineeringProductivity]
AS

BEGIN TRANSACTION;

BEGIN TRY

	INSERT dbo.Supplier (SupplierName)
	SELECT DISTINCT SupplierName 
	FROM stage.EngineeringProductivity
	WHERE SupplierName NOT IN (
		SELECT DISTINCT SupplierName FROM dbo.Supplier
	);

	INSERT dbo.Client (ClientName)
	SELECT DISTINCT ClientName 
	FROM stage.EngineeringProductivity
	WHERE ClientName NOT IN (
		SELECT DISTINCT ClientName FROM dbo.Client
	);

	INSERT dbo.Project (ProjectName)
	SELECT DISTINCT ProjectName 
	FROM stage.EngineeringProductivity
	WHERE ProjectName NOT IN (
		SELECT DISTINCT ProjectName FROM dbo.Project
	);

	UPDATE proj
	SET proj.ClientId = sub.ClientId
	FROM dbo.Project proj
	JOIN (
		SELECT DISTINCT ProjectName
			, ClientId 
		FROM stage.EngineeringProductivity s
		JOIN dbo.Client d ON s.ClientName = d.ClientName
	) sub ON proj.ProjectName = sub.ProjectName;

	-- INSERT supplier projects if not already mapped in dbo.SupplierProject
	MERGE dbo.SupplierProject sp
	USING (
		SELECT DISTINCT ProjectId, SupplierId 
		FROM stage.EngineeringProductivity stage
		JOIN dbo.Project p ON stage.ProjectName = p.ProjectName
		JOIN dbo.Supplier s ON stage.SupplierName = s.SupplierName
	) AS src (ProjectId, SupplierId)
		ON sp.ProjectId = src.ProjectId AND sp.SupplierId = src.SupplierId
	WHEN NOT MATCHED THEN
		INSERT (ProjectId, SupplierId)
		VALUES (src.ProjectId, src.SupplierId);

	MERGE dbo.EngineeringProductivity ep
	USING (
		SELECT DISTINCT 
			ProjectId, DateId
			, GETDATE() AS LastModifiedDate, GETDATE() AS SubmitDate
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
		FROM stage.EngineeringProductivity stage
		JOIN dbo.Project p ON stage.ProjectName = p.ProjectName
		JOIN dbo.SubmissionDate sd ON stage.Date = sd.YearQuarter 
	) AS src (ProjectId, DateId
			, LastModifiedDate, SubmitDate
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
			, ProcurementHoursUniquePiece)
			ON ep.ProjectId = src.ProjectId AND ep.DateId = src.DateId
	WHEN NOT MATCHED THEN
		INSERT (ProjectId, DateId
			, LastModifiedDate, SubmitDate
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
			, ProcurementHoursUniquePiece)
		VALUES (src.ProjectId, src.DateId
			, src.LastModifiedDate, src.SubmitDate
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
			, src.ProcurementHoursUniquePiece)
	WHEN MATCHED THEN
		UPDATE 
		SET LastModifiedDate = src.LastModifiedDate
			, SubmitDate = src.SubmitDate
			, EngineeringHoursPieceEquipment = src.EngineeringHoursPieceEquipment
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
			, ProcurementHoursUniquePiece = src.ProcurementHoursUniquePiece;

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
