CREATE TABLE [umbracoNode] (
  [id] int IDENTITY (1060,1)  NOT NULL
, [trashed] bit DEFAULT ('0') NOT NULL
, [parentID] int  NOT NULL
, [nodeUser] int  NULL
, [level] int  NOT NULL
, [path] nvarchar(150)  NOT NULL
, [sortOrder] int  NOT NULL
, [uniqueID] uniqueidentifier DEFAULT (NEWID()) NOT NULL
, [text] nvarchar(255)  NULL
, [nodeObjectType] uniqueidentifier NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
);
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY ([parentID]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [PK_structure] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [IX_umbracoNodeUniqueID] UNIQUE ([uniqueID]);
GO
CREATE INDEX [IX_umbracoNodeObjectType] ON [umbracoNode] ([nodeObjectType] ASC);
GO
CREATE INDEX [IX_umbracoNodeParentId] ON [umbracoNode] ([parentID] ASC);
GO
CREATE INDEX [IX_umbracoNodePath] ON [umbracoNode] ([path] ASC);
GO
CREATE INDEX [IX_umbracoNodeTrashed] ON [umbracoNode] ([trashed] ASC);