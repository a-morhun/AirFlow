CREATE TABLE airFlowDbVersions
(
	id INT IDENTITY(1,1),
	[version] INT NOT NULL,
	update_date DATETIME2 NOT NULL CONSTRAINT DF_AirFlowDbVersions_update_date DEFAULT GETUTCDATE(),

	CONSTRAINT PK_AirFlowDbVersions PRIMARY KEY (id),
);
GO

INSERT INTO airFlowDbVersions([version]) VALUES (0);
DROP TABLE airFlowMemberRegistration

CREATE TABLE airFlowMemberRegistration
(
	nodeId INT NOT NULL,
	email_confirmed BIT NOT NULL,
	confirmation_token VARCHAR(64) NOT NULL,
	confirmation_token_expiration DATETIME2 NOT NULL,
	confirmation_date DATETIME2

	CONSTRAINT FK_cmsMemberSecurity_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE,
	CONSTRAINT UN_cmsMemberSecurity_confirmation_token UNIQUE(confirmation_token)
);
GO

CREATE TABLE airFlowTwoFactorLogin
(
	nodeId INT NOT NULL,
	login_type TINYINT NOT NULL,
	login_token VARCHAR(64) NOT NULL,
	login_token_expiration DATETIME2 NOT NULL

	CONSTRAINT FK_airFlowTwoFactorLogin_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE,
	CONSTRAINT UN_airFlowTwoFactorLogin_login_token UNIQUE(login_token)
);
GO


UPDATE airFlowDbVersions SET [version] = 1;

SELECT * FROM airFlowMemberSecurity