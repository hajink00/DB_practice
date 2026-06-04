CREATE TABLE `memberTBL` (
	`memberID`	varchar(256)	NOT NULL,
	`memberName`	varchar(500)	NULL,
	`memberAddress`	varchar(500)	NULL
);

CREATE TABLE `productTBL` (
	`productName`	varchar(500)	NOT NULL,
	`cost`	int	NULL,
	`makeDate`	varchar(500)	NULL,
	`company`	varchar(500)	NULL,
	`amount`	int	NULL
);

ALTER TABLE `memberTBL` ADD CONSTRAINT `PK_MEMBERTBL` PRIMARY KEY (
	`memberID`
);

ALTER TABLE `productTBL` ADD CONSTRAINT `PK_PRODUCTTBL` PRIMARY KEY (
	`productName`
);