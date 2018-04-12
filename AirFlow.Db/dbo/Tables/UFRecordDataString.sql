CREATE TABLE [dbo].[UFRecordDataString] (
    [Id]    INT              IDENTITY (1, 1) NOT NULL,
    [Key]   UNIQUEIDENTIFIER NOT NULL,
    [Value] NVARCHAR (255)   NOT NULL,
    CONSTRAINT [PK_UFRecordDataString] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UFRecordDataString_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [dbo].[UFRecordFields] ([Key])
);


GO
CREATE NONCLUSTERED INDEX [IX_datastring_recordfield]
    ON [dbo].[UFRecordDataString]([Key] ASC);

