CREATE TABLE [umbracoAccess] (
  [id] uniqueidentifier NOT NULL
, [nodeId] int  NOT NULL
, [loginNodeId] int  NOT NULL
, [noAccessNodeId] int  NOT NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [updateDate] datetime DEFAULT (GETDATE()) NOT NULL
);
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY ([loginNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY ([noAccessNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [PK_umbracoAccess] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [IX_umbracoAccess_nodeId] UNIQUE ([nodeId]);