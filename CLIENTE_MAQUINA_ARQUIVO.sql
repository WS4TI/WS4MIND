--------------------------------------------------------
--  DDL for Table CLIENTE_MAQUINA_ARQUIVO
--------------------------------------------------------

  CREATE TABLE "WS4TI"."CLIENTE_MAQUINA_ARQUIVO" 
   (	"ID_CLIENTE" NUMBER, 
	"CD_MAQUINA" VARCHAR2(15 BYTE), 
	"ID_ARQUIVO" NUMBER, 
	"NOME_ARQUIVO" VARCHAR2(40 BYTE), 
	"DESCRICAO_ARQUIVO" VARCHAR2(200 BYTE), 
	"MIME_TYPE_ARQUIVO" VARCHAR2(40 BYTE), 
	"CONTEUDO_ARQUIVO" BLOB, 
	"CHARSET_ARQUIVO" VARCHAR2(40 BYTE), 
	"UPDATE_DATE" DATE, 
	"CD_USUARIO" VARCHAR2(20 BYTE)
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
