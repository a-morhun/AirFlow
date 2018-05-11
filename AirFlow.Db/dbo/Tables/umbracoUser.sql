CREATE TABLE [umbracoUser] (
  [id] int IDENTITY (1,1)  NOT NULL
, [userDisabled] bit DEFAULT ('0') NOT NULL
, [userNoConsole] bit DEFAULT ('0') NOT NULL
, [userName] nvarchar(255)  NOT NULL
, [userLogin] nvarchar(125)  NOT NULL
, [userPassword] nvarchar(500)  NOT NULL
, [passwordConfig] nvarchar(500)  NULL
, [userEmail] nvarchar(255)  NOT NULL
, [userLanguage] nvarchar(10)  NULL
, [securityStampToken] nvarchar(255)  NULL
, [failedLoginAttempts] int  NULL
, [lastLockoutDate] datetime NULL
, [lastPasswordChangeDate] datetime NULL
, [lastLoginDate] datetime NULL
, [emailConfirmedDate] datetime NULL
, [invitedDate] datetime NULL
, [createDate] datetime DEFAULT (GETDATE()) NOT NULL
, [updateDate] datetime DEFAULT (GETDATE()) NOT NULL
, [avatar] nvarchar(500)  NULL
, [tourData] ntext NULL
);
GO
ALTER TABLE [umbracoUser] ADD CONSTRAINT [PK_user] PRIMARY KEY ([id]);
GO
CREATE INDEX [IX_umbracoUser_userLogin] ON [umbracoUser] ([userLogin] ASC);