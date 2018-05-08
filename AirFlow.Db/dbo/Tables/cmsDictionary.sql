CREATE TABLE [cmsDictionary] (
  [pk] int IDENTITY (1,1)  NOT NULL
, [id] uniqueidentifier NOT NULL
, [parent] uniqueidentifier NULL
, [key] nvarchar(450)  NOT NULL
);
GO
ALTER TABLE [cmsDictionary] ADD CONSTRAINT [PK_cmsDictionary] PRIMARY KEY ([pk]);
GO
ALTER TABLE [cmsDictionary] ADD CONSTRAINT [IX_cmsDictionary_id] UNIQUE ([id]);
GO
CREATE INDEX [IX_cmsDictionary_key] ON [cmsDictionary] ([key] ASC);