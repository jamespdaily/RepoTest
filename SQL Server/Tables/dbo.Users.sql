SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users] (
		[UserId]         [int] IDENTITY(1, 1) NOT NULL,
		[UserName]       [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[SupplierId]     [int] NOT NULL,
		CONSTRAINT [PK25]
		PRIMARY KEY
		NONCLUSTERED
		([UserId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Users]
	WITH CHECK
	ADD CONSTRAINT [RefSupplier83]
	FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Supplier] ([SupplierId])
ALTER TABLE [dbo].[Users]
	CHECK CONSTRAINT [RefSupplier83]

GO
ALTER TABLE [dbo].[Users] SET (LOCK_ESCALATION = TABLE)
GO
