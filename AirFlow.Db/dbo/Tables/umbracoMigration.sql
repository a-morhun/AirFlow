CREATE TABLE [dbo].[umbracoMigration] (
    [id]         INT            IDENTITY (1, 1) NOT NULL,
    [name]       NVARCHAR (255) NOT NULL,
    [createDate] DATETIME       CONSTRAINT [DF_umbracoMigration_createDate] DEFAULT (getdate()) NOT NULL,
    [version]    NVARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_umbracoMigration] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoMigration]
    ON [dbo].[umbracoMigration]([name] ASC, [version] ASC);

