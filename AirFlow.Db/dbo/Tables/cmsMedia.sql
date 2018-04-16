CREATE TABLE [dbo].[cmsMedia] (
    [nodeId]    INT              NOT NULL,
    [versionId] UNIQUEIDENTIFIER NOT NULL,
    [mediaPath] NVARCHAR (255)   NULL,
    CONSTRAINT [PK_cmsMedia] PRIMARY KEY CLUSTERED ([versionId] ASC),
    CONSTRAINT [FK_cmsMedia_cmsContent_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [dbo].[cmsContent] ([nodeId]),
    CONSTRAINT [FK_cmsMedia_umbracoNode_id] FOREIGN KEY ([nodeId]) REFERENCES [dbo].[umbracoNode] ([id])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMedia]
    ON [dbo].[cmsMedia]([nodeId] ASC, [versionId] ASC, [mediaPath] ASC);

