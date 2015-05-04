-- -----------------------------------
-- Athena Database script
-- Important: Execute this script after creating the SpagoBI Tables
-- ------------------------------------


-- tables for different athena product types
CREATE TABLE `SBI_PRODUCT_TYPE` (
	`PRODUCT_TYPE_ID` INT(11) NOT NULL,
	`LABEL` VARCHAR(40) NOT NULL,
	`USER_IN` VARCHAR(100) NOT NULL,
	`USER_UP` VARCHAR(100) NULL DEFAULT NULL,
	`USER_DE` VARCHAR(100) NULL DEFAULT NULL,
	`TIME_IN` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`TIME_UP` TIMESTAMP NULL DEFAULT NULL,
	`TIME_DE` TIMESTAMP NULL DEFAULT NULL,
	`SBI_VERSION_IN` VARCHAR(10) NULL DEFAULT NULL,
	`SBI_VERSION_UP` VARCHAR(10) NULL DEFAULT NULL,
	`SBI_VERSION_DE` VARCHAR(10) NULL DEFAULT NULL,
	`META_VERSION` VARCHAR(100) NULL DEFAULT NULL,
	`ORGANIZATION` VARCHAR(20) NULL DEFAULT NULL,
	PRIMARY KEY (`PRODUCT_TYPE_ID`),
	UNIQUE INDEX `XAK1SBI_PRODUCT_TYPE` (`LABEL`, `ORGANIZATION`)
)
COLLATE='LATIN1_SWEDISH_CI'
ENGINE=INNODB
;

-- mapping table between organizations (tenants) and product types
CREATE TABLE `SBI_ORGANIZATION_PRODUCT_TYPE` (
	`PRODUCT_TYPE_ID` INT(11) NOT NULL,
	`ORGANIZATION_ID` INT(11) NOT NULL,
	`USER_IN` VARCHAR(100) NOT NULL,
	`USER_UP` VARCHAR(100) NULL DEFAULT NULL,
	`USER_DE` VARCHAR(100) NULL DEFAULT NULL,
	`TIME_IN` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`TIME_UP` TIMESTAMP NULL DEFAULT NULL,
	`TIME_DE` TIMESTAMP NULL DEFAULT NULL,
	`SBI_VERSION_IN` VARCHAR(10) NULL DEFAULT NULL,
	`SBI_VERSION_UP` VARCHAR(10) NULL DEFAULT NULL,
	`SBI_VERSION_DE` VARCHAR(10) NULL DEFAULT NULL,
	`META_VERSION` VARCHAR(100) NULL DEFAULT NULL,
	`ORGANIZATION` VARCHAR(20) NULL DEFAULT NULL,
	PRIMARY KEY (`PRODUCT_TYPE_ID`, `ORGANIZATION_ID`),
	INDEX `FK_ORGANIZATION_3` (`ORGANIZATION_ID`),
	CONSTRAINT `FK_PRODUCT_TYPE_1` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `SBI_PRODUCT_TYPE` (`PRODUCT_TYPE_ID`) ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT `FK_ORGANIZATION_3` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `SBI_ORGANIZATIONS` (`ID`) ON UPDATE NO ACTION ON DELETE NO ACTION
)
COLLATE='LATIN1_SWEDISH_CI'
ENGINE=INNODB
; 

-- modify sbi_user_func with product_id fk 
ALTER TABLE `SBI_USER_FUNC`
	ADD COLUMN `PRODUCT_TYPE_ID` INT(11) NOT NULL AFTER `DESCRIPTION`,
	ADD CONSTRAINT `FK_PRODUCT_TYPE` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `SBI_PRODUCT_TYPE` (`PRODUCT_TYPE_ID`);
	
-- modify sbi_authorization with product_id fk
ALTER TABLE `SBI_AUTHORIZATIONS`
	ADD COLUMN `PRODUCT_TYPE_ID` INT(11) NOT NULL AFTER `NAME`,
	ADD CONSTRAINT `FK2_PRODUCT_TYPE` FOREIGN KEY (`PRODUCT_TYPE_ID`) REFERENCES `SBI_PRODUCT_TYPE` (`PRODUCT_TYPE_ID`);


