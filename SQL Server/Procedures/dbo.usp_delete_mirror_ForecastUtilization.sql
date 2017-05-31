SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[usp_delete_mirror_ForecastUtilization]

@UserID nvarchar(50) = NULL
AS



	delete from [mirror].[ForecastUtilization] where UserID = @UserID
GO
