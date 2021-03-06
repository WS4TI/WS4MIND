--------------------------------------------------------
--  Constraints for Table APEX$_ACL
--------------------------------------------------------

  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("ID" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("WS_APP_ID" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("USERNAME" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("PRIV" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("CREATED_ON" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" MODIFY ("CREATED_BY" NOT NULL ENABLE);
  ALTER TABLE "WS4TI"."APEX$_ACL" ADD CONSTRAINT "APEX$_ACL_PRIV_CK" CHECK (priv in ('R','C','A')) ENABLE;
  ALTER TABLE "WS4TI"."APEX$_ACL" ADD CONSTRAINT "APEX$_ACL_PK" PRIMARY KEY ("ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "APEX_273992410125036321"  ENABLE;
