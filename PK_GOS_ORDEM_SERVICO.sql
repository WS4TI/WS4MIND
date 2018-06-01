--------------------------------------------------------
--  DDL for Index PK_GOS_ORDEM_SERVICO
--------------------------------------------------------

  CREATE UNIQUE INDEX "WS4TI"."PK_GOS_ORDEM_SERVICO" ON "WS4TI"."CLIENTE_OS" ("ID_CLIENTE", "ID_OS") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321" ;