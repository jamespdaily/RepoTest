SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_MASTER_ReloadCountry] AS
DELETE FROM Country
INSERT INTO Country (Continent, CountryCode, Country, FreeFormLocation, IsHVEC)
	SELECT
		c.ContinentName
		,c.CountryCode
		,c.CountryName
		,NULL FreeFormLocation
		,c.[Is HVEC?]
	FROM 
		stage.LOOKUP_Countries c
	WHERE
		[Is HVEC?] IS NOT NULL

INSERT INTO City (CityName)
VALUES ('N/A')
GO
