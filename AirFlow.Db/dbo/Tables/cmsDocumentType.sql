CREATE TABLE [cmsDocumentType] (
  [contentTypeNodeId] int  NOT NULL
, [templateNodeId] int  NOT NULL
, [IsDefault] bit DEFAULT ('0') NOT NULL
);
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY ([contentTypeNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY ([contentTypeNodeId],[templateNodeId]);