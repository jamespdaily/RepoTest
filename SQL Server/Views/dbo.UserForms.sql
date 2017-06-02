SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[UserForms]
AS
SELECT
	UserName
	,FormID
FROM 
	iVEDiXCMD_ShellSRM_DEV.dbo.UserLogin UL
	JOIN iVEDiXCMD_ShellSRM_DEV.dbo.Individual I 
		ON UL.IndividualID = I.IndividualId
	JOIN Forms F ON F.FormName = 'Evaluation'
WHERE 
	CompanyName = 'Shell'

UNION ALL

SELECT
	UserName
	,FormID
FROM 
	iVEDiXCMD_ShellSRM_DEV.dbo.UserLogin UL
	JOIN iVEDiXCMD_ShellSRM_DEV.dbo.Individual I 
		ON UL.IndividualID = I.IndividualId
	JOIN Forms F ON F.FormName <> 'Evaluation'
WHERE 
	CompanyName <> 'Shell'

GO
