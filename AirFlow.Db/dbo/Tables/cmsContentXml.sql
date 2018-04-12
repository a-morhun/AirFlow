CREATE TABLE [dbo].[cmsContentXml] (
    [nodeId] INT   NOT NULL,
    [xml]    NTEXT NOT NULL,
    CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED ([nodeId] ASC),
    CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [dbo].[cmsContent] ([nodeId])
);

