--------------------------------------------------------
--  DDL for Table CLIENTE_OS_ARQUIVO
--------------------------------------------------------

  CREATE TABLE "WS4TI"."CLIENTE_OS_ARQUIVO" 
   (	"ID_CLIENTE" NUMBER, 
	"ID_OS" NUMBER, 
	"ID_ARQUIVO" NUMBER, 
	"NOME_ARQUIVO" VARCHAR2(40 BYTE), 
	"DESCRICAO_ARQUIVO" VARCHAR2(200 BYTE), 
	"MIME_TYPE_ARQUIVO" VARCHAR2(40 BYTE), 
	"CONTEUDO_ARQUIVO" BLOB, 
	"CHARSET_ARQUIVO" VARCHAR2(40 BYTE), 
	"UPDATE_DATE" DATE, 
	"CD_USUARIO" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" 
 LOB ("CONTEUDO_ARQUIVO") STORE AS SECUREFILE (
  TABLESPACE "APEX_273992410125036321" ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES 
  STORAGE(INITIAL 106496 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)) ;

   COMMENT ON COLUMN "WS4TI"."CLIENTE_OS_ARQUIVO"."CD_USUARIO" IS 'e-mail ou usu�rio';
