CREATE TABLE [cmsLanguageText] (
  [pk] int IDENTITY (1,1)  NOT NULL
, [languageId] int  NOT NULL
, [UniqueId] uniqueidentifier NOT NULL
, [value] nvarchar(1000)  NOT NULL
);
GO
ALTER TABLE [cmsLanguageText] ADD CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY ([languageId]) REFERENCES [umbracoLanguage]([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO
ALTER TABLE [cmsLanguageText] ADD CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY ([pk]);