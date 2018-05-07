CREATE TABLE [cmsDataType] (
  [pk] int IDENTITY (40,1)  NOT NULL
, [nodeId] int  NOT NULL
, [propertyEditorAlias] nvarchar(255)  NOT NULL
, [dbType] nvarchar(50)  NOT NULL
);
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [PK_cmsDataType] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [IX_cmsDataType_nodeId] UNIQUE ([nodeId]);