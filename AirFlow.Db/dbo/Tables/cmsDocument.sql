CREATE TABLE [cmsDocument] (
  [nodeId] int  NOT NULL
, [published] bit NOT NULL
, [documentUser] int  NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [text] nvarchar(255)  NOT NULL
, [releaseDate] datetime NULL
, [expireDate] datetime NULL
, [updateDate] datetime DEFAULT (GETDATE()) NOT NULL
, [templateId] int  NULL
, [newest] bit DEFAULT ('0') NOT NULL
);
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [PK_cmsDocument] PRIMARY KEY ([versionId]);
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [IX_cmsDocument] UNIQUE ([nodeId],[versionId]);
GO
CREATE INDEX [IX_cmsDocument_newest] ON [cmsDocument] ([newest] ASC);
GO
CREATE INDEX [IX_cmsDocument_published] ON [cmsDocument] ([published] ASC);