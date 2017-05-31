SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[usp_delete_mirror_DetailedUtilization]

@UserID nvarchar(50) = NULL
AS



	delete from [mirror].[DetailedUtilization] where UserID = @UserID
GO
