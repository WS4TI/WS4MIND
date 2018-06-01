--------------------------------------------------------
--  Constraints for Table CLIENTE_MAQUINA_CKLIST_ITEM
--------------------------------------------------------

  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("QT_TEMPO_PREVISTO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("ID_CLIENTE" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("CD_MAQUINA" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("SQ_CHECKITEM" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("DT_CKECKITEM" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("TP_RECORRENCIA" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("ST_CHECKITEM" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("CD_TIPO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("FL_PARADO" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" MODIFY ("FL_PROGRAMAR" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA_CKLIST_ITEM" ADD CONSTRAINT "PK_CLIENTE_MAQ_CKLIST_ITEM" PRIMARY KEY ("ID_CLIENTE", "CD_MAQUINA", "SQ_CHECKITEM")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321"  ENABLE;