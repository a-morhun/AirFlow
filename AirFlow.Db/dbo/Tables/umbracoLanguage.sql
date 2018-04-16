CREATE TABLE [dbo].[umbracoLanguage] (
    [id]                  INT            IDENTITY (1, 1) NOT NULL,
    [languageISOCode]     NVARCHAR (10)  NULL,
    [languageCultureName] NVARCHAR (100) NULL,
    CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoLanguage_languageISOCode]
    ON [dbo].[umbracoLanguage]([languageISOCode] ASC);

