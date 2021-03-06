--------------------------------------------------------
--  Ref Constraints for Table CLIENTE_MAQUINA
--------------------------------------------------------

  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA" ADD CONSTRAINT "FK_CLIENTE_MAQ_CLIENTE" FOREIGN KEY ("ID_CLIENTE")
	  REFERENCES "WS4TI"."CLIENTE" ("ID_CLIENTE") ENABLE;
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA" ADD CONSTRAINT "FK_CLIENTE_MAQ_FABRICANTE" FOREIGN KEY ("ID_CLIENTE", "ID_FABRICANTE")
	  REFERENCES "WS4TI"."CLIENTE_FABRICANTE" ("ID_CLIENTE", "ID_FABRICANTE") ENABLE;
  ALTER TABLE "WS4TI"."CLIENTE_MAQUINA" ADD CONSTRAINT "FK_CLIENTE_MAQ_GRUPO" FOREIGN KEY ("ID_CLIENTE", "ID_MAQUINA_GRUPO")
	  REFERENCES "WS4TI"."CLIENTE_MAQUINA_GRUPO" ("ID_CLIENTE", "ID_MAQUINA_GRUPO") ENABLE;
