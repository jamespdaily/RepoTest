SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_Users]
AS
SELECT
	UserName
	,SupplierID
FROM 
	iVEDiXCMD_ShellSRM_DEV.dbo.UserLogin UL
	JOIN iVEDiXCMD_ShellSRM_DEV.dbo.Individual I 
		ON UL.IndividualID = I.IndividualId
	JOIN SHELL_SRM_V2.dbo.Supplier S 
		ON I.CompanyName = S.SupplierName 

UNION ALL

SELECT
	UserName
	,-1 SupplierID
FROM 
	iVEDiXCMD_ShellSRM_DEV.dbo.UserLogin UL
	JOIN iVEDiXCMD_ShellSRM_DEV.dbo.Individual I 
		ON UL.IndividualID = I.IndividualId
WHERE 
	CompanyName = 'Shell'

GO
