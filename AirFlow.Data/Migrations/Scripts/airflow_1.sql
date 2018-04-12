CREATE TABLE airFlowDbVersions
(
	id INT IDENTITY(1,1),
	[version] INT NOT NULL,
	update_date DATETIME2 NOT NULL CONSTRAINT DF_AirFlowDbVersions_update_date DEFAULT GETUTCDATE(),

	CONSTRAINT PK_AirFlowDbVersions PRIMARY KEY (id),
);
GO

INSERT INTO airFlowDbVersions([version]) VALUES (0);

CREATE TABLE airFlowMemberSecurity
(
	nodeId INT NOT NULL,
	email_confirmed BIT NOT NULL,
	confirmation_token VARCHAR(64) NOT NULL,
	confirmation_token_expiration DATETIME2 NOT NULL,
	login_type TINYINT NOT NULL,
	login_token VARCHAR(64),
	login_token_expiration DATETIME2

	CONSTRAINT FK_cmsMemberSecurity_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE,
	CONSTRAINT UN_cmsMemberSecurity_confirmation_token UNIQUE(confirmation_token)
);
GO

UPDATE airFlowDbVersions SET [version] = 1;