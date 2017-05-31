SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[CountryCity] (
		[CountryCityId]     [int] IDENTITY(1, 1) NOT NULL,
		[CityId]            [int] NOT NULL,
		[CountryId]         [int] NOT NULL,
		CONSTRAINT [Pk_CountryCity]
		PRIMARY KEY
		CLUSTERED
		([CountryCityId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryCity]
	WITH CHECK
	ADD CONSTRAINT [fk_CountryCity]
	FOREIGN KEY ([CountryId]) REFERENCES [dbo].[Country] ([CountryId])
ALTER TABLE [dbo].[CountryCity]
	CHECK CONSTRAINT [fk_CountryCity]

GO
ALTER TABLE [dbo].[CountryCity]
	WITH CHECK
	ADD CONSTRAINT [fk_CountryCity_0]
	FOREIGN KEY ([CityId]) REFERENCES [dbo].[City] ([CityId])
ALTER TABLE [dbo].[CountryCity]
	CHECK CONSTRAINT [fk_CountryCity_0]

GO
CREATE NONCLUSTERED INDEX [idx_CountryCity]
	ON [dbo].[CountryCity] ([CountryId])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryCity] SET (LOCK_ESCALATION = TABLE)
GO
