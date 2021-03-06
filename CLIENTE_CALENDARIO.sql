--------------------------------------------------------
--  DDL for Table CLIENTE_CALENDARIO
--------------------------------------------------------

  CREATE TABLE "WS4TI"."CLIENTE_CALENDARIO" 
   (	"ID_CLIENTE" NUMBER, 
	"DT_CALENDARIO" DATE, 
	"ID_MAQUINA_GRUPO" NUMBER, 
	"ID_TURNO" NUMBER, 
	"DS_OBS" VARCHAR2(400 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" ;
