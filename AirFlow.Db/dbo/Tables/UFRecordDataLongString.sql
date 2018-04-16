CREATE TABLE [dbo].[UFRecordDataLongString] (
    [Id]    INT              IDENTITY (1, 1) NOT NULL,
    [Key]   UNIQUEIDENTIFIER NOT NULL,
    [Value] NTEXT            NULL,
    CONSTRAINT [PK_UFRecordDataLongString] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UFRecordDataLongString_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [dbo].[UFRecordFields] ([Key])
);


GO
CREATE NONCLUSTERED INDEX [IX_datalongstring_recordfield]
    ON [dbo].[UFRecordDataLongString]([Key] ASC);

