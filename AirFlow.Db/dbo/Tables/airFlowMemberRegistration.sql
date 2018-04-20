CREATE TABLE airFlowMemberRegistration
(
	nodeId INT NOT NULL,
	email_confirmed BIT NOT NULL,
	confirmation_token VARCHAR(64) NOT NULL,
	confirmation_token_expiration DATETIME2 NOT NULL,
	confirmation_date DATETIME2,
	[login_type] TINYINT NOT NULL

	CONSTRAINT FK_cmsMemberSecurity_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE,
	CONSTRAINT UN_cmsMemberSecurity_confirmation_token UNIQUE(confirmation_token)
);
GO

CREATE NONCLUSTERED INDEX IX_airFlowMemberRegistration_token ON airFlowMemberRegistration(confirmation_token);