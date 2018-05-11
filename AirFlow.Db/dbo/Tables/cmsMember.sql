CREATE TABLE [cmsMember] (
  [nodeId] int  NOT NULL
, [Email] nvarchar(1000) DEFAULT ('''')  NOT NULL
, [LoginName] nvarchar(1000) DEFAULT ('''')  NOT NULL
, [Password] nvarchar(1000) DEFAULT ('''')  NOT NULL
);
GO
ALTER TABLE [cmsMember] ADD CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember] ADD CONSTRAINT [PK_cmsMember] PRIMARY KEY ([nodeId]);
GO
CREATE INDEX [IX_cmsMember_LoginName] ON [cmsMember] ([LoginName] ASC);