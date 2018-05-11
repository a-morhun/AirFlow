CREATE TABLE [cmsPropertyType] (
  [id] int IDENTITY (50,1)  NOT NULL
, [dataTypeId] int  NOT NULL
, [contentTypeId] int  NOT NULL
, [propertyTypeGroupId] int  NULL
, [Alias] nvarchar(255)  NOT NULL
, [Name] nvarchar(255)  NULL
, [sortOrder] int DEFAULT ('0')  NOT NULL
, [mandatory] bit DEFAULT ('0') NOT NULL
, [validationRegExp] nvarchar(255)  NULL
, [Description] nvarchar(2000)  NULL
, [UniqueID] uniqueidentifier DEFAULT (NEWID()) NOT NULL
);
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY ([propertyTypeGroupId]) REFERENCES [cmsPropertyTypeGroup]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPropertyType] ADD CONSTRAINT [IX_cmsPropertyTypeUniqueID] UNIQUE ([UniqueID]);
GO
CREATE INDEX [IX_cmsPropertyTypeAlias] ON [cmsPropertyType] ([Alias] ASC);