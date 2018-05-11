CREATE TABLE [umbracoLog] (
  [id] int IDENTITY (2,1)  NOT NULL
, [userId] int  NOT NULL
, [NodeId] int  NOT NULL
, [Datestamp] datetime DEFAULT (GETDATE()) NOT NULL
, [logHeader] nvarchar(50)  NOT NULL
, [logComment] nvarchar(4000)  NULL
);
GO
ALTER TABLE [umbracoLog] ADD CONSTRAINT [PK_umbracoLog] PRIMARY KEY ([id]);
GO
CREATE INDEX [IX_umbracoLog] ON [umbracoLog] ([NodeId] ASC);