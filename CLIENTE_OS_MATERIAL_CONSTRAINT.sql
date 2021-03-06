--------------------------------------------------------
--  Constraints for Table CLIENTE_OS_MATERIAL
--------------------------------------------------------

  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("ID_OS" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("SQ_ITEM" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("DS_PRODUTO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("VL_UNITARIO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" MODIFY ("QT_PRODUTO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_OS_MATERIAL" ADD CONSTRAINT "PK_CLIENTE_OS_MATERIAL" PRIMARY KEY ("ID_OS", "SQ_ITEM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321"  ENABLE;
