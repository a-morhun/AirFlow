CREATE TABLE [dbo].[UFRecords] (
    [Id]            INT              IDENTITY (1, 1) NOT NULL,
    [Form]          UNIQUEIDENTIFIER NOT NULL,
    [Created]       DATETIME         NOT NULL,
    [Updated]       DATETIME         NOT NULL,
    [CurrentPage]   UNIQUEIDENTIFIER NULL,
    [UmbracoPageId] INT              NULL,
    [IP]            NVARCHAR (255)   NULL,
    [MemberKey]     NVARCHAR (255)   NULL,
    [UniqueId]      UNIQUEIDENTIFIER NOT NULL,
    [State]         NVARCHAR (50)    NULL,
    [RecordData]    NTEXT            NOT NULL,
    CONSTRAINT [PK_UFRecords] PRIMARY KEY CLUSTERED ([Id] ASC)
);

