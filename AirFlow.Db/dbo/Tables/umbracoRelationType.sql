CREATE TABLE [umbracoRelationType] (
  [id] int IDENTITY (3,1)  NOT NULL
, [typeUniqueId] uniqueidentifier NOT NULL
, [dual] bit NOT NULL
, [parentObjectType] uniqueidentifier NOT NULL
, [childObjectType] uniqueidentifier NOT NULL
, [name] nvarchar(255)  NOT NULL
, [alias] nvarchar(100)  NULL
);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_alias] UNIQUE ([alias]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_name] UNIQUE ([name]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_UniqueId] UNIQUE ([typeUniqueId]);