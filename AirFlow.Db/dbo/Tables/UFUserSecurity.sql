CREATE TABLE [dbo].[UFUserSecurity] (
    [User]                  NVARCHAR (50) NOT NULL,
    [ManageDataSources]     BIT           NOT NULL,
    [ManagePreValueSources] BIT           NOT NULL,
    [ManageWorkflows]       BIT           NOT NULL,
    [ManageForms]           BIT           NOT NULL
);

