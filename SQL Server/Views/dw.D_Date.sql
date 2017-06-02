SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dw].[D_Date] 
AS
SELECT DISTINCT 
-- Testing
	DateId AS DateSID
	, Year 
	, Quarter
	, REPLACE(YearQuarter,' ','-') AS YearQuarter
	, IIF(Year = DATEPART(yy, GETDATE()), IIF(Quarter = DATEPART(qq, GETDATE()), 1, 0), 0) AS CurrentForecast
FROM dbo.SubmissionDate



GO
