CREATE TABLE [dbo].[UFRecordDataDateTime] (
    [Id]    INT              IDENTITY (1, 1) NOT NULL,
    [Key]   UNIQUEIDENTIFIER NOT NULL,
    [Value] DATETIME         NULL,
    CONSTRAINT [PK_UFRecordDataDateTime] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UFRecordDataDateTime_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [dbo].[UFRecordFields] ([Key])
);


GO
CREATE NONCLUSTERED INDEX [IX_datadatetime_recordfield]
    ON [dbo].[UFRecordDataDateTime]([Key] ASC);

