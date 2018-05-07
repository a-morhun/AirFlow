CREATE TABLE [umbracoRedirectUrl] (
  [id] uniqueidentifier NOT NULL
, [contentKey] uniqueidentifier NOT NULL
, [createDateUtc] datetime NOT NULL
, [url] nvarchar(255)  NOT NULL
, [urlHash] nvarchar(40)  NOT NULL
);
GO
ALTER TABLE [umbracoRedirectUrl] ADD CONSTRAINT [PK_umbracoRedirectUrl] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoRedirectUrl] ADD CONSTRAINT [IX_umbracoRedirectUrl] UNIQUE ([urlHash],[contentKey],[createDateUtc]);