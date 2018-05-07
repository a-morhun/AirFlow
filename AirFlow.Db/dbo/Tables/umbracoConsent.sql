CREATE TABLE [umbracoConsent] (
  [id] int IDENTITY (1,1)  NOT NULL
, [current] bit NOT NULL
, [source] nvarchar(512)  NOT NULL
, [context] nvarchar(128)  NOT NULL
, [action] nvarchar(512)  NOT NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [state] int  NOT NULL
, [comment] nvarchar(255)  NOT NULL
);
GO
ALTER TABLE [umbracoConsent] ADD CONSTRAINT [PK_umbracoConsent] PRIMARY KEY ([id]);