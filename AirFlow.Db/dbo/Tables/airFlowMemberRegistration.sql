CREATE TABLE airFlowMemberRegistration
(
	nodeId INT NOT NULL,
	email_confirmed BIT NOT NULL,
	confirmation_token NVARCHAR(64) NOT NULL,
	confirmation_token_expiration DATETIME NOT NULL,
	confirmation_date DATETIME,
	[login_type] TINYINT NOT NULL
);
GO
ALTER TABLE airFlowMemberRegistration ADD CONSTRAINT FK_cmsMemberSecurity_cmsMember_nodeId FOREIGN KEY (nodeId) REFERENCES cmsMember(nodeId) ON DELETE CASCADE ON UPDATE NO ACTION;
GO
ALTER TABLE airFlowMemberRegistration ADD CONSTRAINT UN_cmsMemberSecurity_confirmation_token UNIQUE(confirmation_token)
GO
CREATE NONCLUSTERED INDEX IX_airFlowMemberRegistration_token ON airFlowMemberRegistration(confirmation_token);