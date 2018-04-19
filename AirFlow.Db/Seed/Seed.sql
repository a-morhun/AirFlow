-- Script Date: 19/04/2018 10:42  - ErikEJ.SqlCeScripting version 3.5.2.75
CREATE TABLE [umbracoUser] (
  [id] int IDENTITY (2,1)  NOT NULL
, [userDisabled] bit DEFAULT '0' NOT NULL
, [userNoConsole] bit DEFAULT '0' NOT NULL
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
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
, [avatar] nvarchar(500)  NULL
, [tourData] ntext NULL
);
GO
CREATE TABLE [umbracoUserLogin] (
  [sessionId] uniqueidentifier NOT NULL
, [userId] int  NOT NULL
, [loggedInUtc] datetime NOT NULL
, [lastValidatedUtc] datetime NOT NULL
, [loggedOutUtc] datetime NULL
, [ipAddress] nvarchar(255)  NULL
);
GO
CREATE TABLE [umbracoServer] (
  [id] int IDENTITY (2,1)  NOT NULL
, [address] nvarchar(500)  NOT NULL
, [computerName] nvarchar(255)  NOT NULL
, [registeredDate] datetime DEFAULT (getdate()) NOT NULL
, [lastNotifiedDate] datetime NOT NULL
, [isActive] bit NOT NULL
, [isMaster] bit NOT NULL
);
GO
CREATE TABLE [umbracoRelationType] (
  [id] int IDENTITY (3,1)  NOT NULL
, [typeUniqueId] uniqueidentifier NOT NULL
, [dual] bit NOT NULL
, [parentObjectType] uniqueidentifier NOT NULL
, [childObjectType] uniqueidentifier NOT NULL
, [name] nvarchar(255)  NOT NULL
, [alias] nvarchar(100)  NULL
);
GO
CREATE TABLE [umbracoNode] (
  [id] int IDENTITY (1133,1)  NOT NULL
, [trashed] bit DEFAULT '0' NOT NULL
, [parentID] int  NOT NULL
, [nodeUser] int  NULL
, [level] int  NOT NULL
, [path] nvarchar(150)  NOT NULL
, [sortOrder] int  NOT NULL
, [uniqueID] uniqueidentifier DEFAULT (newid()) NOT NULL
, [text] nvarchar(255)  NULL
, [nodeObjectType] uniqueidentifier NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
);
GO
CREATE TABLE [umbracoUserStartNode] (
  [id] int IDENTITY (2,1)  NOT NULL
, [userId] int  NOT NULL
, [startNode] int  NOT NULL
, [startNodeType] int  NOT NULL
);
GO
CREATE TABLE [umbracoUserGroup] (
  [id] int IDENTITY (6,1)  NOT NULL
, [userGroupAlias] nvarchar(200)  NOT NULL
, [userGroupName] nvarchar(200)  NOT NULL
, [userGroupDefaultPermissions] nvarchar(50)  NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
, [icon] nvarchar(255)  NULL
, [startContentId] int  NULL
, [startMediaId] int  NULL
);
GO
CREATE TABLE [umbracoUserGroup2NodePermission] (
  [userGroupId] int  NOT NULL
, [nodeId] int  NOT NULL
, [permission] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [umbracoUserGroup2App] (
  [userGroupId] int  NOT NULL
, [app] nvarchar(50)  NOT NULL
);
GO
CREATE TABLE [umbracoUser2UserGroup] (
  [userId] int  NOT NULL
, [userGroupId] int  NOT NULL
);
GO
CREATE TABLE [umbracoUser2NodeNotify] (
  [userId] int  NOT NULL
, [nodeId] int  NOT NULL
, [action] nchar(1)  NOT NULL
);
GO
CREATE TABLE [umbracoRelation] (
  [id] int IDENTITY (5,1)  NOT NULL
, [parentId] int  NOT NULL
, [childId] int  NOT NULL
, [relType] int  NOT NULL
, [datetime] datetime DEFAULT (getdate()) NOT NULL
, [comment] nvarchar(1000)  NOT NULL
);
GO
CREATE TABLE [umbracoRedirectUrl] (
  [id] uniqueidentifier NOT NULL
, [contentKey] uniqueidentifier NOT NULL
, [createDateUtc] datetime NOT NULL
, [url] nvarchar(255)  NOT NULL
, [urlHash] nvarchar(40)  NOT NULL
);
GO
CREATE TABLE [umbracoMigration] (
  [id] int IDENTITY (4,1)  NOT NULL
, [name] nvarchar(255)  NOT NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [version] nvarchar(50)  NOT NULL
);
GO
CREATE TABLE [umbracoLog] (
  [id] int IDENTITY (104,1)  NOT NULL
, [userId] int  NOT NULL
, [NodeId] int  NOT NULL
, [Datestamp] datetime DEFAULT (getdate()) NOT NULL
, [logHeader] nvarchar(50)  NOT NULL
, [logComment] nvarchar(4000)  NULL
);
GO
CREATE TABLE [umbracoLock] (
  [id] int IDENTITY (2,1)  NOT NULL
, [value] int  NOT NULL
, [name] nvarchar(64)  NOT NULL
);
GO
CREATE TABLE [umbracoLanguage] (
  [id] int IDENTITY (2,1)  NOT NULL
, [languageISOCode] nvarchar(10)  NULL
, [languageCultureName] nvarchar(100)  NULL
);
GO
CREATE TABLE [umbracoExternalLogin] (
  [id] int IDENTITY (2,1)  NOT NULL
, [userId] int  NOT NULL
, [loginProvider] nvarchar(4000)  NOT NULL
, [providerKey] nvarchar(4000)  NOT NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
);
GO
CREATE TABLE [umbracoDomains] (
  [id] int IDENTITY (2,1)  NOT NULL
, [domainDefaultLanguage] int  NULL
, [domainRootStructureID] int  NULL
, [domainName] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [umbracoConsent] (
  [id] int IDENTITY (2,1)  NOT NULL
, [current] bit NOT NULL
, [source] nvarchar(512)  NOT NULL
, [context] nvarchar(128)  NOT NULL
, [action] nvarchar(512)  NOT NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [state] int  NOT NULL
, [comment] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [umbracoCacheInstruction] (
  [id] int IDENTITY (180,1)  NOT NULL
, [utcStamp] datetime NOT NULL
, [jsonInstruction] ntext NOT NULL
, [originated] nvarchar(500)  NOT NULL
, [instructionCount] int DEFAULT '1'  NOT NULL
);
GO
CREATE TABLE [umbracoAudit] (
  [id] int IDENTITY (286,1)  NOT NULL
, [performingUserId] int  NOT NULL
, [performingDetails] nvarchar(1024)  NULL
, [performingIp] nvarchar(64)  NULL
, [eventDateUtc] datetime DEFAULT (getdate()) NOT NULL
, [affectedUserId] int  NOT NULL
, [affectedDetails] nvarchar(1024)  NULL
, [eventType] nvarchar(256)  NOT NULL
, [eventDetails] nvarchar(1024)  NULL
);
GO
CREATE TABLE [umbracoAccess] (
  [id] uniqueidentifier NOT NULL
, [nodeId] int  NOT NULL
, [loginNodeId] int  NOT NULL
, [noAccessNodeId] int  NOT NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
);
GO
CREATE TABLE [umbracoAccessRule] (
  [id] uniqueidentifier NOT NULL
, [accessId] uniqueidentifier NOT NULL
, [ruleValue] nvarchar(255)  NOT NULL
, [ruleType] nvarchar(255)  NOT NULL
, [createDate] datetime DEFAULT (getdate()) NOT NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
);
GO
CREATE TABLE [UFUserSecurity] (
  [User] nvarchar(50)  NOT NULL
, [ManageDataSources] bit NOT NULL
, [ManagePreValueSources] bit NOT NULL
, [ManageWorkflows] bit NOT NULL
, [ManageForms] bit NOT NULL
);
GO
CREATE TABLE [UFUserFormSecurity] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [User] nvarchar(50)  NOT NULL
, [Form] uniqueidentifier NOT NULL
, [HasAccess] bit NOT NULL
, [AllowInEditor] bit NOT NULL
, [SecurityType] int  NOT NULL
);
GO
CREATE TABLE [UFRecords] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Form] uniqueidentifier NOT NULL
, [Created] datetime NOT NULL
, [Updated] datetime NOT NULL
, [CurrentPage] uniqueidentifier NULL
, [UmbracoPageId] int  NULL
, [IP] nvarchar(255)  NULL
, [MemberKey] nvarchar(255)  NULL
, [UniqueId] uniqueidentifier NOT NULL
, [State] nvarchar(50)  NULL
, [RecordData] ntext NOT NULL
);
GO
CREATE TABLE [UFRecordFields] (
  [Key] uniqueidentifier NOT NULL
, [FieldId] uniqueidentifier NOT NULL
, [Record] int  NOT NULL
, [Alias] nvarchar(255)  NOT NULL
, [DataType] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [UFRecordDataString] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Key] uniqueidentifier NOT NULL
, [Value] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [UFRecordDataLongString] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Key] uniqueidentifier NOT NULL
, [Value] ntext NULL
);
GO
CREATE TABLE [UFRecordDataInteger] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Key] uniqueidentifier NOT NULL
, [Value] int  NULL
);
GO
CREATE TABLE [UFRecordDataDateTime] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Key] uniqueidentifier NOT NULL
, [Value] datetime NULL
);
GO
CREATE TABLE [UFRecordDataBit] (
  [Id] int IDENTITY (2,1)  NOT NULL
, [Key] uniqueidentifier NOT NULL
, [Value] bit NULL
);
GO
CREATE TABLE [cmsTemplate] (
  [pk] int IDENTITY (15,1)  NOT NULL
, [nodeId] int  NOT NULL
, [alias] nvarchar(100)  NULL
, [design] ntext NOT NULL
);
GO
CREATE TABLE [cmsTaskType] (
  [id] int IDENTITY (2,1)  NOT NULL
, [alias] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [cmsTask] (
  [closed] bit DEFAULT '0' NOT NULL
, [id] int IDENTITY (2,1)  NOT NULL
, [taskTypeId] int  NOT NULL
, [nodeId] int  NOT NULL
, [parentUserId] int  NOT NULL
, [userId] int  NOT NULL
, [DateTime] datetime DEFAULT (getdate()) NOT NULL
, [Comment] nvarchar(500)  NULL
);
GO
CREATE TABLE [cmsTags] (
  [id] int IDENTITY (2,1)  NOT NULL
, [tag] nvarchar(200)  NULL
, [ParentId] int  NULL
, [group] nvarchar(100)  NULL
);
GO
CREATE TABLE [cmsMacro] (
  [id] int IDENTITY (2,1)  NOT NULL
, [uniqueId] uniqueidentifier NOT NULL
, [macroUseInEditor] bit DEFAULT '0' NOT NULL
, [macroRefreshRate] int DEFAULT '0'  NOT NULL
, [macroAlias] nvarchar(255)  NOT NULL
, [macroName] nvarchar(255)  NULL
, [macroScriptType] nvarchar(255)  NULL
, [macroScriptAssembly] nvarchar(255)  NULL
, [macroXSLT] nvarchar(255)  NULL
, [macroCacheByPage] bit DEFAULT '1' NOT NULL
, [macroCachePersonalized] bit DEFAULT '0' NOT NULL
, [macroDontRender] bit DEFAULT '0' NOT NULL
, [macroPython] nvarchar(255)  NULL
);
GO
CREATE TABLE [cmsMacroProperty] (
  [id] int IDENTITY (4,1)  NOT NULL
, [uniquePropertyId] uniqueidentifier NOT NULL
, [editorAlias] nvarchar(255)  NOT NULL
, [macro] int  NOT NULL
, [macroPropertySortOrder] int DEFAULT '0'  NOT NULL
, [macroPropertyAlias] nvarchar(50)  NOT NULL
, [macroPropertyName] nvarchar(255)  NOT NULL
);
GO
CREATE TABLE [cmsDictionary] (
  [pk] int IDENTITY (2,1)  NOT NULL
, [id] uniqueidentifier NOT NULL
, [parent] uniqueidentifier NULL
, [key] nvarchar(450)  NOT NULL
);
GO
CREATE TABLE [cmsLanguageText] (
  [pk] int IDENTITY (2,1)  NOT NULL
, [languageId] int  NOT NULL
, [UniqueId] uniqueidentifier NOT NULL
, [value] nvarchar(1000)  NOT NULL
);
GO
CREATE TABLE [cmsDataType] (
  [pk] int IDENTITY (31,1)  NOT NULL
, [nodeId] int  NOT NULL
, [propertyEditorAlias] nvarchar(255)  NOT NULL
, [dbType] nvarchar(50)  NOT NULL
);
GO
CREATE TABLE [cmsDataTypePreValues] (
  [id] int IDENTITY (7,1)  NOT NULL
, [datatypeNodeId] int  NOT NULL
, [value] ntext NULL
, [sortorder] int  NOT NULL
, [alias] nvarchar(50)  NULL
);
GO
CREATE TABLE [cmsContentType2ContentType] (
  [parentContentTypeId] int  NOT NULL
, [childContentTypeId] int  NOT NULL
);
GO
CREATE TABLE [cmsContentType] (
  [pk] int IDENTITY (545,1)  NOT NULL
, [nodeId] int  NOT NULL
, [alias] nvarchar(255)  NULL
, [icon] nvarchar(255)  NULL
, [thumbnail] nvarchar(255) DEFAULT 'folder.png'  NOT NULL
, [description] nvarchar(1500)  NULL
, [isContainer] bit DEFAULT '0' NOT NULL
, [allowAtRoot] bit DEFAULT '0' NOT NULL
);
GO
CREATE TABLE [cmsPropertyTypeGroup] (
  [id] int IDENTITY (12,1)  NOT NULL
, [contenttypeNodeId] int  NOT NULL
, [text] nvarchar(255)  NOT NULL
, [sortorder] int  NOT NULL
, [uniqueID] uniqueidentifier DEFAULT (newid()) NOT NULL
);
GO
CREATE TABLE [cmsPropertyType] (
  [id] int IDENTITY (37,1)  NOT NULL
, [dataTypeId] int  NOT NULL
, [contentTypeId] int  NOT NULL
, [propertyTypeGroupId] int  NULL
, [Alias] nvarchar(255)  NOT NULL
, [Name] nvarchar(255)  NULL
, [sortOrder] int DEFAULT '0'  NOT NULL
, [mandatory] bit DEFAULT '0' NOT NULL
, [validationRegExp] nvarchar(255)  NULL
, [Description] nvarchar(2000)  NULL
, [UniqueID] uniqueidentifier DEFAULT (newid()) NOT NULL
);
GO
CREATE TABLE [cmsPropertyData] (
  [id] int IDENTITY (415,1)  NOT NULL
, [contentNodeId] int  NOT NULL
, [versionId] uniqueidentifier NULL
, [propertytypeid] int  NOT NULL
, [dataInt] int  NULL
, [dataDecimal] numeric(38,6)  NULL
, [dataDate] datetime NULL
, [dataNvarchar] nvarchar(500)  NULL
, [dataNtext] ntext NULL
);
GO
CREATE TABLE [cmsMemberType] (
  [pk] int IDENTITY (10,1)  NOT NULL
, [NodeId] int  NOT NULL
, [propertytypeId] int  NOT NULL
, [memberCanEdit] bit DEFAULT '0' NOT NULL
, [viewOnProfile] bit DEFAULT '0' NOT NULL
, [isSensitive] bit DEFAULT '0' NOT NULL
);
GO
CREATE TABLE [cmsDocumentType] (
  [contentTypeNodeId] int  NOT NULL
, [templateNodeId] int  NOT NULL
, [IsDefault] bit DEFAULT '0' NOT NULL
);
GO
CREATE TABLE [cmsContentTypeAllowedContentType] (
  [Id] int  NOT NULL
, [AllowedId] int  NOT NULL
, [SortOrder] int DEFAULT '0'  NOT NULL
);
GO
CREATE TABLE [cmsContent] (
  [pk] int IDENTITY (56,1)  NOT NULL
, [nodeId] int  NOT NULL
, [contentType] int  NOT NULL
);
GO
CREATE TABLE [cmsTagRelationship] (
  [nodeId] int  NOT NULL
, [tagId] int  NOT NULL
, [propertyTypeId] int  NOT NULL
);
GO
CREATE TABLE [cmsMember] (
  [nodeId] int  NOT NULL
, [Email] nvarchar(1000) DEFAULT ''''  NOT NULL
, [LoginName] nvarchar(1000) DEFAULT ''''  NOT NULL
, [Password] nvarchar(1000) DEFAULT ''''  NOT NULL
);
GO
CREATE TABLE [cmsMember2MemberGroup] (
  [Member] int  NOT NULL
, [MemberGroup] int  NOT NULL
);
GO
CREATE TABLE [cmsMedia] (
  [nodeId] int  NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [mediaPath] nvarchar(255)  NULL
);
GO
CREATE TABLE [cmsDocument] (
  [nodeId] int  NOT NULL
, [published] bit NOT NULL
, [documentUser] int  NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [text] nvarchar(255)  NOT NULL
, [releaseDate] datetime NULL
, [expireDate] datetime NULL
, [updateDate] datetime DEFAULT (getdate()) NOT NULL
, [templateId] int  NULL
, [newest] bit DEFAULT '0' NOT NULL
);
GO
CREATE TABLE [cmsContentXml] (
  [nodeId] int  NOT NULL
, [xml] ntext NOT NULL
);
GO
CREATE TABLE [cmsContentVersion] (
  [id] int IDENTITY (73,1)  NOT NULL
, [ContentId] int  NOT NULL
, [VersionId] uniqueidentifier NOT NULL
, [VersionDate] datetime DEFAULT (getdate()) NOT NULL
);
GO
CREATE TABLE [cmsPreviewXml] (
  [nodeId] int  NOT NULL
, [versionId] uniqueidentifier NOT NULL
, [timestamp] datetime NOT NULL
, [xml] ntext NOT NULL
);
GO
CREATE TABLE [airFlowTwoFactorLogin] (
  [nodeId] int  NOT NULL
, [token] nvarchar(64)  NULL
, [token_expiration] datetime NULL
);
GO
CREATE TABLE [airFlowMemberRegistration] (
  [nodeId] int  NOT NULL
, [email_confirmed] bit NOT NULL
, [confirmation_token] nvarchar(64)  NOT NULL
, [confirmation_token_expiration] datetime NOT NULL
, [confirmation_date] datetime NULL
, [login_type] tinyint DEFAULT 0 NOT NULL
);
GO
SET IDENTITY_INSERT [umbracoUser] ON;
GO
INSERT INTO [umbracoUser] ([id],[userDisabled],[userNoConsole],[userName],[userLogin],[userPassword],[passwordConfig],[userEmail],[userLanguage],[securityStampToken],[failedLoginAttempts],[lastLockoutDate],[lastPasswordChangeDate],[lastLoginDate],[emailConfirmedDate],[invitedDate],[createDate],[updateDate],[avatar],[tourData]) VALUES (
0,0,0,N'artem',N'artem.morhun@valtech.com',N'unnCURoic9/ITOWcfs8X/w==MgkHzZJHT6b4LQ8fuM77+S1ginrV7LVj8IAG0Zkaxyg=',N'{"hashAlgorithm":"HMACSHA256"}',N'artem.morhun@valtech.com',N'en-US',N'1d308369-77c7-45d4-a153-1596c456c830',NULL,NULL,{ts '2018-04-10 10:23:48.277'},{ts '2018-04-18 18:28:02.047'},NULL,NULL,{ts '2018-04-10 10:23:47.737'},{ts '2018-04-18 18:28:02.063'},NULL,N'[{"alias":"umbIntroIntroduction","completed":false,"disabled":true}]');
GO
SET IDENTITY_INSERT [umbracoUser] OFF;
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'05fef765-6466-485a-9f55-0385b14217d0',0,{ts '2018-04-13 13:33:08.157'},{ts '2018-04-13 13:33:08.253'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'6cb7ec10-8e7d-4bb1-8ae4-11d17e99590c',0,{ts '2018-04-11 09:02:31.233'},{ts '2018-04-11 09:37:18.533'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'ba5d150c-fbde-4552-94b4-13c382c2f697',0,{ts '2018-04-16 10:25:49.910'},{ts '2018-04-16 10:26:59.187'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'ff32751c-6611-4758-9893-19bf4ab026fa',0,{ts '2018-04-10 08:12:56.937'},{ts '2018-04-10 08:12:56.937'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'a2c96439-2d97-4be3-8555-2308349afbdb',0,{ts '2018-04-16 13:48:11.873'},{ts '2018-04-16 14:45:05.207'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'0e1f7815-88bd-4003-96de-24ee755b5238',0,{ts '2018-04-13 09:54:34.680'},{ts '2018-04-13 10:08:05.817'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'3d89abfc-7811-4989-bd27-2719442e6086',0,{ts '2018-04-11 12:08:25.730'},{ts '2018-04-11 12:40:36.993'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'2498b53d-ed9f-4fd9-a565-274af5b2c8a4',0,{ts '2018-04-18 15:28:02.410'},{ts '2018-04-18 15:29:22.890'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'091f1531-80c6-4382-8cf7-2858d01eca09',0,{ts '2018-04-18 15:14:26.160'},{ts '2018-04-18 15:14:26.160'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'7c412fdd-0832-42aa-aa98-2907730126e0',0,{ts '2018-04-10 15:30:17.403'},{ts '2018-04-10 15:41:23.480'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'f021d12f-d72d-417d-8f41-2c56cb2fcb54',0,{ts '2018-04-10 10:31:32.833'},{ts '2018-04-10 10:48:51.433'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'd24ada0c-f037-4f9d-8738-2d104b502cbf',0,{ts '2018-04-16 13:26:57.990'},{ts '2018-04-16 13:26:58.067'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'599b657c-74d4-4fa1-a2bb-2fba7ee42022',0,{ts '2018-04-11 12:40:54.067'},{ts '2018-04-11 12:41:40.950'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'9e76c4cc-789e-4486-bd38-3457f6f02c49',0,{ts '2018-04-11 10:56:58.500'},{ts '2018-04-11 11:17:19.387'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'465f1f7c-d6d1-4011-abfa-35e9406424f4',0,{ts '2018-04-11 11:30:29.203'},{ts '2018-04-11 11:30:29.250'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'e1ca9052-ec5c-4d3e-8e32-45b1b1b5f178',0,{ts '2018-04-11 12:40:42.210'},{ts '2018-04-11 12:40:42.210'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'adbd609a-e8a1-455b-95c6-46ef738bcbe3',0,{ts '2018-04-10 07:23:48.893'},{ts '2018-04-10 07:23:48.893'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'6c91a5a2-0758-4229-94f7-4d009c15adfe',0,{ts '2018-04-11 12:40:47.173'},{ts '2018-04-11 12:40:47.173'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'b699f58a-cbc4-4e12-b38f-522fe9a47dcb',0,{ts '2018-04-13 07:34:41.753'},{ts '2018-04-13 07:51:41.470'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'a5b63c61-b8a4-42a6-84ce-5dcbb03b4e19',0,{ts '2018-04-11 12:40:43.590'},{ts '2018-04-11 12:40:43.590'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'a66015d7-74a0-4338-b7e6-686da016da1e',0,{ts '2018-04-16 07:41:11.633'},{ts '2018-04-16 07:42:20.597'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'eb00ba2e-aac3-4268-9221-717ee6374cbd',0,{ts '2018-04-13 07:06:52.587'},{ts '2018-04-13 07:15:53.853'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'e438afe7-2e0d-4cac-bca8-72e013afe97a',0,{ts '2018-04-18 13:43:15.610'},{ts '2018-04-18 13:43:15.610'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'6f9dc9ff-912f-42a5-8ee7-7a9da813dfa7',0,{ts '2018-04-13 10:57:36.477'},{ts '2018-04-13 11:21:02.013'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'972f1f81-08b6-4beb-99f2-7c8be56dde20',0,{ts '2018-04-16 07:38:57.630'},{ts '2018-04-16 07:38:57.630'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'11bdf98f-2f36-4c0b-a832-9f1c2b40c68c',0,{ts '2018-04-11 12:40:46.073'},{ts '2018-04-11 12:40:46.073'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'a48b17e5-7131-4ca5-8082-b8423ac847ed',0,{ts '2018-04-12 15:20:42.170'},{ts '2018-04-12 15:28:29.177'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'0d2e58fc-ffd4-4a50-ac65-ba12afcd96dc',0,{ts '2018-04-10 08:34:11.660'},{ts '2018-04-10 08:50:41.040'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'0543428c-c7ee-49c1-8e34-c3973e560325',0,{ts '2018-04-13 15:32:09.960'},{ts '2018-04-13 15:41:02.940'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'2667549e-1657-4676-9657-ca0c3b1ce81d',0,{ts '2018-04-11 12:40:44.657'},{ts '2018-04-11 12:40:44.657'},NULL,N'127.0.0.1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'57440b34-899f-4033-a66e-cf52d1635f55',0,{ts '2018-04-10 08:55:32.553'},{ts '2018-04-10 08:55:32.553'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'18be7d9e-9b23-48de-b000-db149e4bddaa',0,{ts '2018-04-16 15:03:04.260'},{ts '2018-04-16 15:26:11.617'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'0665af90-7dc4-4204-8b0a-dd16dacdc9eb',0,{ts '2018-04-17 13:28:37.997'},{ts '2018-04-17 13:28:37.997'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'b44bd715-c941-4b98-9fa4-f42744c943aa',0,{ts '2018-04-10 08:54:39.353'},{ts '2018-04-10 08:54:39.353'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'dfe2c9cf-b5c3-4485-a1d1-f8ac7e72479d',0,{ts '2018-04-13 14:52:55.500'},{ts '2018-04-13 14:54:02.743'},NULL,N'::1');
GO
INSERT INTO [umbracoUserLogin] ([sessionId],[userId],[loggedInUtc],[lastValidatedUtc],[loggedOutUtc],[ipAddress]) VALUES (
'5e05c582-1e32-4028-976a-f8bcdc8515ed',0,{ts '2018-04-10 10:13:52.667'},{ts '2018-04-10 10:27:50.213'},NULL,N'::1');
GO
SET IDENTITY_INSERT [umbracoServer] ON;
GO
INSERT INTO [umbracoServer] ([id],[address],[computerName],[registeredDate],[lastNotifiedDate],[isActive],[isMaster]) VALUES (
1,N'http://localhost:51356/umbraco',N'UA00500//LM/W3SVC/2/ROOT',{ts '2018-04-10 10:24:08.897'},{ts '2018-04-18 19:05:58.063'},1,1);
GO
SET IDENTITY_INSERT [umbracoServer] OFF;
GO
SET IDENTITY_INSERT [umbracoRelationType] ON;
GO
INSERT INTO [umbracoRelationType] ([id],[typeUniqueId],[dual],[parentObjectType],[childObjectType],[name],[alias]) VALUES (
1,'4cbeb612-e689-3563-b755-bf3ede295433',1,'c66ba18e-eaf3-4cff-8a22-41b16d66a972','c66ba18e-eaf3-4cff-8a22-41b16d66a972',N'Relate Document On Copy',N'relateDocumentOnCopy');
GO
INSERT INTO [umbracoRelationType] ([id],[typeUniqueId],[dual],[parentObjectType],[childObjectType],[name],[alias]) VALUES (
2,'0cc3507c-66ab-3091-8913-3d998148e423',0,'c66ba18e-eaf3-4cff-8a22-41b16d66a972','c66ba18e-eaf3-4cff-8a22-41b16d66a972',N'Relate Parent Document On Delete',N'relateParentDocumentOnDelete');
GO
SET IDENTITY_INSERT [umbracoRelationType] OFF;
GO
SET IDENTITY_INSERT [umbracoNode] ON;
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-97,0,-1,0,1,N'-1,-97',2,'aa2c52a0-ce87-4e65-a47c-7df09358585d',N'List View - Members','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-96,0,-1,0,1,N'-1,-96',2,'3a0156c4-3b8c-4803-bdc1-6871faa83fff',N'List View - Media','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-95,0,-1,0,1,N'-1,-95',2,'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4',N'List View - Content','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-92,0,-1,0,1,N'-1,-92',35,'f0bc4bfb-b499-40d6-ba86-058885a5178c',N'Label','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-90,0,-1,0,1,N'-1,-90',34,'84c6b441-31df-4ffe-b67e-67d5bc3ae65a',N'Upload','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-89,0,-1,0,1,N'-1,-89',33,'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3',N'Textarea','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-88,0,-1,0,1,N'-1,-88',32,'0cc0eba1-9960-42c9-bf9b-60e150b429ae',N'Textstring','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-87,0,-1,0,1,N'-1,-87',4,'ca90c950-0aff-4e72-b976-a30b1ac57dad',N'Richtext editor','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-51,0,-1,0,1,N'-1,-51',2,'2e6d3631-066e-44b8-aec4-96f09099b2b5',N'Numeric','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-49,0,-1,0,1,N'-1,-49',2,'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49',N'True/false','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-43,0,-1,0,1,N'-1,-43',2,'fbaf13a8-4036-41f2-93a3-974f678c312a',N'Checkbox list','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-42,0,-1,0,1,N'-1,-42',2,'0b6a45e7-44ba-430d-9da5-4e46060b9e03',N'Dropdown','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-41,0,-1,0,1,N'-1,-41',2,'5046194e-4237-453c-a547-15db3a07c4e1',N'Date Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-40,0,-1,0,1,N'-1,-40',2,'bb5f57c9-ce2b-4bb9-b697-4caca783a805',N'Radiobox','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-39,0,-1,0,1,N'-1,-39',2,'f38f0ac7-1d27-439c-9f3f-089cd8825a53',N'Dropdown multiple','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-37,0,-1,0,1,N'-1,-37',2,'0225af17-b302-49cb-9176-b9f35cab9c17',N'Approved Color','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-36,0,-1,0,1,N'-1,-36',2,'e4d66c0f-b935-4200-81f0-025f7256b89a',N'Date Picker with time','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-21,0,-1,0,0,N'-1,-21',0,'bf7c7cbc-952f-4518-97a2-69e9c7b33842',N'Recycle Bin','cf3d8e34-1c1c-41e9-ae56-878b57b32113',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-20,0,-1,0,0,N'-1,-20',0,'0f582a79-1e41-4cf0-bfa0-76340651891a',N'Recycle Bin','01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-1,0,-1,0,0,N'-1',0,'916724a5-173d-4619-b97e-b9de133dd6f5',N'SYSTEM DATA: umbraco master root','ea7d8624-4cfe-4578-a871-24aa946bf34d',{ts '2018-04-10 10:23:47.207'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1031,0,-1,0,1,N'-1,1031',2,'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d',N'Folder','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1032,0,-1,0,1,N'-1,1032',2,'cc07b313-0843-4aa8-bbda-871c8da728c8',N'Image','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1033,0,-1,0,1,N'-1,1033',2,'4c52d8ab-54e6-40cd-999c-7a5f24903e4d',N'File','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1041,0,-1,0,1,N'-1,1041',2,'b6b73142-b9c1-4bf8-a16d-e1c23320b549',N'Tags','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1043,0,-1,0,1,N'-1,1043',2,'1df9f033-e6d4-451f-b8d2-e0cbc50a836f',N'Image Cropper','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1044,0,-1,0,1,N'-1,1044',0,'d59be02f-1df9-4228-aa1e-01917d806cda',N'Member','9b5416fb-e72f-45a9-a07b-5a9a2709ce43',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1046,0,-1,0,1,N'-1,1046',2,'fd1e0da5-5606-4862-b679-5d0cf3a52a59',N'Content Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1047,0,-1,0,1,N'-1,1047',2,'1ea2e01f-ebd8-4ce1-8d71-6b1149e63548',N'Member Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1048,0,-1,0,1,N'-1,1048',2,'135d60e0-64d9-49ed-ab08-893c9ba44ae5',N'Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1049,0,-1,0,1,N'-1,1049',2,'9dbbcbbb-2327-434a-b355-af1b84e5010a',N'Multiple Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1050,0,-1,0,1,N'-1,1050',2,'b4e3535a-1753-47e2-8568-602cf8cfee6f',N'Related Links','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-10 10:23:47.220'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1054,0,-1,NULL,1,N'-1,1054',0,'df457d41-a835-474a-b02b-351ca0ffc261',N'Auth&Account','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-10 13:14:24.510'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1055,0,1054,NULL,1,N'-1,1054,1055',0,'e33442a6-93fe-4071-936a-a76125fda120',N'Register','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-10 13:15:02.600'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1056,0,-1,0,1,N'-1,1056',5,'cc0198d2-9cd3-434b-9684-723dfc14512c',N'Register','a2cb7800-f571-4787-9638-bc48539a0efb',{ts '2018-04-10 13:15:23.630'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1057,0,1054,NULL,1,N'-1,1054,1057',0,'0c0b39da-0084-4e1e-95c4-40bf1596bf73',N'Login','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-10 13:15:56.897'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1058,0,-1,0,1,N'-1,1058',1,'930eeb1e-be51-45b6-9ddb-0d6733c85074',N'Login','a2cb7800-f571-4787-9638-bc48539a0efb',{ts '2018-04-10 13:16:10.283'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1059,1,-20,0,1,N'-1,-20,1059',1,'fd31589d-6962-4de4-a211-713285b36c74',N'Login','c66ba18e-eaf3-4cff-8a22-41b16d66a972',{ts '2018-04-10 13:16:21.350'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1060,0,-1,0,1,N'-1,1060',1,'5f333e26-3602-45ea-8e21-a6647b4863cf',N'Register','c66ba18e-eaf3-4cff-8a22-41b16d66a972',{ts '2018-04-10 13:16:43.167'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1061,0,-1,NULL,1,N'-1,1061',0,'341ac0aa-30e9-432f-9737-c73c3c4fd76e',N'HomeBase','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-10 13:20:23.627'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1069,0,-1,0,1,N'-1,1069',3,'0434a903-b6a0-4ebe-9f58-cb702a1af725',N'Home','a2cb7800-f571-4787-9638-bc48539a0efb',{ts '2018-04-10 18:35:42.937'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1071,0,1061,NULL,1,N'-1,1061,1071',0,'d08efebd-1c1f-4e77-8027-4f10357324f4',N'Home','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-10 18:38:09.660'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1072,0,-1,0,1,N'-1,1072',0,'9c0a71da-af2a-422a-9aab-d06da4396abc',N'Home','c66ba18e-eaf3-4cff-8a22-41b16d66a972',{ts '2018-04-10 18:38:42.233'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1073,0,-1,0,1,N'-1,1073',2,'6cbf1d52-8a74-43ac-86e8-592f124edaf4',N'Login','c66ba18e-eaf3-4cff-8a22-41b16d66a972',{ts '2018-04-10 18:41:10.670'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1075,0,-1,0,0,N'-1,1075',0,'ae43d619-509a-4b8f-9930-8e6edf1a5e6b',N'Regular','366e63b9-880f-4e13-a61c-98069b029728',{ts '2018-04-11 14:12:33.333'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1077,0,-1,NULL,1,N'-1,1077',0,'5353c551-cb92-4de8-bc20-4d30a91ea670',N'Error','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-11 14:16:56.990'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1078,0,-1,0,1,N'-1,1078',3,'1ecc85f2-17fc-45a5-98cb-d398fb0a0309',N'Error','a2cb7800-f571-4787-9638-bc48539a0efb',{ts '2018-04-11 14:17:07.977'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1079,0,-1,0,1,N'-1,1079',3,'0157e764-a111-4584-a108-859317eb3b7b',N'Error','c66ba18e-eaf3-4cff-8a22-41b16d66a972',{ts '2018-04-11 14:17:38.430'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1112,0,-1,NULL,1,N'-1,1112',0,'dab9e938-9334-40ba-b515-b7b709be0a7d',N'ConfirmPage','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-16 17:33:59.603'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1114,0,1054,NULL,1,N'-1,1054,1114',0,'23c94a40-8cae-4b3d-b53b-5e38157df911',N'ConfirmEmailSuccess','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-16 17:45:05.223'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1116,0,1054,NULL,1,N'-1,1054,1116',0,'6b41b9a3-57ab-4a14-818e-9507d0ecb96a',N'ConfirmEmailFailure','6fbde604-4178-42ce-a10b-8a2600a2f07d',{ts '2018-04-16 18:11:04.577'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1131,0,-1,0,1,N'-1,1131',3,'c8073ef2-248a-4d1a-9b58-79472e9a7cca',N'sdfsadf@ASDA.COM','39eb0f98-b348-42a1-8662-e7eb18487560',{ts '2018-04-18 18:08:45.843'});
GO
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1132,0,-1,0,1,N'-1,1132',1,'a7f08c96-6722-4ae6-b0df-fcb6d788f215',N'regular@regular.com','39eb0f98-b348-42a1-8662-e7eb18487560',{ts '2018-04-18 18:29:06.767'});
GO
SET IDENTITY_INSERT [umbracoNode] OFF;
GO
SET IDENTITY_INSERT [umbracoUserStartNode] OFF;
GO
SET IDENTITY_INSERT [umbracoUserGroup] ON;
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
1,N'admin',N'Administrators',N'CADMOSKTPIURZ:5F7ï',{ts '2018-04-10 10:23:47.937'},{ts '2018-04-10 10:23:47.937'},N'icon-medal',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
2,N'writer',N'Writers',N'CAH:F',{ts '2018-04-10 10:23:47.937'},{ts '2018-04-10 10:23:47.937'},N'icon-edit',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
3,N'editor',N'Editors',N'CADMOSKTPUZ:5Fï',{ts '2018-04-10 10:23:47.937'},{ts '2018-04-10 10:23:47.937'},N'icon-tools',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
4,N'translator',N'Translators',N'AF',{ts '2018-04-10 10:23:47.937'},{ts '2018-04-10 10:23:47.937'},N'icon-globe',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
5,N'sensitiveData',N'Sensitive data',N'',{ts '2018-04-10 10:23:47.937'},{ts '2018-04-10 10:23:47.937'},N'icon-lock',-1,-1);
GO
SET IDENTITY_INSERT [umbracoUserGroup] OFF;
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'content');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'developer');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'forms');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'media');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'member');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'settings');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
1,N'users');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
2,N'content');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
3,N'content');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
3,N'forms');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
3,N'media');
GO
INSERT INTO [umbracoUserGroup2App] ([userGroupId],[app]) VALUES (
4,N'translation');
GO
INSERT INTO [umbracoUser2UserGroup] ([userId],[userGroupId]) VALUES (
0,1);
GO
INSERT INTO [umbracoUser2UserGroup] ([userId],[userGroupId]) VALUES (
0,5);
GO
SET IDENTITY_INSERT [umbracoRelation] ON;
GO
INSERT INTO [umbracoRelation] ([id],[parentId],[childId],[relType],[datetime],[comment]) VALUES (
3,-1,1059,2,{ts '2018-04-10 18:40:55.963'},N'');
GO
SET IDENTITY_INSERT [umbracoRelation] OFF;
GO
SET IDENTITY_INSERT [umbracoMigration] ON;
GO
INSERT INTO [umbracoMigration] ([id],[name],[createDate],[version]) VALUES (
1,N'Umbraco',{ts '2018-04-10 10:23:47.890'},N'7.10.1');
GO
INSERT INTO [umbracoMigration] ([id],[name],[createDate],[version]) VALUES (
2,N'UmbracoForms',{ts '2018-04-10 11:34:43.503'},N'7.0.0');
GO
INSERT INTO [umbracoMigration] ([id],[name],[createDate],[version]) VALUES (
3,N'Umbraco',{ts '2018-04-11 14:10:56.500'},N'7.10.2');
GO
SET IDENTITY_INSERT [umbracoMigration] OFF;
GO
SET IDENTITY_INSERT [umbracoLog] ON;
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
1,0,-1,{ts '2018-04-10 11:34:33.827'},N'PackagerInstall',N'Package ''Umbraco Forms'' installed. Package guid: cd44cf39-3d71-4c19-b6ee-948e1faf0525');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
2,0,-1,{ts '2018-04-10 11:34:43.287'},N'Save',N'Save Macro performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
3,0,-1,{ts '2018-04-10 11:34:45.037'},N'Save',N'Save ContentTypes performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
4,0,0,{ts '2018-04-10 11:50:41.113'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
5,0,1051,{ts '2018-04-10 11:50:52.293'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
6,0,1052,{ts '2018-04-10 11:51:05.657'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
7,0,0,{ts '2018-04-10 11:51:21.470'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
8,0,1051,{ts '2018-04-10 11:55:48.027'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
9,0,1051,{ts '2018-04-10 11:55:49.050'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
10,0,1051,{ts '2018-04-10 11:56:06.233'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
11,0,1051,{ts '2018-04-10 13:14:02.640'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
12,0,1051,{ts '2018-04-10 13:14:12.890'},N'Delete',N'Delete Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
13,0,0,{ts '2018-04-10 13:14:24.527'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
14,0,0,{ts '2018-04-10 13:15:02.623'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
15,0,1053,{ts '2018-04-10 13:15:13.213'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
16,0,1053,{ts '2018-04-10 13:15:13.280'},N'Delete',N'Delete Content performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
17,0,-1,{ts '2018-04-10 13:15:13.280'},N'Delete',N'Delete Content of Types 1052 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
18,0,1052,{ts '2018-04-10 13:15:13.337'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
19,0,1056,{ts '2018-04-10 13:15:23.657'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
20,0,0,{ts '2018-04-10 13:15:56.923'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
21,0,1058,{ts '2018-04-10 13:16:10.307'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
22,0,0,{ts '2018-04-10 13:16:21.373'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
23,0,0,{ts '2018-04-10 13:16:43.197'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
24,0,0,{ts '2018-04-10 13:20:23.643'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
25,0,1054,{ts '2018-04-10 13:41:51.697'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
26,0,1063,{ts '2018-04-10 13:42:16.397'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
27,0,-1,{ts '2018-04-10 13:42:30.903'},N'Delete',N'Delete Content of Types 1063 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
28,0,1063,{ts '2018-04-10 13:42:30.960'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
29,0,-1,{ts '2018-04-10 13:47:43.373'},N'Save',N'Save PartialView performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
30,0,0,{ts '2018-04-10 18:32:19.453'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
31,0,1065,{ts '2018-04-10 18:32:19.550'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
32,0,1065,{ts '2018-04-10 18:32:23.057'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
33,0,0,{ts '2018-04-10 18:32:44.663'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
34,0,1066,{ts '2018-04-10 18:32:46.837'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
35,0,0,{ts '2018-04-10 18:32:57.090'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
36,0,1065,{ts '2018-04-10 18:34:42.773'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
37,0,1067,{ts '2018-04-10 18:35:02.613'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
38,0,1067,{ts '2018-04-10 18:35:02.620'},N'Move',N'Move Content to Recycle Bin performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
39,0,1067,{ts '2018-04-10 18:35:02.667'},N'Delete',N'Trashed content with Id: ''1067'' related to original parent content with Id: ''-1''');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
40,0,1066,{ts '2018-04-10 18:35:08.840'},N'Delete',N'Delete Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
41,0,1067,{ts '2018-04-10 18:35:13.553'},N'Delete',N'Delete Content performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
42,0,-1,{ts '2018-04-10 18:35:13.553'},N'Delete',N'Delete Content of Types 1065 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
43,0,1065,{ts '2018-04-10 18:35:13.600'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
44,0,0,{ts '2018-04-10 18:35:33.753'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
45,0,1069,{ts '2018-04-10 18:35:42.957'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
46,0,0,{ts '2018-04-10 18:35:51.343'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
47,0,1068,{ts '2018-04-10 18:37:26.983'},N'Delete',N'Delete Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
48,0,1064,{ts '2018-04-10 18:37:40.173'},N'Delete',N'Delete Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
49,0,0,{ts '2018-04-10 18:38:09.673'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
50,0,1069,{ts '2018-04-10 18:38:20.357'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
51,0,1070,{ts '2018-04-10 18:38:34.780'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
52,0,1070,{ts '2018-04-10 18:38:34.787'},N'Move',N'Move Content to Recycle Bin performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
53,0,1070,{ts '2018-04-10 18:38:34.830'},N'Delete',N'Trashed content with Id: ''1070'' related to original parent content with Id: ''-1''');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
54,0,0,{ts '2018-04-10 18:38:42.250'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
55,0,1061,{ts '2018-04-10 18:39:08.120'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
56,0,1061,{ts '2018-04-10 18:39:12.123'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
57,0,1061,{ts '2018-04-10 18:39:23.577'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
58,0,1061,{ts '2018-04-10 18:39:24.797'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
59,0,1071,{ts '2018-04-10 18:39:30.327'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
60,0,1059,{ts '2018-04-10 18:40:21.663'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
61,0,1072,{ts '2018-04-10 18:40:28.717'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
62,0,1072,{ts '2018-04-10 18:40:32.083'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
63,0,-20,{ts '2018-04-10 18:40:38.397'},N'Delete',N'Empty Content Recycle Bin performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
64,0,1072,{ts '2018-04-10 18:40:46.113'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
65,0,1059,{ts '2018-04-10 18:40:55.953'},N'Move',N'Move Content to Recycle Bin performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
66,0,1059,{ts '2018-04-10 18:40:55.970'},N'Delete',N'Trashed content with Id: ''1059'' related to original parent content with Id: ''-1''');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
67,0,1072,{ts '2018-04-10 18:40:58.767'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
68,0,0,{ts '2018-04-10 18:41:10.703'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
69,0,1060,{ts '2018-04-10 18:41:29.677'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
70,0,1060,{ts '2018-04-10 18:41:40.603'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
71,0,0,{ts '2018-04-10 18:42:17.130'},N'Sort',N'Sorting content performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
72,0,0,{ts '2018-04-11 14:16:57.017'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
73,0,1078,{ts '2018-04-11 14:17:08.010'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
74,0,0,{ts '2018-04-11 14:17:38.470'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
75,0,1072,{ts '2018-04-11 15:32:10.693'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
76,0,1095,{ts '2018-04-12 18:27:13.337'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
77,0,1056,{ts '2018-04-12 18:27:22.250'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
78,0,1095,{ts '2018-04-12 18:28:00.607'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
79,0,0,{ts '2018-04-12 18:28:19.267'},N'Publish',N'Save and Publish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
80,0,1096,{ts '2018-04-12 18:28:40.103'},N'UnPublish',N'UnPublish performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
81,0,1096,{ts '2018-04-12 18:28:40.110'},N'Move',N'Move Content to Recycle Bin performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
82,0,1096,{ts '2018-04-12 18:28:40.170'},N'Delete',N'Trashed content with Id: ''1096'' related to original parent content with Id: ''1060''');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
83,0,1054,{ts '2018-04-16 10:41:50.827'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
84,0,1054,{ts '2018-04-16 10:42:34.340'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
85,0,1054,{ts '2018-04-16 10:42:50.463'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
86,0,1057,{ts '2018-04-16 13:27:27.593'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
87,0,1055,{ts '2018-04-16 13:27:30.973'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
88,0,0,{ts '2018-04-16 17:32:37.333'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
89,0,1111,{ts '2018-04-16 17:33:40.423'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
90,0,0,{ts '2018-04-16 17:33:59.613'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
91,0,1113,{ts '2018-04-16 17:33:59.677'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
92,0,1096,{ts '2018-04-16 17:41:14.517'},N'Delete',N'Delete Content performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
93,0,-1,{ts '2018-04-16 17:41:14.517'},N'Delete',N'Delete Content of Types 1095 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
94,0,1095,{ts '2018-04-16 17:41:14.563'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
95,0,1111,{ts '2018-04-16 17:41:18.157'},N'Delete',N'Delete Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
96,0,0,{ts '2018-04-16 17:45:05.233'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
97,0,1115,{ts '2018-04-16 17:45:33.127'},N'Save',N'Save ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
98,0,-1,{ts '2018-04-16 18:03:23.783'},N'Delete',N'Delete Content of Types 1113 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
99,0,1113,{ts '2018-04-16 18:03:23.860'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
100,0,1114,{ts '2018-04-16 18:10:39.870'},N'Save',N'Save Template performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
101,0,-1,{ts '2018-04-16 18:10:47.417'},N'Delete',N'Delete Content of Types 1115 performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
102,0,1115,{ts '2018-04-16 18:10:47.487'},N'Delete',N'Delete ContentType performed by user');
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
103,0,0,{ts '2018-04-16 18:11:04.590'},N'Save',N'Save Template performed by user');
GO
SET IDENTITY_INSERT [umbracoLog] OFF;
GO
SET IDENTITY_INSERT [umbracoLock] ON;
GO
INSERT INTO [umbracoLock] ([id],[value],[name]) VALUES (
-331,1,N'Servers');
GO
SET IDENTITY_INSERT [umbracoLock] OFF;
GO
SET IDENTITY_INSERT [umbracoLanguage] ON;
GO
INSERT INTO [umbracoLanguage] ([id],[languageISOCode],[languageCultureName]) VALUES (
1,N'en-US',N'en-US');
GO
SET IDENTITY_INSERT [umbracoLanguage] OFF;
GO
SET IDENTITY_INSERT [umbracoExternalLogin] OFF;
GO
SET IDENTITY_INSERT [umbracoDomains] OFF;
GO
SET IDENTITY_INSERT [umbracoConsent] OFF;
GO
SET IDENTITY_INSERT [umbracoCacheInstruction] ON;
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
153,{ts '2018-04-18 09:27:05.870'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1121]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P437600/D2] 42EEE197CFE44EAFABA8F6F65CCD41FE',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
154,{ts '2018-04-18 09:36:09.780'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1122]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P448064/D2] 96DCD0EBC6A241C099FD376D5E0B6932',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
155,{ts '2018-04-18 09:41:02.083'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1123]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P450584/D2] 989DE0A9ECF84E3C8391DD26C0E048C1',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
156,{ts '2018-04-18 09:41:19.207'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1124]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P450584/D2] 989DE0A9ECF84E3C8391DD26C0E048C1',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
157,{ts '2018-04-18 09:47:22.297'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1125]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P439360/D2] D89DC7E13A9A4B748F7623DBA9ECA783',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
158,{ts '2018-04-18 09:47:33.683'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1126]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1126]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1126]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P439360/D2] D89DC7E13A9A4B748F7623DBA9ECA783',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
159,{ts '2018-04-18 09:51:08.863'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1127]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1127]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1127]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P449552/D2] ABD67A53FF5F4244A3B984EE69E9C603',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
160,{ts '2018-04-18 13:43:38.717'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1122,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
161,{ts '2018-04-18 13:43:38.770'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1120,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
162,{ts '2018-04-18 13:43:38.803'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1119,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
163,{ts '2018-04-18 13:43:38.837'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1118,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
164,{ts '2018-04-18 13:43:38.870'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1125,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
165,{ts '2018-04-18 13:43:38.900'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1126,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
166,{ts '2018-04-18 13:43:38.940'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1127,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
167,{ts '2018-04-18 13:43:38.973'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1124,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
168,{ts '2018-04-18 13:43:39.010'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1121,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
169,{ts '2018-04-18 13:43:39.040'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1123,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P551796/D2] D532DDF31F064EE58FE99441EB47A273',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
170,{ts '2018-04-18 15:02:02.640'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1128]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1128]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1128]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P559696/D2] D5D3935408E84192B84097017D4BBC5A',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
171,{ts '2018-04-18 15:03:26.103'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1129]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1129]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1129]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P559696/D2] D5D3935408E84192B84097017D4BBC5A',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
172,{ts '2018-04-18 15:04:47.427'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1130]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1130]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1130]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P559696/D2] D5D3935408E84192B84097017D4BBC5A',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
173,{ts '2018-04-18 15:08:47.240'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P565788/D2] 103E7BBC35EC4790825CA487F4F0841A',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
174,{ts '2018-04-18 15:14:35.890'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1130,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P562024/D2] 9C3326FB18C44FFD96468F541885F8CA',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
175,{ts '2018-04-18 15:14:35.940'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1129,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P562024/D2] 9C3326FB18C44FFD96468F541885F8CA',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
176,{ts '2018-04-18 15:14:35.977'},N'[{"RefreshType":5,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1128,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P562024/D2] 9C3326FB18C44FFD96468F541885F8CA',1);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
177,{ts '2018-04-18 15:14:39.183'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1131]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P562024/D2] 9C3326FB18C44FFD96468F541885F8CA',2);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
178,{ts '2018-04-18 15:29:08.090'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P566996/D2] DF1FFA6FBD754788AE259EB27D4DBC4C',3);
GO
INSERT INTO [umbracoCacheInstruction] ([id],[utcStamp],[jsonInstruction],[originated],[instructionCount]) VALUES (
179,{ts '2018-04-18 15:29:27.267'},N'[{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"e285df34-acdc-4226-ae32-c0cb5cf388da","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1132]","JsonIdCount":1,"JsonPayload":null}]',N'UA00500//LM/W3SVC/2/ROOT [P566996/D2] DF1FFA6FBD754788AE259EB27D4DBC4C',2);
GO
SET IDENTITY_INSERT [umbracoCacheInstruction] OFF;
GO
SET IDENTITY_INSERT [umbracoAudit] ON;
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
1,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-10 07:24:34.440'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating TourData, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
2,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:12:56.907'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
3,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:12:56.923'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
4,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:34:11.313'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
5,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:34:11.353'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
6,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:54:39.293'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
7,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:54:39.310'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
8,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:55:32.540'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
9,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 08:55:32.540'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
10,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 10:13:52.190'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
11,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 10:13:52.230'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
12,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 10:31:32.807'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
13,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 10:31:32.817'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
14,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 15:30:16.953'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
15,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-10 15:30:16.997'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
16,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 09:00:42.020'},-1,N'Member 1074 "test-user" <test@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
17,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 09:02:30.810'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
18,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 09:02:30.827'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
19,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 10:56:57.993'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
20,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 10:56:58.040'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
21,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 11:14:31.747'},-1,N'Member 1074 "test-user" <test@user.com>',N'umbraco/member/delete',N'delete member id:1074 "test-user" <test@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
22,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:18:40.433'},-1,N'Member 1080 "test-user@user.com" <test-user@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
23,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:18:42.083'},-1,N'Member 1080 "test-user@user.com" <test-user@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Disabled');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
24,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:22:10.830'},-1,N'Member 1081 "test-user2@user.com" <test-user2@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
25,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:22:10.910'},-1,N'Member 1081 "test-user2@user.com" <test-user2@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Disabled');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
26,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:30:28.757'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
27,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:30:28.793'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
28,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 11:30:44.813'},-1,N'Member 1080 "test-user@user.com" <test-user@user.com>',N'umbraco/member/delete',N'delete member id:1080 "test-user@user.com" <test-user@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
29,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 11:30:44.977'},-1,N'Member 1081 "test-user2@user.com" <test-user2@user.com>',N'umbraco/member/delete',N'delete member id:1081 "test-user2@user.com" <test-user2@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
30,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:31:09.547'},-1,N'Member 1082 "test" <test-user@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
31,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 11:31:09.627'},-1,N'Member 1082 "test" <test-user@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Disabled');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
32,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:08:25.197'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
33,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:08:25.267'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
34,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 12:08:36.117'},-1,N'Member 1082 "test" <test-user@user.com>',N'umbraco/member/delete',N'delete member id:1082 "test" <test-user@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
35,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:08:58.310'},-1,N'Member 1083 "test" <a@a.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
36,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:08:58.387'},-1,N'Member 1083 "test" <a@a.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Disabled');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
37,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 12:15:49.887'},-1,N'Member 1083 "test" <a@a.com>',N'umbraco/member/delete',N'delete member id:1083 "test" <a@a.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
38,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:16:11.513'},-1,N'Member 1084 "test" <a@a.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
39,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 12:22:07.190'},-1,N'Member 1084 "test" <a@a.com>',N'umbraco/member/delete',N'delete member id:1084 "test" <a@a.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
40,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:22:38.260'},-1,N'Member 1085 "test" <a@a.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
41,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-11 12:24:00.723'},-1,N'Member 1085 "test" <a@a.com>',N'umbraco/member/delete',N'delete member id:1085 "test" <a@a.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
42,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:24:24.657'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
43,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:24:25.890'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
44,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:24:28.953'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
45,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-11 12:24:30.557'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Disabled');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
46,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:27:29.223'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
47,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:27:29.280'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
48,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:34:49.897'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
49,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:34:49.923'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
50,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:37:27.243'},-1,N'Member 1086 "test" <a@a.com>',N'umbraco/member/delete',N'delete member id:1086 "test" <a@a.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
51,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:38:28.680'},-1,N'Member 1087 "test" <a@a.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
52,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:38:28.807'},-1,N'Member 1087 "test" <a@a.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
53,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:38:28.827'},-1,N'Member 1087 "test" <a@a.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
54,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:38:28.893'},-1,N'Member 1087 "test" <a@a.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
55,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:40:11.160'},-1,N'Member 1088 "val" <a@valtech.co.uk>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
56,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:40:13.010'},-1,N'Member 1088 "val" <a@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
57,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:40:13.493'},-1,N'Member 1088 "val" <a@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
58,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-11 12:40:13.963'},-1,N'Member 1088 "val" <a@valtech.co.uk>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
59,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:42.177'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
60,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:42.190'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
61,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:43.567'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
62,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:43.577'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
63,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:44.640'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
64,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:44.647'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
65,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:46.050'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
66,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:46.057'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
67,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:47.153'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
68,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:47.163'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
69,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:54.047'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
70,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-11 12:40:54.053'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
71,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 07:56:34.010'},-1,N'Member 1089 "aaa" <e@e.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
72,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 07:56:47.360'},-1,N'Member 1090 "aaa" <e@e.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
73,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 07:56:47.487'},-1,N'Member 1089 "aaa" <e@e.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
74,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 07:56:47.510'},-1,N'Member 1090 "aaa" <e@e.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
75,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 07:56:47.577'},-1,N'Member 1090 "aaa" <e@e.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
76,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 08:02:13.440'},-1,N'Member 1091 "www" <w@w.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
77,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 08:14:57.697'},-1,N'Member 1092 "ggg" <g@g.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
78,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 12:34:26.037'},-1,N'Member 1093 "lll" <l@l.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
79,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 12:34:26.173'},-1,N'Member 1093 "lll" <l@l.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
80,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 12:34:26.197'},-1,N'Member 1093 "lll" <l@l.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
81,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 12:34:26.277'},-1,N'Member 1093 "lll" <l@l.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
82,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-12 12:36:11.530'},-1,N'Member 1094 "ooo" <o@o.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
83,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-12 12:36:11.707'},-1,N'Member 1094 "ooo" <o@o.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
84,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-12 12:36:11.730'},-1,N'Member 1094 "ooo" <o@o.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
85,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-12 12:36:11.807'},-1,N'Member 1094 "ooo" <o@o.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
86,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 15:20:41.730'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
87,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-12 15:20:41.773'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
88,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 07:06:52.093'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
89,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 07:06:52.153'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
90,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 07:34:41.417'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
91,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 07:34:41.457'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
92,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 09:54:34.613'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
93,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 09:54:34.653'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
94,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 10:57:35.980'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
95,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 10:57:36.023'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
96,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 13:30:24.597'},-1,N'Member 1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
97,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 13:30:29.087'},-1,N'Member 1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
98,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 13:30:30.140'},-1,N'Member 1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
99,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 13:30:42.577'},-1,N'Member 1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
100,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:07.567'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
101,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:07.623'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
102,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.477'},-1,N'Member 1089 "aaa" <e@e.com>',N'umbraco/member/delete',N'delete member id:1089 "aaa" <e@e.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
103,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.660'},-1,N'Member 1090 "aaa" <e@e.com>',N'umbraco/member/delete',N'delete member id:1090 "aaa" <e@e.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
104,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.707'},-1,N'Member 1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1097 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
105,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.760'},-1,N'Member 1092 "ggg" <g@g.com>',N'umbraco/member/delete',N'delete member id:1092 "ggg" <g@g.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
106,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.800'},-1,N'Member 1093 "lll" <l@l.com>',N'umbraco/member/delete',N'delete member id:1093 "lll" <l@l.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
107,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.840'},-1,N'Member 1094 "ooo" <o@o.com>',N'umbraco/member/delete',N'delete member id:1094 "ooo" <o@o.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
108,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.890'},-1,N'Member 1087 "test" <a@a.com>',N'umbraco/member/delete',N'delete member id:1087 "test" <a@a.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
109,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.927'},-1,N'Member 1088 "val" <a@valtech.co.uk>',N'umbraco/member/delete',N'delete member id:1088 "val" <a@valtech.co.uk>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
110,0,N'User "artem" <artem.morhun@valtech.com>',N'127.0.0.1',{ts '2018-04-13 13:33:21.977'},-1,N'Member 1091 "www" <w@w.com>',N'umbraco/member/delete',N'delete member id:1091 "www" <w@w.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
111,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:35.330'},-1,N'Member 1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
112,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:35.447'},-1,N'Member 1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
113,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:35.470'},-1,N'Member 1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
114,0,N'User "SYSTEM" ',N'127.0.0.1',{ts '2018-04-13 13:33:35.540'},-1,N'Member 1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
115,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:52:54.993'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
116,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:52:55.043'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
117,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-13 14:54:07.620'},-1,N'Member 1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1098 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
118,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:54:12.890'},-1,N'Member 1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
119,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:54:12.993'},-1,N'Member 1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
120,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:54:13.020'},-1,N'Member 1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
121,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 14:54:13.093'},-1,N'Member 1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
122,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:09.513'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
123,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:09.567'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
124,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-13 15:32:16.197'},-1,N'Member 1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1099 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
125,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:33.803'},-1,N'Member 1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
126,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:33.897'},-1,N'Member 1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
127,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:33.930'},-1,N'Member 1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
128,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:32:34.003'},-1,N'Member 1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
129,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:33:53.520'},-1,N'Member 1101 "aaa@aaa.aaa" <aaa@aaa.aaa>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
130,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:33:53.600'},-1,N'Member 1101 "aaa@aaa.aaa" <aaa@aaa.aaa>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
131,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:33:53.623'},-1,N'Member 1101 "aaa@aaa.aaa" <aaa@aaa.aaa>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
132,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:33:53.693'},-1,N'Member 1101 "aaa@aaa.aaa" <aaa@aaa.aaa>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
133,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:34:50.513'},-1,N'Member 1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
134,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:34:50.717'},-1,N'Member 1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
135,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:34:50.737'},-1,N'Member 1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
136,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 15:34:50.887'},-1,N'Member 1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
137,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-13 15:41:10.350'},-1,N'Member 1101 "aaa@aaa.aaa" <aaa@aaa.aaa>',N'umbraco/member/delete',N'delete member id:1101 "aaa@aaa.aaa" <aaa@aaa.aaa>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
138,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-13 15:41:10.560'},-1,N'Member 1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1100 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
139,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-13 15:41:10.620'},-1,N'Member 1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>',N'umbraco/member/delete',N'delete member id:1102 "assdasd@valtech.co.uk" <assdasd@valtech.co.uk>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
140,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:06:29.450'},-1,N'Member 1103 "asds@adaasd.asd" <asds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
141,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:06:29.593'},-1,N'Member 1103 "asds@adaasd.asd" <asds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
142,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:06:29.617'},-1,N'Member 1103 "asds@adaasd.asd" <asds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
143,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:06:29.693'},-1,N'Member 1103 "asds@adaasd.asd" <asds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
144,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:07:21.527'},-1,N'Member 1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
145,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:07:21.610'},-1,N'Member 1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
146,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:07:21.627'},-1,N'Member 1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
147,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:07:21.680'},-1,N'Member 1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
148,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:08.133'},-1,N'Member 1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
149,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:08.187'},-1,N'Member 1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
150,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:08.207'},-1,N'Member 1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
151,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:08.223'},-1,N'Member 1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
152,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:47.003'},-1,N'Member 1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
153,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:49.920'},-1,N'Member 1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
154,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:49.943'},-1,N'Member 1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
155,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-13 16:08:49.987'},-1,N'Member 1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
156,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 07:38:57.183'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
157,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 07:38:57.223'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
158,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 07:41:11.323'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
159,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 07:41:11.357'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
160,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 10:25:49.443'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
161,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 10:25:49.487'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
162,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:26:57.480'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
163,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:26:57.533'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
164,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:34:39.370'},-1,N'Member 1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
165,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:34:39.503'},-1,N'Member 1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
166,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:34:39.523'},-1,N'Member 1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
167,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:34:39.587'},-1,N'Member 1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
168,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:11.553'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
169,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:11.597'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
170,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:48:19.110'},-1,N'Member 1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>',N'umbraco/member/delete',N'delete member id:1106 "a2232sds@valtech.co.uk" <a2232sds@valtech.co.uk>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
171,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:48:19.273'},-1,N'Member 1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1104 "a22sds@adaasd.asd" <a22sds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
172,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:48:19.317'},-1,N'Member 1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>',N'umbraco/member/delete',N'delete member id:1105 "a22sds@valtech.co.uk" <a22sds@valtech.co.uk>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
173,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:48:19.360'},-1,N'Member 1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1107 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
174,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:48:19.397'},-1,N'Member 1103 "asds@adaasd.asd" <asds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1103 "asds@adaasd.asd" <asds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
175,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:33.977'},-1,N'Member 1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
176,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:34.073'},-1,N'Member 1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
177,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:34.093'},-1,N'Member 1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
178,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:48:34.157'},-1,N'Member 1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
179,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 13:59:24.683'},-1,N'Member 1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1108 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
180,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:59:33.217'},-1,N'Member 1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
181,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:59:33.320'},-1,N'Member 1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
182,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:59:33.347'},-1,N'Member 1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
183,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 13:59:33.413'},-1,N'Member 1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
184,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 14:01:49.667'},-1,N'Member 1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1109 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
185,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 14:02:09.960'},-1,N'Member 1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
186,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 14:02:10.057'},-1,N'Member 1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
187,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 14:02:10.080'},-1,N'Member 1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
188,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 14:02:10.147'},-1,N'Member 1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
189,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:03:03.927'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
190,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:03:03.960'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
191,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:13:30.330'},-1,N'Member 1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1110 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
192,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:14:18.627'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
193,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:14:18.777'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
194,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:14:18.803'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
195,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:14:18.873'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
196,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:15:39.083'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
197,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:15:39.130'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
198,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:25:13.510'},-1,N'Member 1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1117 "artem.morhun@valtech.com" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
199,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:25:30.487'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
200,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:25:30.590'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
201,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:25:30.610'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
202,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-16 15:25:30.673'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
203,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:26:15.783'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
204,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-16 15:26:15.807'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
205,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-17 13:28:37.503'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
206,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-17 13:28:37.550'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
207,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:18:34.340'},-1,N'Member 1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
208,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:18:34.500'},-1,N'Member 1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
209,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:18:34.523'},-1,N'Member 1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
210,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:18:34.593'},-1,N'Member 1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
211,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:24:01.867'},-1,N'Member 1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
212,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:24:02.013'},-1,N'Member 1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
213,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:24:02.037'},-1,N'Member 1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
214,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:24:02.110'},-1,N'Member 1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
215,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:26:22.500'},-1,N'Member 1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
216,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:26:22.647'},-1,N'Member 1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
217,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:26:22.673'},-1,N'Member 1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
218,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:26:22.750'},-1,N'Member 1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
219,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:35:48.863'},-1,N'Member 1122 "a@a.comasdas" <a@a.comasdas>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
220,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:35:49.013'},-1,N'Member 1122 "a@a.comasdas" <a@a.comasdas>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
221,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:35:49.040'},-1,N'Member 1122 "a@a.comasdas" <a@a.comasdas>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
222,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:35:49.130'},-1,N'Member 1122 "a@a.comasdas" <a@a.comasdas>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
223,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:00.157'},-1,N'Member 1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
224,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:00.307'},-1,N'Member 1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
225,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:00.330'},-1,N'Member 1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
226,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:00.403'},-1,N'Member 1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
227,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:18.360'},-1,N'Member 1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
228,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:18.443'},-1,N'Member 1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
229,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:18.463'},-1,N'Member 1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
230,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:41:18.510'},-1,N'Member 1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
231,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:19.207'},-1,N'Member 1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
232,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:19.367'},-1,N'Member 1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
233,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:19.387'},-1,N'Member 1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
234,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:19.460'},-1,N'Member 1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
235,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:31.937'},-1,N'Member 1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
236,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:31.963'},-1,N'Member 1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
237,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:31.980'},-1,N'Member 1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
238,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:47:31.997'},-1,N'Member 1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
239,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:51:06.867'},-1,N'Member 1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
240,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:51:07.040'},-1,N'Member 1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
241,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:51:07.063'},-1,N'Member 1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
242,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 09:51:07.130'},-1,N'Member 1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
243,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 13:43:15.177'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
244,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 13:43:15.220'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
245,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.600'},-1,N'Member 1122 "a@a.comasdas" <a@a.comasdas>',N'umbraco/member/delete',N'delete member id:1122 "a@a.comasdas" <a@a.comasdas>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
246,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.747'},-1,N'Member 1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1120 "a22sds@adaasd.asd" <a222sds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
247,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.793'},-1,N'Member 1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1119 "a22sds@adaasd.asd" <a22sds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
248,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.827'},-1,N'Member 1118 "Artem" <artem.morhun@valtech.com>',N'umbraco/member/delete',N'delete member id:1118 "Artem" <artem.morhun@valtech.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
249,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.860'},-1,N'Member 1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>',N'umbraco/member/delete',N'delete member id:1125 "asasdasddsad@awd.com" <asasdasddsad@awd.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
250,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.893'},-1,N'Member 1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>',N'umbraco/member/delete',N'delete member id:1126 "asasssdasddsad@awd.com" <asasssdasddsad@awd.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
251,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.927'},-1,N'Member 1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>',N'umbraco/member/delete',N'delete member id:1127 "asdsaddddd@awd.com" <asdsaddddd@awd.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
252,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.963'},-1,N'Member 1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>',N'umbraco/member/delete',N'delete member id:1124 "dasdasd@asdasdasd.com" <dasdasd@asdasdasd.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
253,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:38.997'},-1,N'Member 1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1121 "a22sds@adaasd.asd" <f32sds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
254,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 13:43:39.030'},-1,N'Member 1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>',N'umbraco/member/delete',N'delete member id:1123 "f32sds@adaasd.asd" <fddasds@adaasd.asd>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
255,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:01.383'},-1,N'Member 1128 "test@user.com" <test@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
256,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:01.553'},-1,N'Member 1128 "test@user.com" <test@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
257,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:01.573'},-1,N'Member 1128 "test@user.com" <test@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
258,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:01.650'},-1,N'Member 1128 "test@user.com" <test@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
259,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:52.567'},-1,N'Member 1129 "te1st@user.com" <te1st@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
260,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:52.660'},-1,N'Member 1129 "te1st@user.com" <te1st@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
261,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:52.680'},-1,N'Member 1129 "te1st@user.com" <te1st@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
262,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:02:52.727'},-1,N'Member 1129 "te1st@user.com" <te1st@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
263,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:03:57.453'},-1,N'Member 1130 "te1dst@user.com" <te1dst@user.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
264,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:03:57.523'},-1,N'Member 1130 "te1dst@user.com" <te1dst@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
265,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:03:57.543'},-1,N'Member 1130 "te1dst@user.com" <te1dst@user.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
266,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:03:57.587'},-1,N'Member 1130 "te1dst@user.com" <te1dst@user.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
267,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:08:46.003'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
268,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:08:46.150'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
269,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:08:46.170'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
270,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:08:46.240'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
271,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:14:25.710'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
272,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:14:25.750'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
273,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:14:35.753'},-1,N'Member 1130 "te1dst@user.com" <te1dst@user.com>',N'umbraco/member/delete',N'delete member id:1130 "te1dst@user.com" <te1dst@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
274,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:14:35.923'},-1,N'Member 1129 "te1st@user.com" <te1st@user.com>',N'umbraco/member/delete',N'delete member id:1129 "te1st@user.com" <te1st@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
275,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:14:35.967'},-1,N'Member 1128 "test@user.com" <test@user.com>',N'umbraco/member/delete',N'delete member id:1128 "test@user.com" <test@user.com>');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
276,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:14:39.137'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
277,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:14:39.163'},-1,N'Member 1131 "sdfsadf@ASDA.COM" <sdfsadf@asda.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
278,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:28:02.103'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/save',N'updating LastLoginDate, UpdateDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
279,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:28:02.140'},0,N'User "artem" <artem.morhun@valtech.com>',N'umbraco/user/sign-in/login',N'login success');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
280,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:29:06.857'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/save',N'updating CreateDate, UpdateDate, ProviderUserKey, Id, HasIdentity, Path, SortOrder, Level, RawPasswordValue, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
281,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:29:06.977'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
282,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:29:07.000'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/save',N'updating RawPasswordValue, UpdateDate, umbracoMemberPasswordRetrievalAnswer, umbracoMemberPasswordRetrievalQuestion, umbracoMemberComments, umbracoMemberFailedPasswordAttempts, umbracoMemberApproved, umbracoMemberLockedOut, umbracoMemberLastLockoutDate, umbracoMemberLastLogin, umbracoMemberLastPasswordChangeDate');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
283,0,N'User "SYSTEM" ',N'::1',{ts '2018-04-18 15:29:07.060'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/roles/assigned',N'roles modified, assigned Regular');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
284,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:29:27.227'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/save',N'updating UpdateDate, umbracoMemberApproved');
GO
INSERT INTO [umbracoAudit] ([id],[performingUserId],[performingDetails],[performingIp],[eventDateUtc],[affectedUserId],[affectedDetails],[eventType],[eventDetails]) VALUES (
285,0,N'User "artem" <artem.morhun@valtech.com>',N'::1',{ts '2018-04-18 15:29:27.250'},-1,N'Member 1132 "regular@regular.com" <regular@regular.com>',N'umbraco/member/save',N'updating UpdateDate');
GO
SET IDENTITY_INSERT [umbracoAudit] OFF;
GO
INSERT INTO [umbracoAccess] ([id],[nodeId],[loginNodeId],[noAccessNodeId],[createDate],[updateDate]) VALUES (
'8bffd65e-347d-4c72-ac2d-7dda8d3bd56e',1072,1073,1079,{ts '2018-04-11 14:17:59.380'},{ts '2018-04-11 14:17:59.603'});
GO
INSERT INTO [umbracoAccessRule] ([id],[accessId],[ruleValue],[ruleType],[createDate],[updateDate]) VALUES (
'631ee982-1e63-4a82-8796-9cd760a4ae3d','8bffd65e-347d-4c72-ac2d-7dda8d3bd56e',N'Regular',N'MemberRole',{ts '2018-04-11 14:17:59.603'},{ts '2018-04-11 14:17:59.603'});
GO
INSERT INTO [UFUserSecurity] ([User],[ManageDataSources],[ManagePreValueSources],[ManageWorkflows],[ManageForms]) VALUES (
N'0',1,1,1,1);
GO
SET IDENTITY_INSERT [UFUserFormSecurity] ON;
GO
INSERT INTO [UFUserFormSecurity] ([Id],[User],[Form],[HasAccess],[AllowInEditor],[SecurityType]) VALUES (
1,N'0','55b4a5ce-c383-4103-9a76-70ca2af3b493',1,1,0);
GO
SET IDENTITY_INSERT [UFUserFormSecurity] OFF;
GO
SET IDENTITY_INSERT [UFRecords] OFF;
GO
SET IDENTITY_INSERT [UFRecordDataString] OFF;
GO
SET IDENTITY_INSERT [UFRecordDataLongString] OFF;
GO
SET IDENTITY_INSERT [UFRecordDataInteger] OFF;
GO
SET IDENTITY_INSERT [UFRecordDataDateTime] OFF;
GO
SET IDENTITY_INSERT [UFRecordDataBit] OFF;
GO
SET IDENTITY_INSERT [cmsTemplate] ON;
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
2,1054,N'AuthAndAccountBase',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = null;
}

@* the fun starts here *@

<!DOCTYPE html>
<html>
<head>
    <title>AirFlow app</title>
    @Styles.Render("~/Content/css")
    @Scripts.Render("~/bundles/modernizr")
</head>
<body>

    <h1>AirFlow</h1>
    @RenderBody()

    @Scripts.Render("~/bundles/jquery")
    @Scripts.Render("~/bundles/bootstrap")
</body>
</html>');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
3,1055,N'Register',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage

@{
    Layout = "AuthAndAccountBase.cshtml";
}

<h1>User registration</h1>

@{Html.RenderPartial("~/Views/Partials/Account/_Register.cshtml", new UserRegistrationViewModel());}');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
4,1057,N'Login',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
    Layout = "AuthAndAccountBase.cshtml";
}

@* the fun starts here *@

@if (Umbraco.MemberIsLoggedOn())
{
    <h1>Welcome, @User.Identity.Name</h1>
    { Html.RenderPartial("~/Views/Partials/Auth/_Logout.cshtml"); }
}
else
{
    <h1>Login</h1>
    { Html.RenderPartial("~/Views/Partials/Auth/_Login.cshtml", new UserLoginViewModel()); }
}');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
5,1061,N'HomeBase',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = null;
}

@* the fun starts here *@

<h1>Welcome to AirFlow!</h1>

@RenderBody()');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
9,1071,N'Home',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "HomeBase.cshtml";
}

@* the fun starts here *@

<h1>Home page</h1>');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
10,1077,N'Error',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = null;
}

@* the fun starts here *@

');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
12,1112,N'ConfirmPage',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.ConfirmPage>
@using ContentModels = Umbraco.Web.PublishedContentModels;
@{
	Layout = null;
}');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
13,1114,N'ConfirmEmail',N'@inherits UmbracoTemplatePage
@{
    Layout = "AuthAndAccountBase.cshtml";
}

<div class="alert alert-success" role="alert">
    <h4 class="alert-heading">Registration completed!</h4>
    <hr>
    <p class="mb-0">Please login using your credentials</p>
</div>');
GO
INSERT INTO [cmsTemplate] ([pk],[nodeId],[alias],[design]) VALUES (
14,1116,N'ConfirmEmailFailure',N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage
@{
	Layout = "AuthAndAccountBase.cshtml";
}

<div class="alert alert-danger" role="alert">
    An error occurred during email confirmation.
</div>');
GO
SET IDENTITY_INSERT [cmsTemplate] OFF;
GO
SET IDENTITY_INSERT [cmsTaskType] ON;
GO
INSERT INTO [cmsTaskType] ([id],[alias]) VALUES (
1,N'toTranslate');
GO
SET IDENTITY_INSERT [cmsTaskType] OFF;
GO
SET IDENTITY_INSERT [cmsTask] OFF;
GO
SET IDENTITY_INSERT [cmsTags] OFF;
GO
SET IDENTITY_INSERT [cmsMacro] ON;
GO
INSERT INTO [cmsMacro] ([id],[uniqueId],[macroUseInEditor],[macroRefreshRate],[macroAlias],[macroName],[macroScriptType],[macroScriptAssembly],[macroXSLT],[macroCacheByPage],[macroCachePersonalized],[macroDontRender],[macroPython]) VALUES (
1,'480075d7-3f9d-4190-9356-11978ddbb8cf',1,0,N'renderUmbracoForm',N'Insert Form with Theme',NULL,NULL,NULL,0,0,0,N'~/Views/MacroPartials/InsertUmbracoFormWithTheme.cshtml');
GO
SET IDENTITY_INSERT [cmsMacro] OFF;
GO
SET IDENTITY_INSERT [cmsMacroProperty] ON;
GO
INSERT INTO [cmsMacroProperty] ([id],[uniquePropertyId],[editorAlias],[macro],[macroPropertySortOrder],[macroPropertyAlias],[macroPropertyName]) VALUES (
1,'6aea3d9a-eea6-47af-8c58-fa37cc49f414',N'UmbracoForms.FormPicker',1,0,N'FormGuid',N'Choose a form');
GO
INSERT INTO [cmsMacroProperty] ([id],[uniquePropertyId],[editorAlias],[macro],[macroPropertySortOrder],[macroPropertyAlias],[macroPropertyName]) VALUES (
2,'83c70339-98a0-4111-853c-2f0d4014a4fc',N'UmbracoForms.ThemePicker',1,1,N'FormTheme',N'Theme');
GO
INSERT INTO [cmsMacroProperty] ([id],[uniquePropertyId],[editorAlias],[macro],[macroPropertySortOrder],[macroPropertyAlias],[macroPropertyName]) VALUES (
3,'2d5fdda2-e19f-4103-b43e-269186fda969',N'Umbraco.TrueFalse',1,2,N'ExcludeScripts',N'Exclude Scripts');
GO
SET IDENTITY_INSERT [cmsMacroProperty] OFF;
GO
SET IDENTITY_INSERT [cmsDictionary] OFF;
GO
SET IDENTITY_INSERT [cmsLanguageText] OFF;
GO
SET IDENTITY_INSERT [cmsDataType] ON;
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
-28,-97,N'Umbraco.ListView',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
-27,-96,N'Umbraco.ListView',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
-26,-95,N'Umbraco.ListView',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
1,-49,N'Umbraco.TrueFalse',N'Integer');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
2,-51,N'Umbraco.Integer',N'Integer');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
3,-87,N'Umbraco.TinyMCEv3',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
4,-88,N'Umbraco.Textbox',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
5,-89,N'Umbraco.TextboxMultiple',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
6,-90,N'Umbraco.UploadField',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
7,-92,N'Umbraco.NoEdit',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
8,-36,N'Umbraco.DateTime',N'Date');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
9,-37,N'Umbraco.ColorPickerAlias',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
11,-39,N'Umbraco.DropDownMultiple',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
12,-40,N'Umbraco.RadioButtonList',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
13,-41,N'Umbraco.Date',N'Date');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
14,-42,N'Umbraco.DropDown',N'Integer');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
15,-43,N'Umbraco.CheckBoxList',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
22,1041,N'Umbraco.Tags',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
24,1043,N'Umbraco.ImageCropper',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
26,1046,N'Umbraco.ContentPicker2',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
27,1047,N'Umbraco.MemberPicker2',N'Nvarchar');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
28,1048,N'Umbraco.MediaPicker2',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
29,1049,N'Umbraco.MediaPicker2',N'Ntext');
GO
INSERT INTO [cmsDataType] ([pk],[nodeId],[propertyEditorAlias],[dbType]) VALUES (
30,1050,N'Umbraco.RelatedLinks2',N'Ntext');
GO
SET IDENTITY_INSERT [cmsDataType] OFF;
GO
SET IDENTITY_INSERT [cmsDataTypePreValues] ON;
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-9,-96,N'[{"alias":"updateDate","header":"Last edited","isSystem":1},{"alias":"owner","header":"Updated by","isSystem":1}]',5,N'includeProperties');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-8,-96,N'[{"name": "Grid","path": "views/propertyeditors/listview/layouts/grid/grid.html", "icon": "icon-thumbnails-small", "isSystem": 1, "selected": true},{"name": "List","path": "views/propertyeditors/listview/layouts/list/list.html","icon": "icon-list", "isSystem": 1,"selected": true}]',4,N'layouts');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-7,-96,N'desc',3,N'orderDirection');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-6,-96,N'updateDate',2,N'orderBy');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-5,-96,N'100',1,N'pageSize');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-4,-97,N'[{"alias":"username","isSystem":1},{"alias":"email","isSystem":1},{"alias":"updateDate","header":"Last edited","isSystem":1}]',4,N'includeProperties');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-3,-97,N'asc',3,N'orderDirection');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-2,-97,N'username',2,N'orderBy');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
-1,-97,N'10',1,N'pageSize');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
3,-87,N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|',0,N'');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
4,1041,N'default',0,N'group');
GO
INSERT INTO [cmsDataTypePreValues] ([id],[datatypeNodeId],[value],[sortorder],[alias]) VALUES (
6,1049,N'1',0,N'multiPicker');
GO
SET IDENTITY_INSERT [cmsDataTypePreValues] OFF;
GO
SET IDENTITY_INSERT [cmsContentType] ON;
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
531,1044,N'Member',N'icon-user',N'icon-user',NULL,0,0);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
532,1031,N'Folder',N'icon-folder',N'icon-folder',NULL,0,1);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
533,1032,N'Image',N'icon-picture',N'icon-picture',NULL,0,1);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
534,1033,N'File',N'icon-document',N'icon-document',NULL,0,1);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
536,1056,N'register',N'icon-document',N'folder.png',NULL,0,0);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
537,1058,N'login',N'icon-document',N'folder.png',NULL,0,0);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
540,1069,N'home',N'icon-document',N'folder.png',NULL,0,0);
GO
INSERT INTO [cmsContentType] ([pk],[nodeId],[alias],[icon],[thumbnail],[description],[isContainer],[allowAtRoot]) VALUES (
541,1078,N'error',N'icon-document',N'folder.png',NULL,0,0);
GO
SET IDENTITY_INSERT [cmsContentType] OFF;
GO
SET IDENTITY_INSERT [cmsPropertyTypeGroup] ON;
GO
INSERT INTO [cmsPropertyTypeGroup] ([id],[contenttypeNodeId],[text],[sortorder],[uniqueID]) VALUES (
3,1032,N'Image',1,'79ed4d07-254a-42cf-8fa9-ebe1c116a596');
GO
INSERT INTO [cmsPropertyTypeGroup] ([id],[contenttypeNodeId],[text],[sortorder],[uniqueID]) VALUES (
4,1033,N'File',1,'50899f9c-023a-4466-b623-aba9049885fe');
GO
INSERT INTO [cmsPropertyTypeGroup] ([id],[contenttypeNodeId],[text],[sortorder],[uniqueID]) VALUES (
5,1031,N'Contents',1,'79995fa2-63ee-453c-a29b-2e66f324cdbe');
GO
INSERT INTO [cmsPropertyTypeGroup] ([id],[contenttypeNodeId],[text],[sortorder],[uniqueID]) VALUES (
11,1044,N'Membership',1,'0756729d-d665-46e3-b84a-37aceaa614f8');
GO
SET IDENTITY_INSERT [cmsPropertyTypeGroup] OFF;
GO
SET IDENTITY_INSERT [cmsPropertyType] ON;
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
6,1043,1032,3,N'umbracoFile',N'Upload image',0,0,NULL,NULL,'00000006-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
7,-92,1032,3,N'umbracoWidth',N'Width',0,0,NULL,NULL,'00000007-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
8,-92,1032,3,N'umbracoHeight',N'Height',0,0,NULL,NULL,'00000008-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
9,-92,1032,3,N'umbracoBytes',N'Size',0,0,NULL,NULL,'00000009-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
10,-92,1032,3,N'umbracoExtension',N'Type',0,0,NULL,NULL,'0000000a-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
24,-90,1033,4,N'umbracoFile',N'Upload file',0,0,NULL,NULL,'00000018-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
25,-92,1033,4,N'umbracoExtension',N'Type',0,0,NULL,NULL,'00000019-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
26,-92,1033,4,N'umbracoBytes',N'Size',0,0,NULL,NULL,'0000001a-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
27,-96,1031,5,N'contents',N'Contents:',0,0,NULL,NULL,'0000001b-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
28,-89,1044,11,N'umbracoMemberComments',N'Comments',0,0,NULL,NULL,'0000001c-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
29,-92,1044,11,N'umbracoMemberFailedPasswordAttempts',N'Failed Password Attempts',1,0,NULL,NULL,'0000001d-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
30,-49,1044,11,N'umbracoMemberApproved',N'Is Approved',2,0,NULL,NULL,'0000001e-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
31,-49,1044,11,N'umbracoMemberLockedOut',N'Is Locked Out',3,0,NULL,NULL,'0000001f-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
32,-92,1044,11,N'umbracoMemberLastLockoutDate',N'Last Lockout Date',4,0,NULL,NULL,'00000020-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
33,-92,1044,11,N'umbracoMemberLastLogin',N'Last Login Date',5,0,NULL,NULL,'00000021-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
34,-92,1044,11,N'umbracoMemberLastPasswordChangeDate',N'Last Password Change Date',6,0,NULL,NULL,'00000022-0000-0000-0000-000000000000');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
35,-92,1044,NULL,N'umbracoMemberPasswordRetrievalAnswer',N'Password Answer',0,0,NULL,NULL,'7334901e-469b-47e4-8ba4-42f460098583');
GO
INSERT INTO [cmsPropertyType] ([id],[dataTypeId],[contentTypeId],[propertyTypeGroupId],[Alias],[Name],[sortOrder],[mandatory],[validationRegExp],[Description],[UniqueID]) VALUES (
36,-92,1044,NULL,N'umbracoMemberPasswordRetrievalQuestion',N'Password Question',1,0,NULL,NULL,'cc3fa6c6-20e9-46fe-a42c-636f49112a4a');
GO
SET IDENTITY_INSERT [cmsPropertyType] OFF;
GO
SET IDENTITY_INSERT [cmsPropertyData] ON;
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
397,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',35,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
398,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',36,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
399,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',28,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
400,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',29,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
401,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',30,1,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
402,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',31,0,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
403,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',32,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
404,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',33,NULL,NULL,{ts '2018-04-18 18:28:32.000'},NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
405,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',34,NULL,NULL,{ts '2018-04-18 18:08:46.000'},NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
406,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',35,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
407,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',36,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
408,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',28,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
409,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',29,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
410,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',30,1,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
411,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',31,0,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
412,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',32,NULL,NULL,NULL,NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
413,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',33,NULL,NULL,{ts '2018-04-18 18:29:37.000'},NULL,NULL);
GO
INSERT INTO [cmsPropertyData] ([id],[contentNodeId],[versionId],[propertytypeid],[dataInt],[dataDecimal],[dataDate],[dataNvarchar],[dataNtext]) VALUES (
414,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',34,NULL,NULL,{ts '2018-04-18 18:29:06.000'},NULL,NULL);
GO
SET IDENTITY_INSERT [cmsPropertyData] OFF;
GO
SET IDENTITY_INSERT [cmsMemberType] ON;
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
1,1044,35,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
2,1044,36,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
3,1044,28,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
4,1044,29,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
5,1044,30,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
6,1044,31,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
7,1044,32,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
8,1044,33,0,0,0);
GO
INSERT INTO [cmsMemberType] ([pk],[NodeId],[propertytypeId],[memberCanEdit],[viewOnProfile],[isSensitive]) VALUES (
9,1044,34,0,0,0);
GO
SET IDENTITY_INSERT [cmsMemberType] OFF;
GO
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (
1056,1055,1);
GO
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (
1058,1057,1);
GO
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (
1069,1071,1);
GO
INSERT INTO [cmsDocumentType] ([contentTypeNodeId],[templateNodeId],[IsDefault]) VALUES (
1078,1077,1);
GO
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId],[SortOrder]) VALUES (
1031,1031,0);
GO
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId],[SortOrder]) VALUES (
1031,1032,0);
GO
INSERT INTO [cmsContentTypeAllowedContentType] ([Id],[AllowedId],[SortOrder]) VALUES (
1031,1033,0);
GO
SET IDENTITY_INSERT [cmsContent] ON;
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
2,1059,1058);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
3,1060,1056);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
6,1072,1069);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
7,1073,1058);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
9,1079,1078);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
54,1131,1044);
GO
INSERT INTO [cmsContent] ([pk],[nodeId],[contentType]) VALUES (
55,1132,1044);
GO
SET IDENTITY_INSERT [cmsContent] OFF;
GO
INSERT INTO [cmsMember] ([nodeId],[Email],[LoginName],[Password]) VALUES (
1131,N'sdfsadf@asda.com',N'sdfsadf@ASDA.COM',N'DG6ONjQR1f1wpQkIgALP3Q==W/TfAZ7Ve9jn8cFo38RRa6HQBAiFHeAOZIyIKBYUYF0=');
GO
INSERT INTO [cmsMember] ([nodeId],[Email],[LoginName],[Password]) VALUES (
1132,N'regular@regular.com',N'regular@regular.com',N'7X39ZBOgF89omty7gUzD0A==dNXogNwpEnOeNvk+Fvu7Yprku3e6ky85pF39Uwp0kPg=');
GO
INSERT INTO [cmsMember2MemberGroup] ([Member],[MemberGroup]) VALUES (
1131,1075);
GO
INSERT INTO [cmsMember2MemberGroup] ([Member],[MemberGroup]) VALUES (
1132,1075);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,0,0,'f41c16c9-e1ba-434e-9679-00e87cbdd18d',N'Home',NULL,NULL,{ts '2018-04-10 18:40:32.060'},1071,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1059,0,0,'7a4caaf5-ba58-4afb-b7b5-25a1f1eea72c',N'Login',NULL,NULL,{ts '2018-04-10 13:16:21.350'},1057,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1073,0,0,'cdae12c6-7044-412d-9f56-2a5bc8714737',N'Login',NULL,NULL,{ts '2018-04-10 18:41:10.670'},1057,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,0,0,'beb38127-d30a-42b3-81a0-2b53e07a9d0a',N'Home',NULL,NULL,{ts '2018-04-10 18:40:28.687'},1071,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,0,0,'aabf4dbd-7fde-4422-b69e-3edd82fa4c5e',N'Home',NULL,NULL,{ts '2018-04-10 18:40:46.103'},1071,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,1,0,'9dc3d740-e00e-4cf1-a4c7-4563a1d9f1e1',N'Home',NULL,NULL,{ts '2018-04-11 15:32:10.637'},1071,1);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1059,0,0,'9c431456-76e7-4d80-9ce9-6c305c247589',N'Login',NULL,NULL,{ts '2018-04-10 18:40:55.947'},1057,1);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1079,1,0,'12e99577-c12c-47bb-8779-87d439d0b528',N'Error',NULL,NULL,{ts '2018-04-11 14:17:38.430'},1077,1);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1060,1,0,'c6efb28b-9a41-4e59-bf31-a62f5e9fa82b',N'Register',NULL,NULL,{ts '2018-04-10 18:41:40.577'},1055,1);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1059,0,0,'2925746d-e77c-4cd0-9fd8-ae130098eb12',N'Login',NULL,NULL,{ts '2018-04-10 18:40:21.640'},1057,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,0,0,'8b65abc6-e492-49b2-babb-b5b00dae5519',N'Home',NULL,NULL,{ts '2018-04-10 18:38:42.233'},1071,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1072,0,0,'7d8ed3b4-b8ed-4846-a8ca-bc8d3b608679',N'Home',NULL,NULL,{ts '2018-04-10 18:40:58.760'},1071,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1060,0,0,'519f85e2-9aa3-422c-b95d-c2925fe174fe',N'Register',NULL,NULL,{ts '2018-04-10 13:16:43.167'},1055,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1060,0,0,'d536e893-aa88-4816-ab5a-c6695f3c676f',N'Register',NULL,NULL,{ts '2018-04-10 18:41:29.653'},1055,0);
GO
INSERT INTO [cmsDocument] ([nodeId],[published],[documentUser],[versionId],[text],[releaseDate],[expireDate],[updateDate],[templateId],[newest]) VALUES (
1073,1,0,'e66f5e0c-7a7b-48f0-8727-fb2077c5463f',N'Login',NULL,NULL,{ts '2018-04-10 18:42:17.123'},1057,1);
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1060,N'<register id="1060" key="5f333e26-3602-45ea-8e21-a6647b4863cf" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2018-04-10T13:16:43" updateDate="2018-04-10T18:41:40" nodeName="Register" urlName="register" path="-1,1060" isDoc="" nodeType="1056" creatorName="artem" writerName="artem" writerID="0" template="1055" nodeTypeAlias="register" isPublished="true" />');
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1072,N'<home id="1072" key="9c0a71da-af2a-422a-9aab-d06da4396abc" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-04-10T18:38:42" updateDate="2018-04-11T15:32:10" nodeName="Home" urlName="home" path="-1,1072" isDoc="" nodeType="1069" creatorName="artem" writerName="artem" writerID="0" template="1071" nodeTypeAlias="home" isPublished="true" />');
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1073,N'<login id="1073" key="6cbf1d52-8a74-43ac-86e8-592f124edaf4" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2018-04-10T18:41:10" updateDate="2018-04-10T18:42:17" nodeName="Login" urlName="login" path="-1,1073" isDoc="" nodeType="1058" creatorName="artem" writerName="artem" writerID="0" template="1057" nodeTypeAlias="login" isPublished="true" />');
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1079,N'<error id="1079" key="0157e764-a111-4584-a108-859317eb3b7b" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2018-04-11T14:17:38" updateDate="2018-04-11T14:17:38" nodeName="Error" urlName="error" path="-1,1079" isDoc="" nodeType="1078" creatorName="artem" writerName="artem" writerID="0" template="1077" nodeTypeAlias="error" isPublished="true" />');
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1131,N'<Member id="1131" key="c8073ef2-248a-4d1a-9b58-79472e9a7cca" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2018-04-18T18:08:45" updateDate="2018-04-18T18:28:32" nodeName="sdfsadf@ASDA.COM" urlName="sdfsadf-asdacom" path="-1,1131" isDoc="" nodeType="1044" nodeTypeAlias="Member" loginName="sdfsadf@ASDA.COM" email="sdfsadf@asda.com" icon="icon-user"><umbracoMemberApproved>1</umbracoMemberApproved><umbracoMemberLockedOut>0</umbracoMemberLockedOut><umbracoMemberLastLogin><![CDATA[18/04/2018 18:28:32]]></umbracoMemberLastLogin><umbracoMemberLastPasswordChangeDate><![CDATA[18/04/2018 18:08:46]]></umbracoMemberLastPasswordChangeDate></Member>');
GO
INSERT INTO [cmsContentXml] ([nodeId],[xml]) VALUES (
1132,N'<Member id="1132" key="a7f08c96-6722-4ae6-b0df-fcb6d788f215" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2018-04-18T18:29:06" updateDate="2018-04-18T18:29:37" nodeName="regular@regular.com" urlName="regular-regularcom" path="-1,1132" isDoc="" nodeType="1044" nodeTypeAlias="Member" loginName="regular@regular.com" email="regular@regular.com" icon="icon-user"><umbracoMemberApproved>1</umbracoMemberApproved><umbracoMemberLockedOut>0</umbracoMemberLockedOut><umbracoMemberLastLogin><![CDATA[18/04/2018 18:29:37]]></umbracoMemberLastLogin><umbracoMemberLastPasswordChangeDate><![CDATA[18/04/2018 18:29:06]]></umbracoMemberLastPasswordChangeDate></Member>');
GO
SET IDENTITY_INSERT [cmsContentVersion] ON;
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
3,1059,'7a4caaf5-ba58-4afb-b7b5-25a1f1eea72c',{ts '2018-04-10 13:16:21.350'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
4,1060,'519f85e2-9aa3-422c-b95d-c2925fe174fe',{ts '2018-04-10 13:16:43.167'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
11,1072,'8b65abc6-e492-49b2-babb-b5b00dae5519',{ts '2018-04-10 18:38:42.233'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
12,1059,'2925746d-e77c-4cd0-9fd8-ae130098eb12',{ts '2018-04-10 18:40:21.640'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
13,1072,'beb38127-d30a-42b3-81a0-2b53e07a9d0a',{ts '2018-04-10 18:40:28.687'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
14,1072,'f41c16c9-e1ba-434e-9679-00e87cbdd18d',{ts '2018-04-10 18:40:32.060'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
15,1072,'aabf4dbd-7fde-4422-b69e-3edd82fa4c5e',{ts '2018-04-10 18:40:46.103'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
16,1059,'9c431456-76e7-4d80-9ce9-6c305c247589',{ts '2018-04-10 18:40:55.947'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
17,1072,'7d8ed3b4-b8ed-4846-a8ca-bc8d3b608679',{ts '2018-04-10 18:40:58.760'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
18,1073,'cdae12c6-7044-412d-9f56-2a5bc8714737',{ts '2018-04-10 18:41:10.670'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
19,1060,'d536e893-aa88-4816-ab5a-c6695f3c676f',{ts '2018-04-10 18:41:29.653'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
20,1060,'c6efb28b-9a41-4e59-bf31-a62f5e9fa82b',{ts '2018-04-10 18:41:40.577'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
21,1072,'9dc3d740-e00e-4cf1-a4c7-4563a1d9f1e1',{ts '2018-04-11 15:32:10.637'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
22,1073,'e66f5e0c-7a7b-48f0-8727-fb2077c5463f',{ts '2018-04-10 18:42:17.123'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
24,1079,'12e99577-c12c-47bb-8779-87d439d0b528',{ts '2018-04-11 14:17:38.430'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
71,1131,'540bb1fe-1ca9-4d3f-83f6-e664daf8f846',{ts '2018-04-18 18:28:32.267'});
GO
INSERT INTO [cmsContentVersion] ([id],[ContentId],[VersionId],[VersionDate]) VALUES (
72,1132,'38c2e782-fc7d-4cfb-a561-c0bb04164d9c',{ts '2018-04-18 18:29:37.360'});
GO
SET IDENTITY_INSERT [cmsContentVersion] OFF;
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1059,'7a4caaf5-ba58-4afb-b7b5-25a1f1eea72c',{ts '2018-04-10 13:16:21.367'},N'<login id="1059" key="fd31589d-6962-4de4-a211-713285b36c74" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-04-10T13:16:21" updateDate="2018-04-10T13:16:21" nodeName="Login" urlName="login" path="-1,1059" isDoc="" nodeType="1058" creatorName="artem" writerName="artem" writerID="0" template="1057" nodeTypeAlias="login" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1060,'c6efb28b-9a41-4e59-bf31-a62f5e9fa82b',{ts '2018-04-10 18:41:40.600'},N'<register id="1060" key="5f333e26-3602-45ea-8e21-a6647b4863cf" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2018-04-10T13:16:43" updateDate="2018-04-10T18:41:40" nodeName="Register" urlName="register" path="-1,1060" isDoc="" nodeType="1056" creatorName="artem" writerName="artem" writerID="0" template="1055" nodeTypeAlias="register" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1060,'519f85e2-9aa3-422c-b95d-c2925fe174fe',{ts '2018-04-10 13:16:43.190'},N'<register id="1060" key="5f333e26-3602-45ea-8e21-a6647b4863cf" parentID="-1" level="1" creatorID="0" sortOrder="1" createDate="2018-04-10T13:16:43" updateDate="2018-04-10T13:16:43" nodeName="Register" urlName="register" path="-1,1060" isDoc="" nodeType="1056" creatorName="artem" writerName="artem" writerID="0" template="1055" nodeTypeAlias="register" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1072,'f41c16c9-e1ba-434e-9679-00e87cbdd18d',{ts '2018-04-10 18:40:32.080'},N'<home id="1072" key="9c0a71da-af2a-422a-9aab-d06da4396abc" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2018-04-10T18:38:42" updateDate="2018-04-10T18:40:32" nodeName="Home" urlName="home" path="-1,1072" isDoc="" nodeType="1069" creatorName="artem" writerName="artem" writerID="0" template="1071" nodeTypeAlias="home" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1072,'9dc3d740-e00e-4cf1-a4c7-4563a1d9f1e1',{ts '2018-04-11 15:32:10.687'},N'<home id="1072" key="9c0a71da-af2a-422a-9aab-d06da4396abc" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-04-10T18:38:42" updateDate="2018-04-11T15:32:10" nodeName="Home" urlName="home" path="-1,1072" isDoc="" nodeType="1069" creatorName="artem" writerName="artem" writerID="0" template="1071" nodeTypeAlias="home" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1072,'8b65abc6-e492-49b2-babb-b5b00dae5519',{ts '2018-04-10 18:38:42.247'},N'<home id="1072" key="9c0a71da-af2a-422a-9aab-d06da4396abc" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2018-04-10T18:38:42" updateDate="2018-04-10T18:38:42" nodeName="Home" urlName="home" path="-1,1072" isDoc="" nodeType="1069" creatorName="artem" writerName="artem" writerID="0" template="1071" nodeTypeAlias="home" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1072,'7d8ed3b4-b8ed-4846-a8ca-bc8d3b608679',{ts '2018-04-10 18:40:58.767'},N'<home id="1072" key="9c0a71da-af2a-422a-9aab-d06da4396abc" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2018-04-10T18:38:42" updateDate="2018-04-10T18:40:58" nodeName="Home" urlName="home" path="-1,1072" isDoc="" nodeType="1069" creatorName="artem" writerName="artem" writerID="0" template="1071" nodeTypeAlias="home" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1073,'cdae12c6-7044-412d-9f56-2a5bc8714737',{ts '2018-04-10 18:41:10.693'},N'<login id="1073" key="6cbf1d52-8a74-43ac-86e8-592f124edaf4" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2018-04-10T18:41:10" updateDate="2018-04-10T18:41:10" nodeName="Login" urlName="login" path="-1,1073" isDoc="" nodeType="1058" creatorName="artem" writerName="artem" writerID="0" template="1057" nodeTypeAlias="login" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1073,'e66f5e0c-7a7b-48f0-8727-fb2077c5463f',{ts '2018-04-10 18:42:17.127'},N'<login id="1073" key="6cbf1d52-8a74-43ac-86e8-592f124edaf4" parentID="-1" level="1" creatorID="0" sortOrder="2" createDate="2018-04-10T18:41:10" updateDate="2018-04-10T18:42:17" nodeName="Login" urlName="login" path="-1,1073" isDoc="" nodeType="1058" creatorName="artem" writerName="artem" writerID="0" template="1057" nodeTypeAlias="login" isPublished="true" />');
GO
INSERT INTO [cmsPreviewXml] ([nodeId],[versionId],[timestamp],[xml]) VALUES (
1079,'12e99577-c12c-47bb-8779-87d439d0b528',{ts '2018-04-11 14:17:38.457'},N'<error id="1079" key="0157e764-a111-4584-a108-859317eb3b7b" parentID="-1" level="1" creatorID="0" sortOrder="3" createDate="2018-04-11T14:17:38" updateDate="2018-04-11T14:17:38" nodeName="Error" urlName="error" path="-1,1079" isDoc="" nodeType="1078" creatorName="artem" writerName="artem" writerID="0" template="1077" nodeTypeAlias="error" isPublished="true" />');
GO
INSERT INTO [airFlowTwoFactorLogin] ([nodeId],[token],[token_expiration]) VALUES (
1131,NULL,NULL);
GO
INSERT INTO [airFlowMemberRegistration] ([nodeId],[email_confirmed],[confirmation_token],[confirmation_token_expiration],[confirmation_date],[login_type]) VALUES (
1131,1,N'WbgNlotIXh7Afp2dB4ldgcE9Z5QUWsLBNGIYD0fiEak',{ts '2018-04-19 15:08:45.703'},{ts '2018-04-18 15:17:01.283'},1);
GO
INSERT INTO [airFlowMemberRegistration] ([nodeId],[email_confirmed],[confirmation_token],[confirmation_token_expiration],[confirmation_date],[login_type]) VALUES (
1132,1,N'Gytk_Sq4M_75T5QT3uMaMZD39IxODHf6nCMTeJFNMSg',{ts '2018-04-19 15:29:06.673'},{ts '2018-04-18 15:29:18.233'},0);
GO
ALTER TABLE [umbracoUser] ADD CONSTRAINT [PK_user] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserLogin] ADD CONSTRAINT [PK_umbracoUserLogin] PRIMARY KEY ([sessionId]);
GO
ALTER TABLE [umbracoServer] ADD CONSTRAINT [PK_umbracoServer] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [PK_structure] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [PK_userStartNode] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [PK_umbracoUserGroup] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [PK_umbracoUserGroup2NodePermission] PRIMARY KEY ([userGroupId],[nodeId],[permission]);
GO
ALTER TABLE [umbracoUserGroup2App] ADD CONSTRAINT [PK_userGroup2App] PRIMARY KEY ([userGroupId],[app]);
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [PK_user2userGroup] PRIMARY KEY ([userId],[userGroupId]);
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY ([userId],[nodeId],[action]);
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [PK_umbracoRelation] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoRedirectUrl] ADD CONSTRAINT [PK_umbracoRedirectUrl] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoMigration] ADD CONSTRAINT [PK_umbracoMigration] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoLog] ADD CONSTRAINT [PK_umbracoLog] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoLock] ADD CONSTRAINT [PK_umbracoLock] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoLanguage] ADD CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoExternalLogin] ADD CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoDomains] ADD CONSTRAINT [PK_umbracoDomains] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoConsent] ADD CONSTRAINT [PK_umbracoConsent] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoCacheInstruction] ADD CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoAudit] ADD CONSTRAINT [PK_umbracoAudit] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [PK_umbracoAccess] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY ([id]);
GO
ALTER TABLE [UFUserFormSecurity] ADD CONSTRAINT [Id] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecords] ADD CONSTRAINT [PK_UFRecords] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecordFields] ADD CONSTRAINT [PK_UFRecordFields] PRIMARY KEY ([Key]);
GO
ALTER TABLE [UFRecordDataString] ADD CONSTRAINT [PK_UFRecordDataString] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecordDataLongString] ADD CONSTRAINT [PK_UFRecordDataLongString] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecordDataInteger] ADD CONSTRAINT [PK_UFRecordDataInteger] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecordDataDateTime] ADD CONSTRAINT [PK_UFRecordDataDateTime] PRIMARY KEY ([Id]);
GO
ALTER TABLE [UFRecordDataBit] ADD CONSTRAINT [PK_UFRecordDataBit] PRIMARY KEY ([Id]);
GO
ALTER TABLE [cmsTemplate] ADD CONSTRAINT [PK_cmsTemplate] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsTaskType] ADD CONSTRAINT [PK_cmsTaskType] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsTask] ADD CONSTRAINT [PK_cmsTask] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsTags] ADD CONSTRAINT [PK_cmsTags] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [PK_cmsMacro] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsDictionary] ADD CONSTRAINT [PK_cmsDictionary] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsLanguageText] ADD CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [PK_cmsDataType] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsDataTypePreValues] ADD CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsContentType2ContentType] ADD CONSTRAINT [PK_cmsContentType2ContentType] PRIMARY KEY ([parentContentTypeId],[childContentTypeId]);
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [PK_cmsContentType] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsPropertyTypeGroup] ADD CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsMemberType] ADD CONSTRAINT [PK_cmsMemberType] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY ([contentTypeNodeId],[templateNodeId]);
GO
ALTER TABLE [cmsContentTypeAllowedContentType] ADD CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY ([Id],[AllowedId]);
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [PK_cmsContent] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY ([nodeId],[propertyTypeId],[tagId]);
GO
ALTER TABLE [cmsMember] ADD CONSTRAINT [PK_cmsMember] PRIMARY KEY ([nodeId]);
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY ([Member],[MemberGroup]);
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [PK_cmsMedia] PRIMARY KEY ([versionId]);
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [PK_cmsDocument] PRIMARY KEY ([versionId]);
GO
ALTER TABLE [cmsContentXml] ADD CONSTRAINT [PK_cmsContentXml] PRIMARY KEY ([nodeId]);
GO
ALTER TABLE [cmsContentVersion] ADD CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPreviewXml] ADD CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY ([nodeId],[versionId]);
GO
CREATE INDEX [IX_umbracoUser_userLogin] ON [umbracoUser] ([userLogin] ASC);
GO
ALTER TABLE [umbracoServer] ADD CONSTRAINT [IX_computerName] UNIQUE ([computerName]);
GO
CREATE INDEX [IX_umbracoServer_isActive] ON [umbracoServer] ([isActive] ASC);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_alias] UNIQUE ([alias]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_name] UNIQUE ([name]);
GO
ALTER TABLE [umbracoRelationType] ADD CONSTRAINT [IX_umbracoRelationType_UniqueId] UNIQUE ([typeUniqueId]);
GO
CREATE INDEX [IX_umbracoNodeObjectType] ON [umbracoNode] ([nodeObjectType] ASC);
GO
CREATE INDEX [IX_umbracoNodeParentId] ON [umbracoNode] ([parentID] ASC);
GO
CREATE INDEX [IX_umbracoNodePath] ON [umbracoNode] ([path] ASC);
GO
CREATE INDEX [IX_umbracoNodeTrashed] ON [umbracoNode] ([trashed] ASC);
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [IX_umbracoNodeUniqueID] UNIQUE ([uniqueID]);
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [IX_umbracoUserStartNode_startNodeType] UNIQUE ([startNodeType],[startNode],[userId]);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [IX_umbracoUserGroup_userGroupAlias] UNIQUE ([userGroupAlias]);
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [IX_umbracoUserGroup_userGroupName] UNIQUE ([userGroupName]);
GO
CREATE INDEX [IX_umbracoUser2NodePermission_nodeId] ON [umbracoUserGroup2NodePermission] ([nodeId] ASC);
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [IX_umbracoRelation_parentChildType] UNIQUE ([parentId],[childId],[relType]);
GO
ALTER TABLE [umbracoRedirectUrl] ADD CONSTRAINT [IX_umbracoRedirectUrl] UNIQUE ([urlHash],[contentKey],[createDateUtc]);
GO
ALTER TABLE [umbracoMigration] ADD CONSTRAINT [IX_umbracoMigration] UNIQUE ([name],[version]);
GO
CREATE INDEX [IX_umbracoLog] ON [umbracoLog] ([NodeId] ASC);
GO
ALTER TABLE [umbracoLanguage] ADD CONSTRAINT [IX_umbracoLanguage_languageISOCode] UNIQUE ([languageISOCode]);
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [IX_umbracoAccess_nodeId] UNIQUE ([nodeId]);
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [IX_umbracoAccessRule] UNIQUE ([ruleValue],[ruleType],[accessId]);
GO
CREATE INDEX [IX_datastring_recordfield] ON [UFRecordDataString] ([Key] ASC);
GO
CREATE INDEX [IX_datalongstring_recordfield] ON [UFRecordDataLongString] ([Key] ASC);
GO
CREATE INDEX [IX_datainteger_recordfield] ON [UFRecordDataInteger] ([Key] ASC);
GO
CREATE INDEX [IX_datadatetime_recordfield] ON [UFRecordDataDateTime] ([Key] ASC);
GO
CREATE INDEX [IX_databit_recordfield] ON [UFRecordDataBit] ([Key] ASC);
GO
ALTER TABLE [cmsTemplate] ADD CONSTRAINT [IX_cmsTemplate_nodeId] UNIQUE ([nodeId]);
GO
CREATE INDEX [IX_cmsTaskType_alias] ON [cmsTaskType] ([alias] ASC);
GO
CREATE INDEX [IX_cmsTags] ON [cmsTags] ([tag] ASC,[group] ASC);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [IX_cmsMacro_UniqueId] UNIQUE ([uniqueId]);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [IX_cmsMacroPropertyAlias] UNIQUE ([macroAlias]);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [IX_cmsMacroProperty_Alias] UNIQUE ([macro],[macroPropertyAlias]);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [IX_cmsMacroProperty_UniquePropertyId] UNIQUE ([uniquePropertyId]);
GO
ALTER TABLE [cmsDictionary] ADD CONSTRAINT [IX_cmsDictionary_id] UNIQUE ([id]);
GO
CREATE INDEX [IX_cmsDictionary_key] ON [cmsDictionary] ([key] ASC);
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [IX_cmsDataType_nodeId] UNIQUE ([nodeId]);
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [IX_cmsContentType] UNIQUE ([nodeId]);
GO
CREATE INDEX [IX_cmsContentType_icon] ON [cmsContentType] ([icon] ASC);
GO
ALTER TABLE [cmsPropertyTypeGroup] ADD CONSTRAINT [IX_cmsPropertyTypeGroupUniqueID] UNIQUE ([uniqueID]);
GO
CREATE INDEX [IX_cmsPropertyTypeAlias] ON [cmsPropertyType] ([Alias] ASC);
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [IX_cmsPropertyTypeUniqueID] UNIQUE ([UniqueID]);
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [IX_cmsPropertyData_1] UNIQUE ([contentNodeId],[versionId],[propertytypeid]);
GO
CREATE INDEX [IX_cmsPropertyData_2] ON [cmsPropertyData] ([versionId] ASC);
GO
CREATE INDEX [IX_cmsPropertyData_3] ON [cmsPropertyData] ([propertytypeid] ASC);
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [IX_cmsContent] UNIQUE ([nodeId]);
GO
CREATE INDEX [IX_cmsMember_LoginName] ON [cmsMember] ([LoginName] ASC);
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [IX_cmsMedia] UNIQUE ([nodeId],[versionId],[mediaPath]);
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [IX_cmsDocument] UNIQUE ([nodeId],[versionId]);
GO
CREATE INDEX [IX_cmsDocument_newest] ON [cmsDocument] ([newest] ASC);
GO
CREATE INDEX [IX_cmsDocument_published] ON [cmsDocument] ([published] ASC);
GO
CREATE INDEX [IX_cmsContentVersion_ContentId] ON [cmsContentVersion] ([ContentId] ASC);
GO
ALTER TABLE [cmsContentVersion] ADD CONSTRAINT [IX_cmsContentVersion_VersionId] UNIQUE ([VersionId]);
GO
ALTER TABLE [airFlowTwoFactorLogin] ADD CONSTRAINT [UN_airFlowTwoFactorLogin_token] UNIQUE ([token]);
GO
CREATE INDEX [IX_airFlowMemberRegistration_token] ON [airFlowMemberRegistration] ([confirmation_token] ASC);
GO
ALTER TABLE [airFlowMemberRegistration] ADD CONSTRAINT [UN_cmsMemberSecurity_confirmation_token] UNIQUE ([confirmation_token]);
GO
ALTER TABLE [umbracoUserLogin] ADD CONSTRAINT [FK_umbracoUserLogin_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoNode] ADD CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY ([parentID]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [FK_umbracoUserStartNode_umbracoNode_id] FOREIGN KEY ([startNode]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserStartNode] ADD CONSTRAINT [FK_umbracoUserStartNode_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [FK_startContentId_umbracoNode_id] FOREIGN KEY ([startContentId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup] ADD CONSTRAINT [FK_startMediaId_umbracoNode_id] FOREIGN KEY ([startMediaId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2NodePermission] ADD CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUserGroup2App] ADD CONSTRAINT [FK_umbracoUserGroup2App_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2UserGroup] ADD CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUserGroup_id] FOREIGN KEY ([userGroupId]) REFERENCES [umbracoUserGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoUser2NodeNotify] ADD CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY ([parentId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY ([childId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRelation] ADD CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY ([relType]) REFERENCES [umbracoRelationType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoRedirectUrl] ADD CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID] FOREIGN KEY ([contentKey]) REFERENCES [umbracoNode]([uniqueID]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoDomains] ADD CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY ([domainRootStructureID]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY ([loginNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccess] ADD CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY ([noAccessNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoAccessRule] ADD CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY ([accessId]) REFERENCES [umbracoAccess]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [UFRecordDataString] ADD CONSTRAINT [FK_UFRecordDataString_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [UFRecordFields]([Key]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [UFRecordDataLongString] ADD CONSTRAINT [FK_UFRecordDataLongString_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [UFRecordFields]([Key]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [UFRecordDataInteger] ADD CONSTRAINT [FK_UFRecordDataInteger_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [UFRecordFields]([Key]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [UFRecordDataDateTime] ADD CONSTRAINT [FK_UFRecordDataDateTime_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [UFRecordFields]([Key]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [UFRecordDataBit] ADD CONSTRAINT [FK_UFRecordDataBit_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [UFRecordFields]([Key]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTemplate] ADD CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTask] ADD CONSTRAINT [FK_cmsTask_cmsTaskType_id] FOREIGN KEY ([taskTypeId]) REFERENCES [cmsTaskType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTask] ADD CONSTRAINT [FK_cmsTask_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTask] ADD CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY ([parentUserId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTask] ADD CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY ([userId]) REFERENCES [umbracoUser]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTags] ADD CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY ([ParentId]) REFERENCES [cmsTags]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY ([macro]) REFERENCES [cmsMacro]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDictionary] ADD CONSTRAINT [FK_cmsDictionary_cmsDictionary_id] FOREIGN KEY ([parent]) REFERENCES [cmsDictionary]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsLanguageText] ADD CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id] FOREIGN KEY ([UniqueId]) REFERENCES [cmsDictionary]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsLanguageText] ADD CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY ([languageId]) REFERENCES [umbracoLanguage]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDataType] ADD CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDataTypePreValues] ADD CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY ([datatypeNodeId]) REFERENCES [cmsDataType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentType2ContentType] ADD CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child] FOREIGN KEY ([childContentTypeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentType2ContentType] ADD CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent] FOREIGN KEY ([parentContentTypeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentType] ADD CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyTypeGroup] ADD CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId] FOREIGN KEY ([contenttypeNodeId]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId] FOREIGN KEY ([contentTypeId]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId] FOREIGN KEY ([dataTypeId]) REFERENCES [cmsDataType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY ([propertyTypeGroupId]) REFERENCES [cmsPropertyTypeGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY ([propertytypeid]) REFERENCES [cmsPropertyType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY ([contentNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMemberType] ADD CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId] FOREIGN KEY ([NodeId]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMemberType] ADD CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY ([NodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId] FOREIGN KEY ([contentTypeNodeId]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId] FOREIGN KEY ([templateNodeId]) REFERENCES [cmsTemplate]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocumentType] ADD CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY ([contentTypeNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentTypeAllowedContentType] ADD CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY ([Id]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentTypeAllowedContentType] ADD CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY ([AllowedId]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [FK_cmsContent_cmsContentType_nodeId] FOREIGN KEY ([contentType]) REFERENCES [cmsContentType]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContent] ADD CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [FK_cmsTagRelationship_cmsContent] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY ([propertyTypeId]) REFERENCES [cmsPropertyType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY ([tagId]) REFERENCES [cmsTags]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember] ADD CONSTRAINT [FK_cmsMember_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember] ADD CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY ([Member]) REFERENCES [cmsMember]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMember2MemberGroup] ADD CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY ([MemberGroup]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [FK_cmsMedia_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMedia] ADD CONSTRAINT [FK_cmsMedia_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [FK_cmsDocument_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId] FOREIGN KEY ([templateId]) REFERENCES [cmsTemplate]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsDocument] ADD CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentXml] ADD CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsContentVersion] ADD CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY ([ContentId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPreviewXml] ADD CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsContent]([nodeId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPreviewXml] ADD CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY ([versionId]) REFERENCES [cmsContentVersion]([VersionId]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [airFlowTwoFactorLogin] ADD CONSTRAINT [FK_airFlowTwoFactorLogin_cmsMember_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsMember]([nodeId]) ON DELETE CASCADE ON UPDATE NO ACTION;
GO
ALTER TABLE [airFlowMemberRegistration] ADD CONSTRAINT [FK_cmsMemberSecurity_cmsMember_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [cmsMember]([nodeId]) ON DELETE CASCADE ON UPDATE NO ACTION;
GO