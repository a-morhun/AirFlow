CREATE TABLE [cmsPropertyData] (
  [id] int IDENTITY (1,1)  NOT NULL
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
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY ([propertytypeid]) REFERENCES [cmsPropertyType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY ([contentNodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsPropertyData] ADD CONSTRAINT [IX_cmsPropertyData_1] UNIQUE ([contentNodeId],[versionId],[propertytypeid]);
GO
CREATE INDEX [IX_cmsPropertyData_2] ON [cmsPropertyData] ([versionId] ASC);
GO
CREATE INDEX [IX_cmsPropertyData_3] ON [cmsPropertyData] ([propertytypeid] ASC);