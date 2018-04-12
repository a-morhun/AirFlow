CREATE TABLE [dbo].[UFRecordDataInteger] (
    [Id]    INT              IDENTITY (1, 1) NOT NULL,
    [Key]   UNIQUEIDENTIFIER NOT NULL,
    [Value] INT              NULL,
    CONSTRAINT [PK_UFRecordDataInteger] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UFRecordDataInteger_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [dbo].[UFRecordFields] ([Key])
);


GO
CREATE NONCLUSTERED INDEX [IX_datainteger_recordfield]
    ON [dbo].[UFRecordDataInteger]([Key] ASC);

