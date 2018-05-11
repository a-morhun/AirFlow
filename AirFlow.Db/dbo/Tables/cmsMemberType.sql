CREATE TABLE [cmsMemberType] (
  [pk] int IDENTITY (1,1)  NOT NULL
, [NodeId] int  NOT NULL
, [propertytypeId] int  NOT NULL
, [memberCanEdit] bit DEFAULT ('0') NOT NULL
, [viewOnProfile] bit DEFAULT ('0') NOT NULL
, [isSensitive] bit DEFAULT ('0') NOT NULL
);
GO
ALTER TABLE [cmsMemberType] ADD CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY ([NodeId]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMemberType] ADD CONSTRAINT [PK_cmsMemberType] PRIMARY KEY ([pk]);