CREATE TABLE [cmsContent] (
  [pk] int IDENTITY (1,1)  NOT NULL
, [nodeId] int  NOT NULL
, [contentType] int  NOT NULL
);
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [PK_cmsContent] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [IX_cmsContent] UNIQUE ([nodeId]);