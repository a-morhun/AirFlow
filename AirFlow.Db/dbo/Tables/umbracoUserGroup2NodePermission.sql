CREATE TABLE [umbracoUserGroup2NodePermission] (
  [userGroupId] int  NOT NULL
, [nodeId] int  NOT NULL
, [permission] nvarchar(255)  NOT NULL
);
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [PK_umbracoUserGroup2NodePermission] PRIMARY KEY ([userGroupId],[nodeId],[permission]);
GO
CREATE INDEX [IX_umbracoUser2NodePermission_nodeId] ON [umbracoUserGroup2NodePermission] ([nodeId] ASC);