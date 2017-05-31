SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_SELECT_AGG_Hours_Revenue]
	@UserName VARCHAR(50)
	,@Type INT
AS

IF @Type = 0

	SELECT 
		SUM(Hours)
		,SUM(CostAssociatedWithActualHours)
	FROM 
		DetailedUtilization du
		JOIN SupplierProject sp ON du.ProjectId = sp.ProjectId
		JOIN Supplier s ON sp.SupplierId = s.SupplierId
		JOIN Users u ON s.SupplierId = u.SupplierId
		JOIN SubmissionDate sd ON du.DateId = sd.DateId
	WHERE 
		u.UserName LIKE @UserName
		AND sd.Year = DATEPART(yy, GETDATE())

IF @Type = 1

	SELECT 
		SUM(Hours) Hours
		,SUM(CostAssociatedWithActualHours) Revenue
	FROM 
		DetailedUtilization du
		JOIN SupplierProject sp ON du.ProjectId = sp.ProjectId
		JOIN Supplier s ON sp.SupplierId = s.SupplierId
		JOIN Users u ON s.SupplierId = u.SupplierId
		JOIN SubmissionDate sd ON du.DateId = sd.DateId
	WHERE 
		u.UserName LIKE @UserName
		AND sd.Quarter = DATEPART(qq, GETDATE())
	


GO
