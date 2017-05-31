SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [stage].[usp_INSERT_ProjectPerformance] 
AS

BEGIN TRANSACTION;

BEGIN TRY

	MERGE stage.ProjectPerformance pp
	USING (
		SELECT 
			(SELECT F6 FROM mirror.ProjectPerformance WHERE F1 LIKE '%PROJECT PERFORMANCE EVALUATION FOR%') AS Date
			, F1 AS ProjectName
			, F2 AS SupplierName
			, F3 AS ContractValueRange
			, CAST(F4 AS INT) AS SafetyScore
			, F5 AS SafetyComment
			, CAST(F6 AS INT) AS CostScore
			, F7 AS CostComment
			, CAST(F8 AS INT) AS ScheduleScore
			, F9 AS ScheduleComment
			, CAST(F10 AS INT) AS QualityScore
			, F11 AS QualityComment
			, CAST(F12 AS INT) AS ResponsivenessScore
			, F13 AS ResponsivenessComments
			, CAST(F14 AS INT) AS InnovationScore
			, F15 AS InnovationComment
			, F16 AS ProjectComment
			, F17 AS ShellPM
			, F18 AS ShellCPFocalPoint
			, F19 AS ASContractorManager
			, DateLoaded
			, SourceFile
		FROM mirror.ProjectPerformance
		WHERE F1 NOT LIKE '%PROJECT PERFORMANCE EVALUATION FOR%'
			AND F1 NOT LIKE '%Project/ Contract Name%'
	) AS src (Date, ProjectName, SupplierName, ContractValueRange
			, SafetyScore, SafetyComment
			, CostScore, CostComment
			, ScheduleScore, ScheduleComment
			, QualityScore, QualityComment
			, ResponsivenessScore, ResponsivenessComment
			, InnovationScore, InnovationComment
			, ProjectComment
			, ShellPM, ShellCPFocalPoint, ASContractorManager
			, DateLoaded, SourceFile)
		ON pp.Date = src.Date AND pp.ProjectName = src.ProjectName AND pp.SupplierName = src.SupplierName 
	WHEN NOT MATCHED THEN
		INSERT (Date, ProjectName, SupplierName, ContractValueRange
			, SafetyScore, SafetyComment
			, CostScore, CostComment
			, ScheduleScore, ScheduleComment
			, QualityScore, QualityComment
			, ResponsivenessScore, ResponsivenessComment
			, InnovationScore, InnovationComment
			, ProjectComment
			, ShellPM, ShellCPFocalPoint, ASContractorManager
			, DateLoaded, SourceFile)
		VALUES (src.Date, src.ProjectName, src.SupplierName, src.ContractValueRange
			, src.SafetyScore, src.SafetyComment
			, src.CostScore, src.CostComment
			, src.ScheduleScore, src.ScheduleComment
			, src.QualityScore, src.QualityComment
			, src.ResponsivenessScore, src.ResponsivenessComment
			, src.InnovationScore, src.InnovationComment
			, src.ProjectComment
			, src.ShellPM, src.ShellCPFocalPoint, src.ASContractorManager
			, src.DateLoaded, src.SourceFile)
	WHEN MATCHED THEN
		UPDATE
		SET ContractValueRange = src.ContractValueRange
			, SafetyScore = src.SafetyScore
			, SafetyComment = src.SafetyComment
			, CostScore = src.CostScore
			, CostComment = src.CostComment
			, ScheduleScore = src.ScheduleScore
			, ScheduleComment = src.ScheduleComment
			, QualityScore = src.QualityScore
			, QualityComment = src.QualityComment
			, ResponsivenessScore = src.ResponsivenessScore
			, ResponsivenessComment = src.ResponsivenessComment
			, InnovationScore = src.InnovationScore
			, InnovationComment = src.InnovationComment
			, ProjectComment = src.ProjectComment
			, ShellPM = src.ShellPM
			, ShellCPFocalPoint = src.ShellCPFocalPoint
			, ASContractorManager = src.ASContractorManager
			, DateLoaded = src.DateLoaded
			, SourceFile = src.SourceFile;

END TRY
BEGIN CATCH

	SELECT ERROR_NUMBER() AS ErrorNumber
		, ERROR_SEVERITY() AS ErrorSeverity
		, ERROR_STATE() AS ErrorState
		, ERROR_PROCEDURE() AS ErrorProcedure
		, ERROR_LINE() AS ErrorLine
		, ERROR_MESSAGE() AS ErrorMessage;

	IF @@TRANCOUNT>0
		ROLLBACK TRANSACTION;
END CATCH;

IF @@TRANCOUNT>0
	COMMIT TRANSACTION;


GO
