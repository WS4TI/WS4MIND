--------------------------------------------------------
--  DDL for Index PK_CLIENTE_TIPO_MANUT
--------------------------------------------------------

  CREATE UNIQUE INDEX "WS4TI"."PK_CLIENTE_TIPO_MANUT" ON "WS4TI"."CLIENTE_TIPO_MANUTENCAO" ("ID_CLIENTE", "CD_TIPO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" ;