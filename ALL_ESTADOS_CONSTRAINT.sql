--------------------------------------------------------
--  Constraints for Table ALL_ESTADOS
--------------------------------------------------------

  ALTER TABLE "WS4TI"."ALL_ESTADOS" MODIFY ("CD_UF" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."ALL_ESTADOS" ADD CONSTRAINT "PK_ALL_ESTADO" PRIMARY KEY ("CD_UF")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321"  ENABLE;
