CREATE TABLE [umbracoUserGroup] (
  [id] int IDENTITY (6,1)  NOT NULL
, [userGroupAlias] nvarchar(200)  NOT NULL
, [userGroupName] nvarchar(200)  NOT NULL
, [userGroupDefaultPermissions] nvarchar(50)  NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [updateDate] datetime DEFAULT (GETDATE()) NOT NULL
, [icon] nvarchar(255)  NULL
, [startContentId] int  NULL
, [startMediaId] int  NULL
);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [FK_startContentId_umbracoNode_id] FOREIGN KEY ([startContentId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [FK_startMediaId_umbracoNode_id] FOREIGN KEY ([startMediaId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [PK_umbracoUserGroup] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [IX_umbracoUserGroup_userGroupAlias] UNIQUE ([userGroupAlias]);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [IX_umbracoUserGroup_userGroupName] UNIQUE ([userGroupName]);