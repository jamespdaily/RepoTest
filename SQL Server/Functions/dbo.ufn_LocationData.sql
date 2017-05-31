SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ufn_LocationData] (@COUNTRY VARCHAR(255))
RETURNS TABLE
AS
	RETURN
	( /*selection of country and city order reversed */
	SELECT
		IIF(CHARINDEX(',', @COUNTRY) > 0, LEFT(@COUNTRY, CHARINDEX(',', @COUNTRY) - 1), 'N/A') Country /*city previously*/
	   ,IIF(CHARINDEX(',', @COUNTRY) > 0, RIGHT(@COUNTRY, (LEN(@COUNTRY) - CHARINDEX(',', @COUNTRY)) - 1), @COUNTRY) City /*country previously*/
	);




GO
