CREATE TABLE [dbo].[airFlowMemberSecurity] (
    [nodeId]                        INT           NOT NULL,
    [email_confirmed]               BIT           NOT NULL,
    [confirmation_token]            VARCHAR (64)  NOT NULL,
    [confirmation_token_expiration] DATETIME2 (7) NOT NULL,
    [login_type]                    TINYINT       NOT NULL,
    [login_token]                   VARCHAR (64)  NULL,
    [login_token_expiration]        DATETIME2 (7) NULL,
    CONSTRAINT [FK_cmsMemberSecurity_cmsMember_nodeId] FOREIGN KEY ([nodeId]) REFERENCES [dbo].[cmsMember] ([nodeId]) ON DELETE CASCADE,
    CONSTRAINT [UN_cmsMemberSecurity_confirmation_token] UNIQUE NONCLUSTERED ([confirmation_token] ASC)
);

