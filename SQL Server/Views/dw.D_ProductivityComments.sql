SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dw].[D_ProductivityComments] AS
SELECT DISTINCT
		CASE 
			WHEN EP.ProjectID IS NULL THEN PE.ProjectID
			WHEN PE.ProjectID IS NULL THEN EP.ProjectID
		END ProjectSID
		,CASE 
			WHEN EP.DateID IS NULL THEN PE.DateID
			WHEN PE.DateID IS NULL THEN EP.DateID
		END DateSID
		,CASE 
			WHEN EP.ProjectID IS NULL THEN (SELECT SupplierID FROM SupplierProject SP WHERE SP.ProjectID = PE.ProjectID)
			WHEN PE.ProjectID IS NULL THEN (SELECT SupplierID FROM SupplierProject SP WHERE SP.ProjectID = EP.ProjectID)
		END SupplierSID
		,[SafetyComment]
		,[CostComment]
		,[ScheduleComment]
		,[QualityComment]
		,[ResponsivenessComment]
		,[InnovationComment]
		,[ProjectComment]
	FROM
		dbo.EngineeringProductivity EP 
		FULL OUTER JOIN dbo.ProjectEvaluation PE ON EP.ProjectID = PE.ProjectID AND EP.DateID = PE.DateId


GO
