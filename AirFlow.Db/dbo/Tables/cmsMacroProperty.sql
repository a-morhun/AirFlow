CREATE TABLE [cmsMacroProperty] (
  [id] int IDENTITY (4,1)  NOT NULL
, [uniquePropertyId] uniqueidentifier NOT NULL
, [editorAlias] nvarchar(255)  NOT NULL
, [macro] int  NOT NULL
, [macroPropertySortOrder] int DEFAULT ('0')  NOT NULL
, [macroPropertyAlias] nvarchar(50)  NOT NULL
, [macroPropertyName] nvarchar(255)  NOT NULL
);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY ([macro]) REFERENCES [cmsMacro]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [IX_cmsMacroProperty_Alias] UNIQUE ([macro],[macroPropertyAlias]);
GO
ALTER TABLE [cmsMacroProperty] ADD CONSTRAINT [IX_cmsMacroProperty_UniquePropertyId] UNIQUE ([uniquePropertyId]);