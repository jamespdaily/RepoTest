SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		iVEDiX inc.
-- Create date: 4/18/2017
-- Description:	ForecastUtilization Transaction
-- =============================================
CREATE PROCEDURE [dbo].[usp_TRANSACTION_ForecastUtilization]
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY

-- Supplier
		INSERT dbo.Supplier (SupplierName)
			SELECT DISTINCT
				SupplierName
			FROM stage.ForecastUtilization
			WHERE SupplierName NOT IN (SELECT DISTINCT
					SupplierName
				FROM dbo.Supplier);

-- Client
		INSERT dbo.Client (ClientName)
			SELECT DISTINCT
				ClientName
			FROM stage.ForecastUtilization
			WHERE ClientName NOT IN (SELECT DISTINCT
					ClientName
				FROM dbo.Client);

-- City
		INSERT City (CityName)
		SELECT DISTINCT
				City
			FROM 
				stage.ForecastUtilization
			WHERE City NOT IN (SELECT DISTINCT CityName FROM dbo.City);

-- CountryCity Bridge
		INSERT INTO CountryCity	(CountryId, CityId)	
		SELECT DISTINCT
			c.CountryId
			,ci.CityId
		FROM 
			stage.ForecastUtilization fu 
			JOIN Country c ON fu.Country = c.Country
			JOIN City ci ON fu.City = ci.CityName
			LEFT JOIN CountryCity cc ON cc.CityId = ci.CityId AND cc.CountryId = c.CountryId
		WHERE
			CountryCityID IS NULL

-- Project
		INSERT INTO Project (ProjectName, Active)		
		SELECT DISTINCT
			ProjectName
			,1 Active
		FROM
			stage.ForecastUtilization fu
		WHERE ProjectName NOT IN (SELECT DISTINCT ProjectName FROM Project);

-- Supplier Project Bridge
		INSERT INTO SupplierProject (SupplierId, ProjectId)
		SELECT DISTINCT
			s.SupplierId
			,p.ProjectId
		FROM 
			stage.ForecastUtilization fu 
			JOIN Supplier s ON fu.SupplierName = s.SupplierName
			JOIN Project p ON fu.ProjectName = p.ProjectName
			LEFT JOIN SupplierProject sp ON s.SupplierId = sp.SupplierId 
				AND p.ProjectId = sp.ProjectId
		WHERE
			sp.SupplierProjectId IS NULL

-- Project Client Theme Bridge
		INSERT INTO ProjectClientTheme (ClientId, ProjectId, ShellThemeId)
		SELECT DISTINCT
			c.ClientId
			,p.ProjectId
			,st.ShellThemeId
		FROM
			stage.ForecastUtilization fu
			JOIN Project p ON fu.ProjectName = p.ProjectName
			JOIN Client c ON fu.ClientName = c.ClientName
			JOIN ShellTheme st ON fu.ShellTheme = st.ShellTheme
			LEFT JOIN ProjectClientTheme pct ON p.ProjectId = pct.ProjectId
				AND c.ClientId = pct.ClientId
				AND st.ShellThemeId = pct.ShellThemeId
		WHERE
			pct.ProjectClientThemeId IS NULL

-- Forecast Utilization Transaction
		INSERT INTO dbo.ForecastUtilization ([DateId], [ScopeId], CountryCityId, ProjectClientThemeId, AwardStatusId, LastModifiedDate, SubmitDate, Hours, EFAProject, StatusId)
		SELECT 
			sd.DateId
			,s.[ScopeId]
			,cc.[CountryCityId]
			,pct.[ProjectClientThemeId]
			,a.[AwardStatusId]
			,GETDATE() [LastModifiedDate]
			,GETDATE() [SubmitDate]
			,[TotalEstimatedHours] [Hours]
			,IIF(fu.EFAProject = 'Yes', 1, 0)
			,1 [StatusId]
		 FROM 
			stage.ForecastUtilization fu
			JOIN SubmissionDate sd ON fu.Date = sd.YearQuarter
			JOIN Scope s on fu.Scope = s.Scope
			JOIN Country c on fu.Country = c.Country
			JOIN City ci on fu.City = ci.CityName
			JOIN Project p on fu.ProjectName = p.ProjectName
			JOIN Client cl ON fu.ClientName = cl.ClientName
			JOIN ShellTheme st on fu.ShellTheme  = st.ShellTheme
			JOIN CountryCity cc ON c.CountryId = cc.CountryId AND cc.CityId = ci.CityId
			JOIN AwardStatus a ON fu.AwardStatus = a.AwardStatus
			JOIN ProjectClientTheme pct ON pct.ClientId = cl.ClientId AND pct.ProjectId = p.ProjectId AND pct.ShellThemeId = st.ShellThemeId
			LEFT JOIN dbo.ForecastUtilization dfu ON dfu.ScopeId = s.ScopeId	
				AND dfu.CountryCityId = cc.CountryCityId
				AND dfu.ProjectClientThemeId = pct.ProjectClientThemeId
				AND dfu.AwardStatusId = a.AwardStatusId
				AND dfu.DateId = sd.DateId
			WHERE 
				dfu.ForecastUtilizationId IS NULL

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

END
GO
