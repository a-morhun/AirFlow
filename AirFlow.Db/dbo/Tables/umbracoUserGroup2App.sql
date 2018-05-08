CREATE TABLE [umbracoUserGroup2App] (
  [userGroupId] int  NOT NULL
, [app] nvarchar(50)  NOT NULL
);
GO
ALTER TABLE [umbracoUserGroup2App] ADD CONSTRAINT [FK_umbracoUserGroup2App_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2App] ADD CONSTRAINT [PK_userGroup2App] PRIMARY KEY ([userGroupId],[app]);