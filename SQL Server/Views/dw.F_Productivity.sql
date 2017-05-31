SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dw].[F_Productivity] AS
	SELECT DISTINCT
		CASE 
			WHEN EP.ProjectID IS NULL THEN PE.ProjectID
			WHEN PE.ProjectID IS NULL THEN EP.ProjectID
		END ProjectSID
		,CASE 
			WHEN EP.DateID IS NULL THEN PE.DateID
			WHEN PE.DateID IS NULL THEN EP.DateID
		END DateSID
		,	CASE 
			WHEN EP.ProjectID IS NULL THEN (SELECT SupplierID FROM SupplierProject SP WHERE SP.ProjectID = PE.ProjectID)
			WHEN PE.ProjectID IS NULL THEN (SELECT SupplierID FROM SupplierProject SP WHERE SP.ProjectID = EP.ProjectID)
		END SupplierSID
		,[EngineeringHoursPieceEquipment]
		,[ProcessHoursUniquePiece]
		,[MechanicalHoursIsometricDrawing]
		,[PipinghoursTonneOfPiping]
		,[PipingHoursLinearMetere]
		,[RevisionsIsometricDrawing]
		,[CivilHoursConcreteCubicMeter]
		,[CivilHoursTonneSteel]
		,[ElectricalHoursConsumer]
		,[ElectricalHoursInstalledKW]
		,[InstrumentHoursIO]
		,[ProcurementHoursUniquePiece]
		,[ContractValueRange]
		,CAST([SafetyScore] AS INT) SafetyScore
		,[SafetyComment]
		,CAST([CostScore] AS INT) CostScore
		,[CostComment]
		,CAST([ScheduleScore] AS INT) ScheduleScore
		,[ScheduleComment]
		,CAST([QualityScore] AS INT) QualityScore
		,[QualityComment]
		,CAST([ResponsivenessScore] AS INT) ResponsivenessScore
		,[ResponsivenessComment]
		,CAST([InnovationScore] AS INT) InnovationScore
		,[InnovationComment]
		,[ProjectComment]
	FROM
		dbo.EngineeringProductivity EP 
		FULL OUTER JOIN dbo.ProjectEvaluation PE ON EP.ProjectID = PE.ProjectID AND EP.DateID = PE.DateId
	
	UNION ALL
	-- INDUSTRY BEST
	SELECT DISTINCT 
		CASE 
			WHEN EP.ProjectID IS NULL THEN PE.ProjectID
			WHEN PE.ProjectID IS NULL THEN EP.ProjectID
		END ProjectSID
		,CASE 
			WHEN EP.DateID IS NULL THEN PE.DateID
			WHEN PE.DateID IS NULL THEN EP.DateID
		END DateSID
		,99999 AS SupplierSID
		,NULL AS [EngineeringHoursPieceEquipment]
		,NULL AS [ProcessHoursUniquePiece]
		,NULL AS [MechanicalHoursIsometricDrawing]
		,NULL AS [PipinghoursTonneOfPiping]
		,NULL AS [PipingHoursLinearMetere]
		,NULL AS [RevisionsIsometricDrawing]
		,NULL AS [CivilHoursConcreteCubicMeter]
		,NULL AS [CivilHoursTonneSteel]
		,NULL AS [ElectricalHoursConsumer]
		,NULL AS [ElectricalHoursInstalledKW]
		,NULL AS [InstrumentHoursIO]
		,NULL AS [ProcurementHoursUniquePiece]
		,NULL AS [ContractValueRange]
		,CAST(MAX([SafetyScore]) AS INT) AS SafetyScore
		,NULL AS [SafetyComment]
		,CAST(MAX([CostScore]) AS INT) AS CostScore
		,NULL AS [CostComment]
		,CAST(MAX([ScheduleScore]) AS INT) AS ScheduleScore
		,NULL AS [ScheduleComment]
		,CAST(MAX([QualityScore]) AS INT) AS QualityScore
		,NULL AS [QualityComment]
		,CAST(MAX([ResponsivenessScore]) AS INT) AS ResponsivenessScore
		,NULL AS [ResponsivenessComment]
		,CAST(MAX([InnovationScore]) AS INT) AS InnovationScore
		,NULL AS [InnovationComment]
		,NULL AS ProjectComment
	FROM
		dbo.EngineeringProductivity EP 
		FULL OUTER JOIN dbo.ProjectEvaluation PE ON EP.ProjectID = PE.ProjectID AND EP.DateID = PE.DateId
	WHERE SafetyScore IS NOT NULL 
		OR CostScore IS NOT NULL 
		OR ScheduleScore IS NOT NULL 
		OR QualityScore IS NOT NULL 
		OR ResponsivenessScore IS NOT NULL 
		OR InnovationScore IS NOT NULL
	GROUP BY 
		PE.ProjectId, EP.ProjectId
		, PE.DateId, EP.DateId
		,[EngineeringHoursPieceEquipment]
		,[ProcessHoursUniquePiece]
		,[MechanicalHoursIsometricDrawing]
		,[PipinghoursTonneOfPiping]
		,[PipingHoursLinearMetere]
		,[RevisionsIsometricDrawing]
		,[CivilHoursConcreteCubicMeter]
		,[CivilHoursTonneSteel]
		,[ElectricalHoursConsumer]
		,[ElectricalHoursInstalledKW]
		,[InstrumentHoursIO]
		,[ProcurementHoursUniquePiece]
		,[ContractValueRange]
		,[SafetyComment]
		,[CostComment]
		,[ScheduleComment]
		,[QualityComment]
		,[ResponsivenessComment]
		,[InnovationComment]
		,ProjectComment






GO
