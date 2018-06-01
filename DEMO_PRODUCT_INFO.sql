--------------------------------------------------------
--  DDL for Table DEMO_PRODUCT_INFO
--------------------------------------------------------

  CREATE TABLE "WS4TI"."DEMO_PRODUCT_INFO" 
   (	"PRODUCT_ID" NUMBER, 
	"PRODUCT_NAME" VARCHAR2(50 BYTE), 
	"PRODUCT_DESCRIPTION" VARCHAR2(2000 BYTE), 
	"CATEGORY" VARCHAR2(30 BYTE), 
	"PRODUCT_AVAIL" VARCHAR2(1 BYTE), 
	"LIST_PRICE" NUMBER(8,2), 
	"PRODUCT_IMAGE" BLOB, 
	"MIMETYPE" VARCHAR2(255 BYTE), 
	"FILENAME" VARCHAR2(400 BYTE), 
	"IMAGE_LAST_UPDATE" TIMESTAMP (6) WITH LOCAL TIME ZONE, 
	"TAGS" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" 
 LOB ("PRODUCT_IMAGE") STORE AS SECUREFILE (
  TABLESPACE "APEX_273992410125036321" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;
