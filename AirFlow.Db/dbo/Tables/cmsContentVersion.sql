CREATE TABLE [cmsContentVersion] (
  [id] int IDENTITY (1,1)  NOT NULL
, [ContentId] int  NOT NULL
, [VersionId] uniqueidentifier NOT NULL
, [VersionDate] datetime DEFAULT (GETDATE()) NOT NULL
);
GO
ALTER TABLE [cmsContentVersion] ADD CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsContentVersion] ADD CONSTRAINT [IX_cmsContentVersion_VersionId] UNIQUE ([VersionId]);
GO
CREATE INDEX [IX_cmsContentVersion_ContentId] ON [cmsContentVersion] ([ContentId] ASC);