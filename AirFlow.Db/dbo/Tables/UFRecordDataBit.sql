CREATE TABLE [dbo].[UFRecordDataBit] (
    [Id]    INT              IDENTITY (1, 1) NOT NULL,
    [Key]   UNIQUEIDENTIFIER NOT NULL,
    [Value] BIT              NULL,
    CONSTRAINT [PK_UFRecordDataBit] PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_UFRecordDataBit_UFRecordFields_Key] FOREIGN KEY ([Key]) REFERENCES [dbo].[UFRecordFields] ([Key])
);


GO
CREATE NONCLUSTERED INDEX [IX_databit_recordfield]
    ON [dbo].[UFRecordDataBit]([Key] ASC);

