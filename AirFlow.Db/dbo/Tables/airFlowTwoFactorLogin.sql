CREATE TABLE airFlowTwoFactorLogin
(
	nodeId INT NOT NULL,
	token NVARCHAR(64) NULL,
	token_expiration DATETIME NULL 
);
GO
ALTER TABLE airFlowTwoFactorLogin ADD CONSTRAINT FK_airFlowTwoFactorLogin_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE;
GO
ALTER TABLE airFlowTwoFactorLogin ADD CONSTRAINT UN_airFlowTwoFactorLogin_token UNIQUE(token);
GO
CREATE NONCLUSTERED INDEX IX_airFlowTwoFactorLogin_token ON airFlowTwoFactorLogin(token);