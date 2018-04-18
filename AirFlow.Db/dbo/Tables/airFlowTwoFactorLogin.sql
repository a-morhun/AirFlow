CREATE TABLE airFlowTwoFactorLogin
(
	nodeId INT NOT NULL,
	token VARCHAR(64) NULL,
	token_expiration DATETIME2 NULL

	CONSTRAINT FK_airFlowTwoFactorLogin_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE,
	CONSTRAINT UN_airFlowTwoFactorLogin_token UNIQUE(token)
);
GO

CREATE NONCLUSTERED INDEX IX_airFlowTwoFactorLogin_token ON airFlowTwoFactorLogin(token);