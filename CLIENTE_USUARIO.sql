--------------------------------------------------------
--  DDL for Table CLIENTE_USUARIO
--------------------------------------------------------

  CREATE TABLE "WS4TI"."CLIENTE_USUARIO" 
   (	"ID_CLIENTE" NUMBER, 
	"CD_USUARIO" VARCHAR2(20 BYTE), 
	"NM_USUARIO" VARCHAR2(100 BYTE), 
	"DS_SENHA" VARCHAR2(12 BYTE), 
	"DS_EMAIL" VARCHAR2(50 BYTE), 
	"TP_USUARIO" CHAR(1 BYTE) DEFAULT 'U', 
	"ID_TURNO" NUMBER, 
	"ID_GRUPO" NUMBER, 
	"DT_CADASTRO" DATE DEFAULT sysdate, 
	"ST_USUARIO" CHAR(1 BYTE) DEFAULT 'A'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" ;

   COMMENT ON COLUMN "WS4TI"."CLIENTE_USUARIO"."TP_USUARIO" IS 'Administrador, Tecnico ou Usuario';
   COMMENT ON COLUMN "WS4TI"."CLIENTE_USUARIO"."ID_TURNO" IS 'Turno de trabalho';
   COMMENT ON COLUMN "WS4TI"."CLIENTE_USUARIO"."ST_USUARIO" IS 'Ativo ou Inativo';
