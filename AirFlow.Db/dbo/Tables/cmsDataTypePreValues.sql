CREATE TABLE [cmsDataTypePreValues] (
  [id] int IDENTITY (10,1)  NOT NULL
, [datatypeNodeId] int  NOT NULL
, [value] ntext NULL
, [sortorder] int  NOT NULL
, [alias] nvarchar(50)  NULL
);
GO
ALTER TABLE [cmsDataTypePreValues] ADD CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY ([id]);