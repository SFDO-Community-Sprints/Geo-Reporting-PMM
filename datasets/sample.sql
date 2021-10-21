BEGIN TRANSACTION;
CREATE TABLE "Geographic_Definition__c" (
	id INTEGER NOT NULL, 
	"Geographic_ID__c" VARCHAR(255), 
	"Land_Area__c" VARCHAR(255), 
	"Latitude_Northern_Most__c" VARCHAR(255), 
	"Latitude_Southern_Most__c" VARCHAR(255), 
	"Longitude_Eastern_Most__c" VARCHAR(255), 
	"Longitude_Western_Most__c" VARCHAR(255), 
	"Lookup_Name__c" VARCHAR(255), 
	"Name" VARCHAR(255), 
	"Polygon__c" VARCHAR(255), 
	"Secondary_Name__c" VARCHAR(255), 
	"Type__c" VARCHAR(255), 
	"Water_Area__c" VARCHAR(255), 
	"Parent_Geography_Definition__c" VARCHAR(255), 
	PRIMARY KEY (id)
);
INSERT INTO "Geographic_Definition__c" VALUES(1,'','','','','','','98101','98101 ( King County )','','','ZIP Code Tabulation Area (ZCTA)','','5');
INSERT INTO "Geographic_Definition__c" VALUES(2,'','','','','','','98102','98102 ( King County )','','','ZIP Code Tabulation Area (ZCTA)','','5');
INSERT INTO "Geographic_Definition__c" VALUES(3,'','','','','','','Washington','Washington','','','State/Province','','');
INSERT INTO "Geographic_Definition__c" VALUES(4,'','','','','','','98208','98208 ( Snohomish County )','','','ZIP Code Tabulation Area (ZCTA)','','7');
INSERT INTO "Geographic_Definition__c" VALUES(5,'','','','','','','King County','King County ( Washington )','','','County','','3');
INSERT INTO "Geographic_Definition__c" VALUES(6,'','','','','','','98201','98201 ( Snohomish County )','','','ZIP Code Tabulation Area (ZCTA)','','7');
INSERT INTO "Geographic_Definition__c" VALUES(7,'','','','','','','Snohomish County','Snohomish County ( Washington )','','','County','','3');
COMMIT;
