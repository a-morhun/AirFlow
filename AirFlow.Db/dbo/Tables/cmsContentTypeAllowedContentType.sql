CREATE TABLE [cmsContentTypeAllowedContentType] (
  [Id] int  NOT NULL
, [AllowedId] int  NOT NULL
, [SortOrder] int DEFAULT ('0')  NOT NULL
);
GO
ALTER TABLE [cmsContentTypeAllowedContentType] ADD CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY ([Id],[AllowedId]);