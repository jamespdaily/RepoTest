SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dw].[D_Country]
AS
SELECT
	CountryCityId CountrySID
   ,C.Continent
   ,Country
   ,CountryCode
   ,CI.CityName
   ,CASE IsHVEC
		WHEN 1 THEN 'HVEC'
		WHEN 0 THEN 'Non-HVEC'
	END AS IsHVEC
--,CAST(GETDATE() AS DATE) InsertDate
--,NULL UpdateDate
--,NULL ExpireDate
-- INTO dw.D_Country
FROM 
	dbo.Country C
	LEFT JOIN CountryCity CC ON C.CountryId = CC.CountryId
	LEFT JOIN City CI ON CC.CityId = CI.CityId
GROUP BY 
		CountryCityId
		,C.Continent
		,Country
		,CountryCode
		,CI.CityName
		,IsHVEC
GO
