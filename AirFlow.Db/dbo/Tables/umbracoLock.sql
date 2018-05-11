CREATE TABLE [umbracoLock] (
  [id] int IDENTITY (1,1)  NOT NULL
, [value] int  NOT NULL
, [name] nvarchar(64)  NOT NULL
);
GO
ALTER TABLE [umbracoLock] ADD CONSTRAINT [PK_umbracoLock] PRIMARY KEY ([id]);