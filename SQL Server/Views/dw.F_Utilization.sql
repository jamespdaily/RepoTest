SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dw].[F_Utilization] AS
WITH 
HVEC AS (
	 --SELECT 
		--ProjectId ProjectID
		--,DU.CountryId
		--,DateId
		--,ScopeId
		--,SUM(ISNULL(Hours,0)) Hours
		--,SUM(CostAssociatedWithActualHours) AS Revenue
	 --FROM 
		--DetailedUtilization DU
		--LEFT JOIN Country C ON DU.CountryId = C.CountryId
	 --WHERE 
		--IsHVEC = 1
	 --GROUP BY ProjectId, DU.CountryId, DateId, ScopeId

	 SELECT DISTINCT
		pct.ProjectClientThemeId ProjectId 
		,CC.CountryCityId CountryId
		,DateId
		,ScopeId
		,SUM(ISNULL(Hours,0)) Hours
		,SUM(CostAssociatedWithActualHours) AS Revenue
	 FROM 
		DetailedUtilization DU
		LEFT JOIN ProjectClientTheme PCT ON DU.ProjectClientThemeId = PCT.ProjectClientThemeId
		LEFT JOIN CountryCity CC ON DU.CountryCityId = CC.CountryCityId
		LEFT JOIN Country C ON CC.CountryId = C.CountryId
	WHERE 
		IsHVEC = 1
	GROUP BY pct.ProjectClientThemeId, CC.CountryCityId, DateId, ScopeId

),
NonHVEC AS (
	 SELECT DISTINCT
		pct.ProjectClientThemeId ProjectId
		,CC.CountryCityId CountryId
		,DateId
		,ScopeId
		,SUM(ISNULL(Hours,0)) Hours
		,SUM(CostAssociatedWithActualHours) AS Revenue
	 FROM 
		DetailedUtilization DU
		LEFT JOIN ProjectClientTheme PCT ON DU.ProjectClientThemeId = PCT.ProjectClientThemeId
		LEFT JOIN CountryCity CC ON DU.CountryCityId = CC.CountryCityId
		LEFT JOIN Country C ON CC.CountryId = C.CountryId
	WHERE 
		IsHVEC = 0
	GROUP BY pct.ProjectClientThemeId, CC.CountryCityId, DateId, ScopeId
)
,
Utilization AS (		
	--SELECT DISTINCT 
	--		ISNULL(DU.ProjectID, FU.ProjectID) ProjectSID		
	--		,ISNULL(DU.CountryID, FU.CountryID) CountryID
	--		,ISNULL(DU.DateID, FU.DateID) DateID
	--		,ISNULL(DU.ScopeID, FU.ScopeID) ScopeID
	--		,SupplierID SupplierSID
	--		,DU.AwardValue
	--		,DU.Hours UtilizationHours
	--		,FU.Hours ForecastHours
	--		,FU.HVECHours ForecastHVECHours
	--		,CostAssociatedWithActualHours
	--FROM
	--		dbo.DetailedUtilization DU FULL OUTER JOIN 
	--		dbo.ForecastUtilization FU ON DU.ProjectID = FU.ProjectID AND DU.CountryID = FU.CountryID AND DU.DateID = FU.DateID AND FU.ScopeID = DU.ScopeID
	--		JOIN Country C ON C.CountryID = ISNULL(DU.CountryID, FU.CountryID)
	--		JOIN SupplierProject SP ON SP.ProjectId = ISNULL(DU.ProjectID, FU.ProjectID)

	SELECT DISTINCT 
		--ISNULL(DU.ProjectID, FU.ProjectID) ProjectID
		PCT.ProjectClientThemeId ProjectSID
		,CC.CountryCityId CountryID
		,ISNULL(DU.DateId, FU.DateId) DateID
		,ISNULL(DU.ScopeId, FU.ScopeId) ScopeID
		,SupplierID SupplierSID
		,DU.AwardValue
		,DU.Hours UtilizationHours
		,FU.Hours ForecastHours
		,FU.HVECHours ForecastHVECHours
		,CostAssociatedWithActualHours
	FROM 
		DetailedUtilization DU
		FULL OUTER JOIN ForecastUtilization FU ON DU.ProjectClientThemeID = FU.ProjectClientThemeID AND DU.CountryCityId = FU.CountryCityId AND DU.DateId = FU.DateId AND FU.ScopeId = DU.ScopeId
		JOIN ProjectClientTheme PCT ON ISNULL(DU.ProjectClientThemeID, FU.ProjectClientThemeID) = PCT.ProjectClientThemeId
		JOIN CountryCity CC ON ISNULL(DU.CountryCityId, FU.CountryCityId) = CC.CountryCityId
		JOIN Project P ON PCT.ProjectId = P.ProjectId
		JOIN SupplierProject SP ON P.ProjectId = SP.ProjectId		
)

SELECT 
	U.ProjectSID
	,U.CountryID
	,U.DateID DateSID
	,U.ScopeID ScopeSID
	,U.SupplierSID
	,U.AwardValue
	,U.UtilizationHours
	,U.ForecastHours
	,U.ForecastHVECHours
	,U.CostAssociatedWithActualHours
	,ISNULL(H.Hours,0) HVECHours
	,ISNULL(NH.Hours, 0) NonHVECHours
	,ISNULL(H.Revenue, 0) HVECRevenue
	,ISNULL(NH.Revenue, 0) NonHVECRevenue
	-- (sum of all MH from HVEC countries) / (sum of all MH from non-HVEC countries + sum of all MH from HVEC countries)
FROM 
	Utilization U
	LEFT JOIN HVEC H
		ON U.ProjectSId = H.ProjectId
		AND U.CountryId = H.CountryId 
		AND U.DateId = H.DateId
		AND U.ScopeId = H.ScopeId 
	LEFT JOIN NonHVEC NH
		ON U.ProjectSId = NH.ProjectId
		AND U.CountryId = NH.CountryId 
		AND U.DateId = NH.DateId
		AND U.ScopeId = NH.ScopeId




GO
