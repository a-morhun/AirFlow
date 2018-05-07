CREATE TABLE [umbracoUser2NodeNotify] (
  [userId] int  NOT NULL
, [nodeId] int  NOT NULL
, [action] nchar(1)  NOT NULL
);
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY ([userId],[nodeId],[action]);