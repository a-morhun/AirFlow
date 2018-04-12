CREATE TABLE [dbo].[UFUserFormSecurity] (
    [Id]            INT              IDENTITY (1, 1) NOT NULL,
    [User]          NVARCHAR (50)    NOT NULL,
    [Form]          UNIQUEIDENTIFIER NOT NULL,
    [HasAccess]     BIT              NOT NULL,
    [AllowInEditor] BIT              NOT NULL,
    [SecurityType]  INT              NOT NULL,
    CONSTRAINT [Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);

