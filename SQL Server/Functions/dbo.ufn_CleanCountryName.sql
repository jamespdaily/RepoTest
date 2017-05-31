SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufn_CleanCountryName](@input NVARCHAR(255))  
RETURNS VARCHAR(255)  
AS   
BEGIN  
    DECLARE @output VARCHAR(255);  
    SELECT @output = 
	CASE 
		WHEN @input = 'UK' THEN 'United Kingdom'
		WHEN @input = 'The Netherlands' THEN 'Netherlands'
		ELSE @input
	END

RETURN @output;  
END;  

GO
