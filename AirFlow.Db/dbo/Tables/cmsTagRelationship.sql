CREATE TABLE [cmsTagRelationship] (
  [nodeId] int  NOT NULL
, [tagId] int  NOT NULL
, [propertyTypeId] int  NOT NULL
);
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY ([propertyTypeId]) REFERENCES [cmsPropertyType]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY ([tagId]) REFERENCES [cmsTags]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTagRelationship] ADD CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY ([nodeId],[propertyTypeId],[tagId]);