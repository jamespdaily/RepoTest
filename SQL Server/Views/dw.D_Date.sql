SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dw].[D_Date] 
AS
SELECT DISTINCT 
	DateId AS DateSID
	, Year 
	, Quarter
	, REPLACE(YearQuarter,' ','-') AS YearQuarter
FROM dbo.SubmissionDate


GO
