CREATE TABLE [cmsContentXml] (
  [nodeId] int  NOT NULL
, [xml] ntext NOT NULL
);
GO
ALTER TABLE [cmsContentXml] ADD CONSTRAINT [PK_cmsContentXml] PRIMARY KEY ([nodeId]);