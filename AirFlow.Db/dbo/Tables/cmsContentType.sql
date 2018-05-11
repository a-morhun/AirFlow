CREATE TABLE [cmsContentType] (
  [pk] int IDENTITY (535,1)  NOT NULL
, [nodeId] int  NOT NULL
, [alias] nvarchar(255)  NULL
, [icon] nvarchar(255)  NULL
, [thumbnail] nvarchar(255) DEFAULT ('folder.png')  NOT NULL
, [description] nvarchar(1500)  NULL
, [isContainer] bit DEFAULT ('0') NOT NULL
, [allowAtRoot] bit DEFAULT ('0') NOT NULL
);
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [PK_cmsContentType] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [IX_cmsContentType] UNIQUE ([nodeId]);
GO
CREATE INDEX [IX_cmsContentType_icon] ON [cmsContentType] ([icon] ASC);