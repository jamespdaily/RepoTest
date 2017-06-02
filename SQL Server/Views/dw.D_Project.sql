SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dw].[D_Project] 
AS
	--SELECT DISTINCT
	--	P.ProjectID ProjectSID
	--	,ProjectName
	--	,ClientName
	--	,ShellTheme
	--	,(SELECT FullName FROM Person WHERE PersonID = PE.ShellPM) ShellPM
	--	,(SELECT FullName FROM Person WHERE PersonID = PE.ASContractorManager) ASContractorManager
	--	,(SELECT FullName FROM Person WHERE PersonID = PE.ShellCPFocalPoint) ShellCPFocalPoint
	--	,AwardDate
	--	,CompletionDate
	--	,EFAProject
	--	,Active
	--FROM
	--	dbo.Project P
	--	LEFT JOIN dbo.Client C ON P.ClientId = C.ClientId
	--	LEFT JOIN dbo.ProjectEvaluation PE ON P.ProjectID = PE.ProjectID
	--	JOIN dbo.ShellTheme ST ON P.ShellThemeId = ST.ShellThemeId


	SELECT DISTINCT	
		pct.ProjectClientThemeId ProjectSID
		,ProjectName
		,ClientName
		,ShellTheme
		,(SELECT FullName FROM Person WHERE PersonID = PE.ShellPM) ShellPM
		,(SELECT FullName FROM Person WHERE PersonID = PE.ASContractorManager) ASContractorManager
		,(SELECT FullName FROM Person WHERE PersonID = PE.ShellCPFocalPoint) ShellCPFocalPoint
		,'Yes' EFAProject
	FROM 
		dbo.Project P
		LEFT JOIN dbo.ProjectClientTheme PCT ON P.ProjectID = PCT.ProjectID
		LEFT JOIN dbo.Client C ON PCT.ClientId = C.ClientId
		LEFT JOIN dbo.ShellTheme ST ON PCT.ShellThemeId = ST.ShellThemeID
		LEFT JOIN dbo.DetailedUtilization DU ON PCT.ProjectClientThemeID = DU.ProjectClientThemeId
		LEFT JOIN dbo.ProjectEvaluation PE ON P.ProjectId = PE.ProjectID




GO
