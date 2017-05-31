SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [stage].[usp_INSERT_DetailedUtilization]
@UserID nvarchar(50) = NULL 
AS

	BEGIN TRANSACTION;

	BEGIN TRY
	 delete from [mirror].[DetailedUtilization] where F1 = ''
		MERGE stage.DetailedUtilization du
		USING (SELECT
				(SELECT
						F4
					FROM mirror.DetailedUtilization
					WHERE F1 LIKE '%PARENT CONTRACTOR%')/*Here project contractor was changed to ENTER SUPPLIER NAME*/
				AS SupplierName
			   ,(SELECT
						F4  /*insted of f3 changed it to F4*/
					FROM mirror.DetailedUtilization
					WHERE F1 LIKE '%DETAILED UTILIZATION ACTUAL%')
				AS Date
			   ,F1 AS ClientName
			   ,(SELECT
						Country
					FROM ufn_LocationData(F2))
				AS Country
			   ,(SELECT
						City
					FROM ufn_LocationData(F2))
				AS City
			   ,F3 AS ProjectName
			   ,dbo.ufn_CleanNumber(F4) AS AwardValue
			   ,F5 AS Scope
			   ,CAST(F6 AS DATE) AS AwardDate
			   ,ISNULL(F7, 'None') AS ShellTheme
			   ,CAST(F8 AS DATE) AS CompletionDate
			   ,dbo.ufn_CleanNumber(F9) AS HoursExecuted
			   ,dbo.ufn_CleanNumber(F10) AS CostAssociatedWithActualHours
			   ,F11 AS Remark
			   ,GETDATE() DateLoaded
			   ,SourceFile
			FROM mirror.DetailedUtilization
			WHERE F1 NOT LIKE '%PARENT CONTRACTOR%'
			AND F1 NOT LIKE '%DETAILED UTILIZATION ACTUAL%'
			AND F1 NOT LIKE 'Client') AS src (SupplierName, Date, ClientName, Country, City, ProjectName, AwardValue, Scope, AwardDate, ShellTheme, CompletionDate, HoursExecuted, CostAssociatedWithActualHours, Remark, DateLoaded, SourceFile)
		ON du.SupplierName = src.SupplierName
			AND du.Date = src.Date
			AND du.ClientName = src.ClientName
			AND du.Country = src.Country
			AND du.City = src.City
			AND du.ProjectName = src.ProjectName
			AND du.Scope = src.Scope
			AND du.ShellTheme = src.ShellTheme
		WHEN NOT MATCHED
			THEN INSERT (SupplierName, Date, ClientName, Country, City, ProjectName, AwardValue, Scope, AwardDate, ShellTheme, CompletionDate, HoursExecuted, CostAssociatedWithActualHours, Remark, DateLoaded, SourceFile)
					VALUES (src.SupplierName, src.Date, src.ClientName, src.Country, src.City, src.ProjectName, src.AwardValue, src.Scope, src.AwardDate, src.ShellTheme, src.CompletionDate, src.HoursExecuted, src.CostAssociatedWithActualHours, src.Remark, src.DateLoaded, src.SourceFile)
		WHEN MATCHED
			THEN UPDATE
				SET AwardValue = src.AwardValue
				   ,AwardDate = src.AwardDate
				   ,CompletionDate = src.CompletionDate
				   ,HoursExecuted = src.HoursExecuted
				   ,CostAssociatedWithActualHours = src.CostAssociatedWithActualHours
				   ,Remark = src.Remark
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
