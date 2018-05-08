CREATE TABLE [cmsMember2MemberGroup] (
  [Member] int  NOT NULL
, [MemberGroup] int  NOT NULL
);
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY ([Member]) REFERENCES [cmsMember]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY ([MemberGroup]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY ([Member],[MemberGroup]);