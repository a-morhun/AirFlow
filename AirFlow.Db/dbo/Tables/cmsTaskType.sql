CREATE TABLE [cmsTaskType] (
  [id] int IDENTITY (2,1)  NOT NULL
, [alias] nvarchar(255)  NOT NULL
);
GO
ALTER TABLE [cmsTaskType] ADD CONSTRAINT [PK_cmsTaskType] PRIMARY KEY ([id]);
GO
CREATE INDEX [IX_cmsTaskType_alias] ON [cmsTaskType] ([alias] ASC);