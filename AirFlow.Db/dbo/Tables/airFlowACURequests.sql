--ACU = Air-condition Unit 

CREATE TABLE airFlowACURequests
(
	id INT IDENTITY(1,1),
	acu_id INT NOT NULL,
	requester_email NVARCHAR(1000),
	temperature DECIMAL(5,2) NOT NULL,
	update_datetime DATETIME NOT NULL
);
GO
ALTER TABLE airFlowACURequests ADD CONSTRAINT PK_airFlowACURequests PRIMARY KEY (id);
GO
CREATE INDEX IX_airFlowACURequests_acu_id ON airFlowACURequests(acu_id);