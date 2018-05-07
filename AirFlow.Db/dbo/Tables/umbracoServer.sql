CREATE TABLE [umbracoServer] (
  [id] int IDENTITY (2,1)  NOT NULL
, [address] nvarchar(500)  NOT NULL
, [computerName] nvarchar(255)  NOT NULL
, [registeredDate] datetime DEFAULT (GETDATE()) NOT NULL
, [lastNotifiedDate] datetime NOT NULL
, [isActive] bit NOT NULL
, [isMaster] bit NOT NULL
);
GO
ALTER TABLE [umbracoServer] ADD CONSTRAINT [PK_umbracoServer] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoServer] ADD CONSTRAINT [IX_computerName] UNIQUE ([computerName]);
GO
CREATE INDEX [IX_umbracoServer_isActive] ON [umbracoServer] ([isActive] ASC);