CREATE TABLE [umbracoMigration] (
  [id] int IDENTITY (101,1)  NOT NULL
, [name] nvarchar(255)  NOT NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [version] nvarchar(50)  NOT NULL
);
GO
ALTER TABLE [umbracoMigration] ADD CONSTRAINT [PK_umbracoMigration] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoMigration] ADD CONSTRAINT [IX_umbracoMigration] UNIQUE ([name],[version]);