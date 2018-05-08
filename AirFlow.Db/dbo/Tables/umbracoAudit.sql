CREATE TABLE [umbracoAudit] (
  [id] int IDENTITY (1,1)  NOT NULL
, [performingUserId] int  NOT NULL
, [performingDetails] nvarchar(1024)  NULL
, [performingIp] nvarchar(64)  NULL
, [eventDateUtc] datetime DEFAULT (GETDATE()) NOT NULL
, [affectedUserId] int  NOT NULL
, [affectedDetails] nvarchar(1024)  NULL
, [eventType] nvarchar(256)  NOT NULL
, [eventDetails] nvarchar(1024)  NULL
);
GO
ALTER TABLE [umbracoAudit] ADD CONSTRAINT [PK_umbracoAudit] PRIMARY KEY ([id]);