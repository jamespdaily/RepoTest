SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [mirror].[EngineeringProductivity] (
		[F1]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F2]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F3]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F4]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F5]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F6]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F7]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F8]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F9]             [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F10]            [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F11]            [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F12]            [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F13]            [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[F14]            [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[DateLoaded]     [datetime] NULL,
		[SourceFile]     [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [mirror].[EngineeringProductivity] SET (LOCK_ESCALATION = TABLE)
GO
