SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dw].[D_Supplier] WITH SCHEMABINDING AS
	SELECT
		SupplierID SupplierSID
		,SupplierName
		,COUNT_BIG(*) COUNT_BIG
	FROM
		dbo.Supplier
	GROUP BY
		SupplierID
		,SupplierName

	UNION ALL
	-- INDUSTRY BEST
	SELECT DISTINCT
		99999 AS SupplierSID
		, 'Industry Best' SupplierName
		, COUNT_BIG(*) COUNT_BIG
	FROM 
		dbo.Supplier
	GROUP BY 
		SupplierId
		, SupplierName




GO
