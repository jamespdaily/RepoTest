SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[SupplierProject] (
		[SupplierProjectId]     [int] IDENTITY(1, 1) NOT NULL,
		[SupplierId]            [int] NULL,
		[ProjectId]             [int] NULL,
		CONSTRAINT [PK33]
		PRIMARY KEY
		NONCLUSTERED
		([SupplierProjectId])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SupplierProject]
	WITH CHECK
	ADD CONSTRAINT [RefProject89]
	FOREIGN KEY ([ProjectId]) REFERENCES [dbo].[Project] ([ProjectId])
ALTER TABLE [dbo].[SupplierProject]
	CHECK CONSTRAINT [RefProject89]

GO
ALTER TABLE [dbo].[SupplierProject]
	WITH CHECK
	ADD CONSTRAINT [RefSupplier88]
	FOREIGN KEY ([SupplierId]) REFERENCES [dbo].[Supplier] ([SupplierId])
ALTER TABLE [dbo].[SupplierProject]
	CHECK CONSTRAINT [RefSupplier88]

GO
ALTER TABLE [dbo].[SupplierProject] SET (LOCK_ESCALATION = TABLE)
GO
