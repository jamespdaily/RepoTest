SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ufn_CleanNumber](@input NVARCHAR(255))  
RETURNS DECIMAL(18,2)  
AS   
BEGIN  
    DECLARE @output DECIMAL(18,2);  
    SELECT @output = IIF(@input IN ('-', 'N/A', 'TBC'), NULL,
		CAST(REPLACE(REPLACE(@input, '$', ''), ',', '') AS DECIMAL(18,2)))
    RETURN ISNULL(@output, 0);  
END;  

GO
