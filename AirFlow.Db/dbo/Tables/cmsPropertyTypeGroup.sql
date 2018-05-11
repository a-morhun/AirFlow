CREATE TABLE [cmsPropertyTypeGroup] (
  [id] int IDENTITY (12,1)  NOT NULL
, [contenttypeNodeId] int  NOT NULL
, [text] nvarchar(255)  NOT NULL
, [sortorder] int  NOT NULL
, [uniqueID] uniqueidentifier DEFAULT (NEWID()) NOT NULL
);
GO
ALTER TABLE [cmsPropertyTypeGroup] ADD CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPropertyTypeGroup] ADD CONSTRAINT [IX_cmsPropertyTypeGroupUniqueID] UNIQUE ([uniqueID]);