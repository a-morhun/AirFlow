CREATE TABLE [cmsMedia] (
  [nodeId] int  NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [mediaPath] nvarchar(255)  NULL
);
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [FK_cmsMedia_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [PK_cmsMedia] PRIMARY KEY ([versionId]);
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [IX_cmsMedia] UNIQUE ([nodeId],[versionId],[mediaPath]);