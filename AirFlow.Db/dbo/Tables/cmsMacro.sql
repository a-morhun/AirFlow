CREATE TABLE [cmsMacro] (
  [id] int IDENTITY (2,1)  NOT NULL
, [uniqueId] uniqueidentifier NOT NULL
, [macroUseInEditor] bit DEFAULT ('0') NOT NULL
, [macroRefreshRate] int DEFAULT ('0')  NOT NULL
, [macroAlias] nvarchar(255)  NOT NULL
, [macroName] nvarchar(255)  NULL
, [macroScriptType] nvarchar(255)  NULL
, [macroScriptAssembly] nvarchar(255)  NULL
, [macroXSLT] nvarchar(255)  NULL
, [macroCacheByPage] bit DEFAULT ('1') NOT NULL
, [macroCachePersonalized] bit DEFAULT ('0') NOT NULL
, [macroDontRender] bit DEFAULT ('0') NOT NULL
, [macroPython] nvarchar(255)  NULL
);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [PK_cmsMacro] PRIMARY KEY ([id]);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [IX_cmsMacro_UniqueId] UNIQUE ([uniqueId]);
GO
ALTER TABLE [cmsMacro] ADD CONSTRAINT [IX_cmsMacroPropertyAlias] UNIQUE ([macroAlias]);