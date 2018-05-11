CREATE TABLE [umbracoDomains] (
  [id] int IDENTITY (1,1)  NOT NULL
, [domainDefaultLanguage] int  NULL
, [domainRootStructureID] int  NULL
, [domainName] nvarchar(255)  NOT NULL
);
GO
ALTER TABLE [umbracoDomains] ADD CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY ([domainRootStructureID]) REFERENCES [umbracoNode]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [umbracoDomains] ADD CONSTRAINT [PK_umbracoDomains] PRIMARY KEY ([id]);