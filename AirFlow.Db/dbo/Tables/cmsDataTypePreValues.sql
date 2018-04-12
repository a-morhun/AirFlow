CREATE TABLE [dbo].[cmsDataTypePreValues] (
    [id]             INT           IDENTITY (1, 1) NOT NULL,
    [datatypeNodeId] INT           NOT NULL,
    [value]          NTEXT         NULL,
    [sortorder]      INT           NOT NULL,
    [alias]          NVARCHAR (50) NULL,
    CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY ([datatypeNodeId]) REFERENCES [dbo].[cmsDataType] ([nodeId])
);

