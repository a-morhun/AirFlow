CREATE TABLE [dbo].[cmsPreviewXml] (
    [nodeId]    INT              NOT NULL,
    [versionId] UNIQUEIDENTIFIER NOT NULL,
    [timestamp] DATETIME         NOT NULL,
    [xml]       NTEXT            NOT NULL,
    CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED ([nodeId] ASC, [versionId] ASC),
    CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [dbo].[cmsContent] ([nodeId]),
    CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY ([versionId]) REFERENCES [dbo].[cmsContentVersion] ([VersionId])
);

