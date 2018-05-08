CREATE TABLE [cmsTags] (
  [id] int IDENTITY (1,1)  NOT NULL
, [tag] nvarchar(200)  NULL
, [ParentId] int  NULL
, [group] nvarchar(100)  NULL
);
GO
ALTER TABLE [cmsTags] ADD CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY ([ParentId]) REFERENCES [cmsTags]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsTags] ADD CONSTRAINT [PK_cmsTags] PRIMARY KEY ([id]);
GO
CREATE INDEX [IX_cmsTags] ON [cmsTags] ([tag] ASC,[group] ASC);