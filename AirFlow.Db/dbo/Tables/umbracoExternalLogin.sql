CREATE TABLE [umbracoExternalLogin] (
  [id] int IDENTITY (1,1)  NOT NULL
, [userId] int  NOT NULL
, [loginProvider] nvarchar(4000)  NOT NULL
, [providerKey] nvarchar(4000)  NOT NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
);
GO
ALTER TABLE [umbracoExternalLogin] ADD CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY ([id]);