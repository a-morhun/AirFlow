CREATE TABLE [umbracoCacheInstruction] (
  [id] int IDENTITY (1,1)  NOT NULL
, [utcStamp] datetime NOT NULL
, [jsonInstruction] ntext NOT NULL
, [originated] nvarchar(500)  NOT NULL
, [instructionCount] int DEFAULT ('1')  NOT NULL
);
GO
ALTER TABLE [umbracoCacheInstruction] ADD CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY ([id]);