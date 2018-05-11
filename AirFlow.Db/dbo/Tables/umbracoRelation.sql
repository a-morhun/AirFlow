CREATE TABLE [umbracoRelation] (
  [id] int IDENTITY (1,1)  NOT NULL
, [parentId] int  NOT NULL
, [childId] int  NOT NULL
, [relType] int  NOT NULL
, [datetime] datetime DEFAULT (GETDATE()) NOT NULL
, [comment] nvarchar(1000)  NOT NULL
);
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY ([parentId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY ([childId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY ([relType]) REFERENCES [umbracoRelationType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [PK_umbracoRelation] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [IX_umbracoRelation_parentChildType] UNIQUE ([parentId],[childId],[relType]);