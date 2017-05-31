SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [stage].[usp_INSERT_ForecastUtilization]
@UserID nvarchar(50) = NULL
AS

	BEGIN TRANSACTION;

	BEGIN TRY

		MERGE stage.ForecastUtilization fu
		USING (SELECT
				(SELECT
						F3
					FROM mirror.ForecastUtilization
					WHERE F2 LIKE '%PARENT CONTRACTOR%')
				AS SupplierName
			   ,(SELECT
						F3
					FROM mirror.ForecastUtilization
					WHERE F1 LIKE '%SUMMARY OF FORECASTED PROJECT UTILIZATION FOR%')
				AS Date
			   ,F1 AS ProjectName
			   ,(SELECT
						Country
					FROM ufn_LocationData(F2))
				AS Country
			   ,(SELECT
						City
					FROM ufn_LocationData(F2))
				AS City
			   ,ISNULL(F3, 'None') AS ShellTheme
			   ,F4 AS Scope
			   ,F5 AS AwardStatus
			   ,dbo.ufn_CleanNumber(F6) AS TotalEstimatedHours
			   ,dbo.ufn_CleanNumber(F7) AS HVECHours
			   ,F8 AS EFAProject
			   ,DateLoaded
			   ,SourceFile
			FROM mirror.ForecastUtilization
			WHERE F2 NOT LIKE '%PARENT CONTRACTOR%'
			AND F1 NOT LIKE '%SUMMARY OF FORECASTED PROJECT UTILIZATION FOR%'
			AND F1 NOT LIKE '%Project Name/Job Description%') AS src (SupplierName, Date, ProjectName, Country, City, ShellTheme, Scope, AwardStatus, TotalEstimatedHours, HVECHours, EFAProject, DateLoaded, SourceFile)
		ON fu.SupplierName = src.SupplierName
			AND fu.Date = src.Date
			AND fu.ProjectName = src.ProjectName
			AND fu.Country = src.Country
			AND fu.City = src.City
			AND fu.ShellTheme = src.ShellTheme
			AND fu.Scope = src.Scope
		WHEN NOT MATCHED
			THEN INSERT (SupplierName, Date, ProjectName, City, Country, ShellTheme, Scope, AwardStatus, TotalEstimatedHours, HVECHours, EFAProject, DateLoaded, SourceFile)
					VALUES (src.SupplierName, src.Date, src.ProjectName, src.City, src.Country, src.ShellTheme, src.Scope, src.AwardStatus, src.TotalEstimatedHours, src.HVECHours, src.EFAProject, src.DateLoaded, src.SourceFile)
		WHEN MATCHED
			THEN UPDATE
				SET AwardStatus = src.AwardStatus
				   ,TotalEstimatedHours = src.TotalEstimatedHours
				   ,HVECHours = src.HVECHours
				   ,EFAProject = src.EFAProject
				   ,DateLoaded = src.DateLoaded
				   ,SourceFile = src.SourceFile;

	END TRY
	BEGIN CATCH

		SELECT
			ERROR_NUMBER() AS ErrorNumber
		   ,ERROR_SEVERITY() AS ErrorSeverity
		   ,ERROR_STATE() AS ErrorState
		   ,ERROR_PROCEDURE() AS ErrorProcedure
		   ,ERROR_LINE() AS ErrorLine
		   ,ERROR_MESSAGE() AS ErrorMessage;

		IF @@trancount > 0
			ROLLBACK TRANSACTION;
	END CATCH;

	IF @@trancount > 0
		COMMIT TRANSACTION;


GO
