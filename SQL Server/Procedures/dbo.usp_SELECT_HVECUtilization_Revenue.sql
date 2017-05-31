SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SELECT_HVECUtilization_Revenue]
	@UserName VARCHAR(50)
	,@ProjectName VARCHAR(255)
	,@ShellTheme VARCHAR(50)
AS

SELECT 
	(SUM(IIF(IsHVEC = 1, hours, 0))/SUM(Hours))*100 HVECUtilization
	,SUM(CostAssociatedWithActualHours) Revenue
FROM 
	DetailedUtilization DU
	JOIN SupplierProject SP ON du.ProjectId = SP.ProjectId
	JOIN Supplier S ON SP.SupplierId = S.SupplierId
	JOIN Project P ON SP.ProjectId = P.ProjectId
	JOIN ShellTheme ST ON P.ShellThemeId = ST.ShellThemeId
	JOIN Country C ON du.CountryId = C.CountryId
	JOIN Users U ON S.SupplierId = U.SupplierId
WHERE 
	UserName = @UserName
	AND ProjectName = @ProjectName
	AND ShellTheme = @ShellTheme






GO
