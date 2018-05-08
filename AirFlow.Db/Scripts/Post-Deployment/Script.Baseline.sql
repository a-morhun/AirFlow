INSERT INTO airFlowDbVersions([version]) VALUES (1);
GO

SET IDENTITY_INSERT [umbracoUser] ON;
GO
INSERT INTO [umbracoUser] ([id],[userDisabled],[userNoConsole],[userName],[userLogin],[userPassword],[passwordConfig],[userEmail],[userLanguage],[securityStampToken],[failedLoginAttempts],[lastLockoutDate],[lastPasswordChangeDate],[lastLoginDate],[emailConfirmedDate],[invitedDate],[createDate],[updateDate],[avatar],[tourData]) VALUES (
0,0,0,N'admin',N'admin@admin.com',N'vJ5+oiGdZW7Dx2uaGy1ghw==tgkJvFEpfe7da8Z64EggZGICGixk7mW8lmMyrhBQRC0=',N'{"hashAlgorithm":"HMACSHA256"}',N'admin@admin.com',N'en-US',N'63df5b4a-569a-4d1e-a10c-5eb79c490fac',NULL,NULL,{ts '2018-04-20 14:40:16.110'},{ts '2018-04-20 14:40:16.593'},NULL,NULL,{ts '2018-04-20 14:40:13.887'},{ts '2018-04-20 14:40:16.673'},NULL,NULL);
GO
SET IDENTITY_INSERT [umbracoUser] OFF;
GO
SET IDENTITY_INSERT [umbracoServer] ON;
GO
INSERT INTO [umbracoServer] ([id],[address],[computerName],[registeredDate],[lastNotifiedDate],[isActive],[isMaster]) VALUES (
1,N'http://localhost:51356/umbraco',N'UA00500//LM/W3SVC/2/ROOT',{ts '2018-04-20 14:40:39.390'},{ts '2018-04-20 14:40:39.390'},1,1);
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
-1,0,-1,0,0,N'-1',0,'916724a5-173d-4619-b97e-b9de133dd6f5',N'SYSTEM DATA: umbraco master root','ea7d8624-4cfe-4578-a871-24aa946bf34d',{ts '2018-04-20 14:40:11.237'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-97,0,-1,0,1,N'-1,-97',2,'aa2c52a0-ce87-4e65-a47c-7df09358585d',N'List View - Members','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-96,0,-1,0,1,N'-1,-96',2,'3a0156c4-3b8c-4803-bdc1-6871faa83fff',N'List View - Media','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-95,0,-1,0,1,N'-1,-95',2,'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4',N'List View - Content','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-92,0,-1,0,1,N'-1,-92',35,'f0bc4bfb-b499-40d6-ba86-058885a5178c',N'Label','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.243'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-90,0,-1,0,1,N'-1,-90',34,'84c6b441-31df-4ffe-b67e-67d5bc3ae65a',N'Upload','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.243'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-89,0,-1,0,1,N'-1,-89',33,'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3',N'Textarea','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.247'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-88,0,-1,0,1,N'-1,-88',32,'0cc0eba1-9960-42c9-bf9b-60e150b429ae',N'Textstring','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.247'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-87,0,-1,0,1,N'-1,-87',4,'ca90c950-0aff-4e72-b976-a30b1ac57dad',N'Richtext editor','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.247'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-51,0,-1,0,1,N'-1,-51',2,'2e6d3631-066e-44b8-aec4-96f09099b2b5',N'Numeric','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.250'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-49,0,-1,0,1,N'-1,-49',2,'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49',N'True/false','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.250'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-43,0,-1,0,1,N'-1,-43',2,'fbaf13a8-4036-41f2-93a3-974f678c312a',N'Checkbox list','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.250'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-42,0,-1,0,1,N'-1,-42',2,'0b6a45e7-44ba-430d-9da5-4e46060b9e03',N'Dropdown','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.250'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-41,0,-1,0,1,N'-1,-41',2,'5046194e-4237-453c-a547-15db3a07c4e1',N'Date Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.250'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-40,0,-1,0,1,N'-1,-40',2,'bb5f57c9-ce2b-4bb9-b697-4caca783a805',N'Radiobox','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.253'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-39,0,-1,0,1,N'-1,-39',2,'f38f0ac7-1d27-439c-9f3f-089cd8825a53',N'Dropdown multiple','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.253'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-37,0,-1,0,1,N'-1,-37',2,'0225af17-b302-49cb-9176-b9f35cab9c17',N'Approved Color','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-36,0,-1,0,1,N'-1,-36',2,'e4d66c0f-b935-4200-81f0-025f7256b89a',N'Date Picker with time','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-21,0,-1,0,0,N'-1,-21',0,'bf7c7cbc-952f-4518-97a2-69e9c7b33842',N'Recycle Bin','cf3d8e34-1c1c-41e9-ae56-878b57b32113',{ts '2018-04-20 14:40:11.243'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
-20,0,-1,0,0,N'-1,-20',0,'0f582a79-1e41-4cf0-bfa0-76340651891a',N'Recycle Bin','01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8',{ts '2018-04-20 14:40:11.243'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1031,0,-1,0,1,N'-1,1031',2,'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d',N'Folder','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-20 14:40:11.257'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1032,0,-1,0,1,N'-1,1032',2,'cc07b313-0843-4aa8-bbda-871c8da728c8',N'Image','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1033,0,-1,0,1,N'-1,1033',2,'4c52d8ab-54e6-40cd-999c-7a5f24903e4d',N'File','4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1041,0,-1,0,1,N'-1,1041',2,'b6b73142-b9c1-4bf8-a16d-e1c23320b549',N'Tags','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1043,0,-1,0,1,N'-1,1043',2,'1df9f033-e6d4-451f-b8d2-e0cbc50a836f',N'Image Cropper','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1044,0,-1,0,1,N'-1,1044',0,'d59be02f-1df9-4228-aa1e-01917d806cda',N'Member','9b5416fb-e72f-45a9-a07b-5a9a2709ce43',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1046,0,-1,0,1,N'-1,1046',2,'fd1e0da5-5606-4862-b679-5d0cf3a52a59',N'Content Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.260'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1047,0,-1,0,1,N'-1,1047',2,'1ea2e01f-ebd8-4ce1-8d71-6b1149e63548',N'Member Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.263'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1048,0,-1,0,1,N'-1,1048',2,'135d60e0-64d9-49ed-ab08-893c9ba44ae5',N'Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.263'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1049,0,-1,0,1,N'-1,1049',2,'9dbbcbbb-2327-434a-b355-af1b84e5010a',N'Multiple Media Picker','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.263'});
INSERT INTO [umbracoNode] ([id],[trashed],[parentID],[nodeUser],[level],[path],[sortOrder],[uniqueID],[text],[nodeObjectType],[createDate]) VALUES (
1050,0,-1,0,1,N'-1,1050',2,'b4e3535a-1753-47e2-8568-602cf8cfee6f',N'Related Links','30a2a501-1978-4ddb-a57b-f7efed43ba3c',{ts '2018-04-20 14:40:11.263'});
GO
SET IDENTITY_INSERT [umbracoNode] OFF;
GO
SET IDENTITY_INSERT [umbracoUserStartNode] OFF;
GO
SET IDENTITY_INSERT [umbracoUserGroup] ON;
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
1,N'admin',N'Administrators',N'CADMOSKTPIURZ:5F7ï',{ts '2018-04-20 14:40:15.037'},{ts '2018-04-20 14:40:15.037'},N'icon-medal',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
2,N'writer',N'Writers',N'CAH:F',{ts '2018-04-20 14:40:15.037'},{ts '2018-04-20 14:40:15.037'},N'icon-edit',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
3,N'editor',N'Editors',N'CADMOSKTPUZ:5Fï',{ts '2018-04-20 14:40:15.037'},{ts '2018-04-20 14:40:15.037'},N'icon-tools',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
4,N'translator',N'Translators',N'AF',{ts '2018-04-20 14:40:15.040'},{ts '2018-04-20 14:40:15.040'},N'icon-globe',-1,-1);
GO
INSERT INTO [umbracoUserGroup] ([id],[userGroupAlias],[userGroupName],[userGroupDefaultPermissions],[createDate],[updateDate],[icon],[startContentId],[startMediaId]) VALUES (
5,N'sensitiveData',N'Sensitive data',N'',{ts '2018-04-20 14:40:15.040'},{ts '2018-04-20 14:40:15.040'},N'icon-lock',-1,-1);
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
SET IDENTITY_INSERT [umbracoRelation] OFF;
GO
SET IDENTITY_INSERT [umbracoMigration] ON;
GO
INSERT INTO [umbracoMigration] ([id],[name],[createDate],[version]) VALUES (
1,N'Umbraco',{ts '2018-04-20 14:40:14.813'},N'7.10.2');
GO
SET IDENTITY_INSERT [umbracoMigration] OFF;
GO
SET IDENTITY_INSERT [umbracoLog] ON;
GO
INSERT INTO [umbracoLog] ([id],[userId],[NodeId],[Datestamp],[logHeader],[logComment]) VALUES (
1,0,-1,{ts '2018-04-20 14:40:21.650'},N'Save',N'Save Macro performed by user');
GO
SET IDENTITY_INSERT [umbracoLog] OFF;
GO
SET IDENTITY_INSERT [umbracoLock] ON;
GO
INSERT INTO [umbracoLock] ([id],[value],[name]) VALUES (
-331,-1,N'Servers');
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
SET IDENTITY_INSERT [umbracoCacheInstruction] OFF;
GO
SET IDENTITY_INSERT [umbracoAudit] OFF;
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
SET IDENTITY_INSERT [cmsPropertyType] OFF;
GO
SET IDENTITY_INSERT [cmsPropertyData] OFF;
GO
SET IDENTITY_INSERT [cmsMemberType] OFF;
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
1,'2d5fdda2-e19f-4103-b43e-269186fda969',N'Umbraco.TrueFalse',1,2,N'ExcludeScripts',N'Exclude Scripts');
GO
SET IDENTITY_INSERT [cmsMacroProperty] OFF;
GO
SET IDENTITY_INSERT [cmsLanguageText] OFF;
GO
SET IDENTITY_INSERT [cmsDictionary] OFF;
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
SET IDENTITY_INSERT [cmsContentVersion] OFF;
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
SET IDENTITY_INSERT [cmsContentType] OFF;
GO
SET IDENTITY_INSERT [cmsContent] OFF;
GO

UPDATE airFlowDbVersions SET [version] = 3;