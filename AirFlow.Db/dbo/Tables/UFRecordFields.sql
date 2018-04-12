CREATE TABLE [dbo].[UFRecordFields] (
    [Key]      UNIQUEIDENTIFIER NOT NULL,
    [FieldId]  UNIQUEIDENTIFIER NOT NULL,
    [Record]   INT              NOT NULL,
    [Alias]    NVARCHAR (255)   NOT NULL,
    [DataType] NVARCHAR (255)   NOT NULL,
    CONSTRAINT [PK_UFRecordFields] PRIMARY KEY CLUSTERED ([Key] ASC)
);

