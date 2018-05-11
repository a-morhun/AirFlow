CREATE TABLE [umbracoUserStartNode] (
  [id] int IDENTITY (1,1)  NOT NULL
, [userId] int  NOT NULL
, [startNode] int  NOT NULL
, [startNodeType] int  NOT NULL
);
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [FK_umbracoUserStartNode_umbracoNode_id] FOREIGN KEY ([startNode]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [FK_umbracoUserStartNode_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [PK_userStartNode] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [IX_umbracoUserStartNode_startNodeType] UNIQUE ([startNodeType],[startNode],[userId]);