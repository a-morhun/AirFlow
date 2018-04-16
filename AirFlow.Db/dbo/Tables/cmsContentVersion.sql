CREATE TABLE [dbo].[cmsContentVersion] (
    [id]          INT              IDENTITY (1, 1) NOT NULL,
    [ContentId]   INT              NOT NULL,
    [VersionId]   UNIQUEIDENTIFIER NOT NULL,
    [VersionDate] DATETIME         CONSTRAINT [DF_cmsContentVersion_VersionDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY ([ContentId]) REFERENCES [dbo].[cmsContent] ([nodeId])
);


GO
CREATE NONCLUSTERED INDEX [IX_cmsContentVersion_ContentId]
    ON [dbo].[cmsContentVersion]([ContentId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentVersion_VersionId]
    ON [dbo].[cmsContentVersion]([VersionId] ASC);

