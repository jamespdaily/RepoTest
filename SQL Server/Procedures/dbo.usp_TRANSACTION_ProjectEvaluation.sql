SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		iVEDiX inc.
-- Create date: 4/18/2017
-- Description:	ProjectEvaluation Transaction
-- =============================================
CREATE PROCEDURE [dbo].[usp_TRANSACTION_ProjectEvaluation]
AS

BEGIN TRANSACTION;

BEGIN TRY

	-- INSERT Suppliers not already belonging to dbo.Supplier
	INSERT dbo.Supplier (SupplierName)
	SELECT DISTINCT SupplierName
	FROM stage.ProjectPerformance
	WHERE SupplierName NOT IN (
		SELECT DISTINCT SupplierName FROM dbo.Supplier
	);

	-- INSERT Projects not already beloning to dbo.Project
	INSERT dbo.Project (ProjectName)
	SELECT DISTINCT ProjectName 
	FROM stage.ProjectPerformance
	WHERE ProjectName NOT IN (
		SELECT DISTINCT ProjectName FROM dbo.Project
	);

	MERGE dbo.SupplierProject sp
	USING (
		SELECT DISTINCT ProjectId, SupplierId 
		FROM stage.ProjectPerformance stage
		JOIN dbo.Project p ON stage.ProjectName = p.ProjectName
		JOIN dbo.Supplier s ON stage.SupplierName = s.SupplierName
	) AS src (ProjectId, SupplierId)
		ON sp.ProjectId = src.ProjectId AND sp.SupplierId = src.SupplierId
	WHEN NOT MATCHED THEN
		INSERT (ProjectId, SupplierId)
		VALUES (src.ProjectId, src.SupplierId);

	-- INSERT Persons not already belonging to dbo.Persons
	INSERT Person (FullName)
	SELECT DISTINCT FullName 
	FROM (
		SELECT DISTINCT ShellPM AS FullName FROM stage.ProjectPerformance
		UNION ALL
		SELECT DISTINCT ShellCPFocalPoint AS FullName FROM stage.ProjectPerformance
		UNION ALL 
		SELECT DISTINCT ASContractorManager AS FullName FROM stage.ProjectPerformance
	) src
	WHERE FullName NOT IN (
		SELECT DISTINCT FullName FROM dbo.Person
	);

	-- INSERT supplier projects if not already mapped in dbo.SupplierProject
	MERGE dbo.SupplierProject sp
	USING (
		SELECT DISTINCT ProjectId, SupplierId 
		FROM stage.ProjectPerformance stage
		JOIN dbo.Supplier s ON stage.SupplierName = s.SupplierName
		JOIN dbo.Project p ON stage.ProjectName = p.ProjectName
	) AS src (ProjectId, SupplierId)
		ON sp.ProjectId = src.ProjectId AND sp.SupplierId = src.SupplierId
	WHEN NOT MATCHED THEN
		INSERT (ProjectId, SupplierId)
		VALUES (src.ProjectId, src.SupplierId);

	-- INSERT Project Evaluation Transaction
	MERGE dbo.ProjectEvaluation pe
	USING (
		SELECT DISTINCT
			ProjectId
			, DateId
			, ContractValueRange
			, SafetyScore
			, SafetyComment
			, CostScore
			, CostComment
			, ScheduleScore
			, ScheduleComment
			, QualityScore
			, QualityComment
			, ResponsivenessScore
			, ResponsivenessComment
			, InnovationScore
			, InnovationComment
			, pm.PersonId AS ShellPM
			, cm.PersonId AS ASContractorManager
			, cp.PersonId AS ShellCPFocalPoint
			, ProjectComment
			, GETDATE() AS LastModifiedDate, GETDATE() AS SubmitDate
		FROM stage.ProjectPerformance stage
		JOIN dbo.Project p ON stage.ProjectName = p.ProjectName
		JOIN dbo.SubmissionDate sd ON stage.Date = sd.YearQuarter
		LEFT JOIN dbo.Person pm ON stage.ShellPM = pm.FullName
		LEFT JOIN dbo.Person cm ON stage.ASContractorManager = cm.FullName
		LEFT JOIN dbo.Person cp ON stage.ShellCPFocalPoint = cp.FullName
	) AS src 
		(ProjectId, DateId, ContractValueRange
		, SafetyScore, SafetyComment
		, CostScore, CostComment
		, ScheduleScore, ScheduleComment
		, QualityScore, QualityComment
		, ResponsivenessScore, ResponsivenessComment
		, InnovationScore, InnovationComment
		, ShellPM, ASContractorManager, ShellCPFocalPoint
		, ProjectComment
		, LastModifiedDate, SubmitDate)
		ON pe.DateId = src.DateId AND pe.ProjectId = src.ProjectId
	WHEN NOT MATCHED THEN
		INSERT (ProjectId, DateId, ContractValueRange
			  , SafetyScore, SafetyComment
			  , CostScore, CostComment
			  , ScheduleScore, ScheduleComment
			  , QualityScore, QualityComment
			  , ResponsivenessScore, ResponsivenessComment
			  , InnovationScore, InnovationComment
			  , ShellPM, ASContractorManager, ShellCPFocalPoint
			  , ProjectComment
			  , LastModifiedDate, SubmitDate)
		VALUES (src.ProjectId, src.DateId, src.ContractValueRange
			  , src.SafetyScore, src.SafetyComment
			  , src.CostScore, src.CostComment
			  , src.ScheduleScore, src.ScheduleComment
			  , src.QualityScore, src.QualityComment
			  , src.ResponsivenessScore, src.ResponsivenessComment
			  , src.InnovationScore, src.InnovationComment
			  , src.ShellPM, src.ASContractorManager, src.ShellCPFocalPoint
			  , src.ProjectComment
			  , src.LastModifiedDate, src.SubmitDate)
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
			, ShellPM = src.ShellPM
			, ASContractorManager = src.ASContractorManager
			, ShellCPFocalPoint = src.ShellCPFocalPoint
			, ProjectComment = src.ProjectComment;

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
