SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DANGER_Database_Cleaner] AS

TRUNCATE TABLE SHELL_SRM_V2.dbo.ForecastUtilization
TRUNCATE TABLE [SHELL_SRM_V2].[dbo].[DetailedUtilization]
TRUNCATE TABLE dbo.SupplierProject
DELETE FROM Supplier
DBCC CHECKIDENT ('Supplier', RESEED, 0)
DELETE FROM Project
DBCC CHECKIDENT ('Project', RESEED, 0)
DELETE FROM Client
DBCC CHECKIDENT ('Client', RESEED, 0)
DELETE FROM Scope
DBCC CHECKIDENT ('Scope', RESEED, 0)
DELETE FROM Country
DBCC CHECKIDENT ('Country', RESEED, 0)
DELETE FROM stage.DetailedUtilization

GO