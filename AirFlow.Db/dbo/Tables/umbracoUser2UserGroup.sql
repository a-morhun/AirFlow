CREATE TABLE [umbracoUser2UserGroup] (
  [userId] int  NOT NULL
, [userGroupId] int  NOT NULL
);
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [PK_user2userGroup] PRIMARY KEY ([userId],[userGroupId]);