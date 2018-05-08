CREATE TABLE [umbracoAccessRule] (
  [id] uniqueidentifier NOT NULL
, [accessId] uniqueidentifier NOT NULL
, [ruleValue] nvarchar(255)  NOT NULL
, [ruleType] nvarchar(255)  NOT NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [updateDate] datetime DEFAULT (GETDATE()) NOT NULL
);
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY ([accessId]) REFERENCES [umbracoAccess]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [IX_umbracoAccessRule] UNIQUE ([ruleValue],[ruleType],[accessId]);