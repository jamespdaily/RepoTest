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

-- Supplier
	INSERT dbo.Supplier (SupplierName)
	SELECT DISTINCT SupplierName 
	FROM stage.EngineeringProductivity
	WHERE SupplierName NOT IN (
		SELECT DISTINCT SupplierName FROM dbo.Supplier
	);

-- Client
	INSERT dbo.Client (ClientName)
	SELECT DISTINCT ClientName 
	FROM stage.EngineeringProductivity
	WHERE ClientName NOT IN (
		SELECT DISTINCT ClientName FROM dbo.Client
	);

-- Project
	INSERT dbo.Project (ProjectName)
	SELECT DISTINCT ProjectName 
	FROM stage.EngineeringProductivity
	WHERE ProjectName NOT IN (
		SELECT DISTINCT ProjectName FROM dbo.Project
	);


-- Supplier Project
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

-- Project Client Theme
	MERGE dbo.ProjectClientTheme pct
	USING (
		SELECT DISTINCT
			c.ClientID
			,p.ProjectId
			,st.ShellThemeID
		FROM 
			stage.EngineeringProductivity ep
			JOIN Project p ON ep.ProjectName = p.ProjectName
			JOIN Client c ON ep.ClientName = c.ClientName
			JOIN ShellTheme st ON ep.ShellTheme = st.ShellTheme
	) AS src (ClientID, ProjectID, ShellThemeID)
		ON pct.ClientID = src.ClientId AND pct.ProjectID = src.ProjectID AND pct.ShellThemeID = src.ShellThemeID
	WHEN NOT MATCHED THEN
		INSERT (ClientID, ProjectID, ShellThemeID)
		VALUEs (src.ClientID, src.ProjectID, src.ShellThemeID);

-- Engineering Productivity
	MERGE dbo.EngineeringProductivity ep
	USING (
		SELECT DISTINCT 
			ProjectClientThemeId, DateID
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
		JOIN dbo.Client c ON stage.ClientName = c.ClientName
		JOIN dbo.ShellTheme st ON stage.ShellTheme = st.ShellTheme
		JOIN dbo.ProjectClientTheme pct ON p.ProjectID = pct.ProjectID
			AND c.ClientID = pct.ClientID
			AND st.ShellThemeID = pct.ShellThemeID			
		JOIN dbo.SubmissionDate sd ON stage.Date = sd.YearQuarter 
	) AS src (ProjectClientThemeID, DateID
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
			ON ep.ProjectClientThemeID = src.ProjectClientThemeID AND ep.DateId = src.DateId 
	WHEN NOT MATCHED THEN
		INSERT (ProjectClientThemeID, DateId
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
		VALUES (src.ProjectClientThemeID, src.DateId
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
