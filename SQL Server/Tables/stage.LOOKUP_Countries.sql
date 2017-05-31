SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [stage].[LOOKUP_Countries] (
		[countrycode]       [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[continentName]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[countryName]       [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[Is HVEC?]          [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [stage].[LOOKUP_Countries] SET (LOCK_ESCALATION = TABLE)
GO
