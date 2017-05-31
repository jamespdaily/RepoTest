SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		iVEDiX inc.
-- Create date: 4/18/2017
-- Description:	DetailedUtilization Transaction
-- =============================================
CREATE PROCEDURE [dbo].[usp_TRANSACTION_DetailedUtilization]
AS
BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY

-- Supplier
		INSERT dbo.Supplier (SupplierName)
			SELECT DISTINCT
				SupplierName
			FROM stage.DetailedUtilization
			WHERE SupplierName NOT IN (SELECT DISTINCT
					SupplierName
				FROM dbo.Supplier);

-- Client
		INSERT dbo.Client (ClientName)
			SELECT DISTINCT
				ClientName
			FROM stage.DetailedUtilization
			WHERE ClientName NOT IN (SELECT DISTINCT
					ClientName
				FROM dbo.Client);

-- City
		INSERT City (CityName)
		SELECT DISTINCT
				City
			FROM 
				stage.DetailedUtilization
			WHERE City NOT IN (SELECT DISTINCT CityName FROM dbo.City);

-- CountryCity Bridge
		INSERT INTO CountryCity	(CountryId, CityId)	
		SELECT DISTINCT
			c.CountryId
			,ci.CityId
		FROM 
			stage.DetailedUtilization du 
			JOIN Country c ON du.Country = c.Country
			JOIN City ci ON du.City = ci.CityName
			LEFT JOIN CountryCity cc ON cc.CityId = ci.CityId AND cc.CountryId = c.CountryId
		WHERE
			CountryCityID IS NULL

-- Project
		INSERT INTO Project (ProjectName, Active)		
		SELECT DISTINCT
			ProjectName
			,1 Active
		FROM
			stage.DetailedUtilization du
		WHERE ProjectName NOT IN (SELECT DISTINCT ProjectName FROM Project);

-- Supplier Project Bridge
		INSERT INTO SupplierProject (SupplierId, ProjectId)
		SELECT DISTINCT
			s.SupplierId
			,p.ProjectId
		FROM 
			stage.DetailedUtilization du 
			JOIN Supplier s ON du.SupplierName = s.SupplierName
			JOIN Project p ON du.ProjectName = p.ProjectName
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
			stage.DetailedUtilization du
			JOIN Project p ON du.ProjectName = p.ProjectName
			JOIN Client c ON du.ClientName = c.ClientName
			JOIN ShellTheme st ON du.ShellTheme = st.ShellTheme
			LEFT JOIN ProjectClientTheme pct ON p.ProjectId = pct.ProjectId
				AND c.ClientId = pct.ClientId
				AND st.ShellThemeId = pct.ShellThemeId
		WHERE
			pct.ProjectClientThemeId IS NULL

-- Detailed Utilization Transaction
		INSERT INTO dbo.DetailedUtilization ([DateId], [ScopeId], CountryCityId, ProjectClientThemeId, LastModifiedDate, SubmitDate, AwardValue, Hours, CostAssociatedWithActualHours, Remark, AwardDate, CompletionDate, StatusId)
		SELECT 
			sd.DateId
			,s.[ScopeId]
			,cc.[CountryCityId]
			,pct.[ProjectClientThemeId]
			,GETDATE() [LastModifiedDate]
			,GETDATE() [SubmitDate]
			,du.[AwardValue]
			,HoursExecuted [Hours]
			,du.[CostAssociatedWithActualHours]
			,du.[Remark]
			,du.[AwardDate]
			,du.[CompletionDate]
			,1 [StatusId]
		 FROM 
			stage.DetailedUtilization du
			JOIN SubmissionDate sd ON du.Date = sd.YearQuarter
			JOIN Scope s on du.Scope = s.Scope
			JOIN Country c on du.Country = c.Country
			JOIN City ci on du.City = ci.CityName
			JOIN Project p on du.ProjectName = p.ProjectName
			JOIN Client cl ON du.ClientName = cl.ClientName
			JOIN ShellTheme st on du.ShellTheme  = st.ShellTheme
			JOIN CountryCity cc ON c.CountryId = cc.CountryId AND cc.CityId = ci.CityId
			JOIN ProjectClientTheme pct ON pct.ClientId = cl.ClientId AND pct.ProjectId = p.ProjectId AND pct.ShellThemeId = st.ShellThemeId
			LEFT JOIN dbo.DetailedUtilization ddu ON ddu.ScopeId = s.ScopeId	
				AND ddu.CountryCityId = cc.CountryCityId
				AND ddu.ProjectClientThemeId = pct.ProjectClientThemeId
				AND ddu.DateId = sd.DateId
		WHERE 
			ddu.DetailiedUtilizationId IS NULL

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
