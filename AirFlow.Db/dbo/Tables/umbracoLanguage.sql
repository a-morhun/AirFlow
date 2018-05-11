CREATE TABLE [umbracoLanguage] (
  [id] int IDENTITY (2,1)  NOT NULL
, [languageISOCode] nvarchar(10)  NULL
, [languageCultureName] nvarchar(100)  NULL
);
GO
ALTER TABLE [umbracoLanguage] ADD CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY ([id]);
GO
ALTER TABLE [umbracoLanguage] ADD CONSTRAINT [IX_umbracoLanguage_languageISOCode] UNIQUE ([languageISOCode]);