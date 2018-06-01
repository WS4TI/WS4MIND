--------------------------------------------------------
--  Constraints for Table CLIENTE_MAQUINA_CKLIST
--------------------------------------------------------

  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST" MODIFY ("CD_MAQUINA" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST" MODIFY ("DT_CHECKLIST" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST" MODIFY ("ST_CHECKLIST" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST" ADD CONSTRAINT "PK_CLIENTE_MAQUINA_CKLIST" PRIMARY KEY ("ID_CLIENTE", "CD_MAQUINA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321"  ENABLE;
