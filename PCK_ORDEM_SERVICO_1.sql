--------------------------------------------------------
--  DDL for Package Body PCK_ORDEM_SERVICO
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "WS4TI"."PCK_ORDEM_SERVICO" AS

   ------------------------------------------------------------------------------------------ 
   -- @autor:      jose.costa 
   -- @descri��o:  Abre atendimento para usu�rio do sistema de OS. 
   -- @data:       24/02/2017 
   ------------------------------------------------------------------------------------------ 
   PROCEDURE pr_evento(p_id_cliente IN cliente_os_evento.id_cliente%TYPE
                      ,p_id_os      IN cliente_os_evento.id_os%TYPE
                      ,p_tp_evento  IN cliente_os_evento.tp_evento%TYPE
                      ,p_ds_evento  IN cliente_os_evento.ds_evento%TYPE
                      ,p_dt_abre    IN cliente_os_evento.dt_abre%TYPE
                      ,p_dt_fecha   IN cliente_os_evento.dt_fecha%TYPE
                      ,p_ls_usuario IN cliente_os_evento.ls_usuario%TYPE) IS
      v_sq             cliente_os_evento.sq_evento%TYPE;
      v_fl_cklist_posm cliente_maquina.fl_cklist_posm%TYPE;
      v_count          NUMBER;
   BEGIN
      BEGIN
         SELECT nvl(MAX(x.sq_evento), 0) + 1
           INTO v_sq
           FROM cliente_os_evento x
          WHERE id_cliente = p_id_cliente
            AND id_os = p_id_os;
      EXCEPTION
         WHEN OTHERS THEN
            raise_application_error(-20000, 'Erro selecionando dados da m�quina! | ' || SQLERRM);
      END;
      -- 
      IF p_tp_evento = 'FOS' THEN
         BEGIN
            SELECT m.fl_cklist_posm
              INTO v_fl_cklist_posm
              FROM cliente_maquina m
             WHERE (m.id_cliente, m.cd_maquina) IN (SELECT id_cliente
                                                          ,cd_maquina
                                                      FROM cliente_os
                                                     WHERE id_cliente = p_id_cliente
                                                       AND id_os = p_id_os);
         EXCEPTION
            WHEN OTHERS THEN
               raise_application_error(-20001, 'Erro selecionando dados da m�quina! | ' || SQLERRM);
         END;
         -- 
         IF v_fl_cklist_posm = 'S' THEN
            BEGIN
               SELECT COUNT(1)
                 INTO v_count
                 FROM cliente_os_posm x
                WHERE x.id_cliente = p_id_cliente
                  AND x.id_os = p_id_os
                  AND x.fl_valida_rec = 'S'
                  AND x.fl_valida_ent = 'S';
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error(-20002, 'Erro selecionando dados da m�quina! | ' || SQLERRM);
            END;
            -- valida check list pos manuten��o 
            IF v_count = 0 THEN
               raise_application_error(-20003, 'Preecher Check List P�s Manuten��o antes de Fechar a OS!');
            END IF;
         END IF;
      END IF;
      -- 
      BEGIN
         INSERT INTO cliente_os_evento
            (id_cliente
            ,id_os
            ,sq_evento
            ,dt_abre
            ,dt_fecha
            ,ls_usuario
            ,tp_evento
            ,ds_evento)
         VALUES
            (p_id_cliente
            ,p_id_os
            ,v_sq
            ,p_dt_abre
            ,p_dt_fecha
            ,p_ls_usuario
            ,p_tp_evento
            ,p_ds_evento);
      EXCEPTION
         WHEN dup_val_on_index THEN
            raise_application_error(-20099, 'Erro inserindo atendimento! ' || SQLERRM);
         WHEN OTHERS THEN
            raise_application_error(-20098, 'Erro inserindo atendimento! ' || SQLERRM);
      END;
      -- 
      COMMIT;
   END pr_evento;

   ------------------------------------------------------------------------------------------ 
   -- @autor:      jose.costa 
   -- @descri��o:  Valida no AD usu�rio e senha para entrega 
   -- @data:       06/10/2017 
   ------------------------------------------------------------------------------------------ 
   PROCEDURE pr_valida_entrega(p_id_cliente IN cliente_os_posm.id_cliente%TYPE
                              ,p_id_os      IN cliente_os_posm.id_os%TYPE
                              ,p_id_posm    IN cliente_os_posm.id_posm%TYPE
                              ,p_username   IN VARCHAR2
                              ,p_password   IN VARCHAR2) IS
      -- Boolean parameters are translated from/to integers:  
      -- 0/1/null <--> false/true/null  
      RESULT        BOOLEAN;
      v_usuario_rec cliente_os_posm.cd_usuario_ent%TYPE;
   BEGIN
      BEGIN
         SELECT x.cd_usuario_rec
           INTO v_usuario_rec
           FROM cliente_os_posm x
          WHERE x.id_cliente = p_id_cliente
            AND x.id_os = p_id_os
            AND x.id_posm = p_id_posm;
      EXCEPTION
         WHEN no_data_found THEN
            v_usuario_rec := NULL;
         WHEN OTHERS THEN
            raise_application_error(-20001, 'Erro selecionando dados! | ' || SQLERRM);
      END;
      -- valiando os campos de usu�rio e senha 
      IF p_username IS NULL THEN
         raise_application_error(-20002, 'O nome do usu�rio n�o pode ser nulo!');
      ELSIF p_password IS NULL THEN
         raise_application_error(-20003, 'A senha do usu�rio n�o pode ser nulo!');
      ELSIF upper(p_username) = upper(v_usuario_rec) THEN
         raise_application_error(-20004, 'Usu�rio de recebimento n�o pode ser o mesmo da entrega!');
      ELSE
         -- Call the function 
         --RESULT := apex_040200.ldap_security_apex_spo(p_username, p_password); 
         -- Convert false/true/null to 0/1/null  
         --:result := sys.diutil.bool_to_int(result); 
         IF RESULT THEN
            -- 
            BEGIN
               UPDATE cliente_os_posm x
                  SET x.ds_entrega     = 'Entrega Validada por ''' || p_username || ''' em ' || to_char(SYSDATE, 'dd/mm/rrrr hh24:mi:ss')
                     ,x.fl_valida_ent  = 'S'
                     ,x.cd_usuario_ent = p_username
                WHERE x.id_cliente = p_id_cliente
                  AND x.id_os = p_id_os
                  AND x.id_posm = p_id_posm;
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error(-20005, 'Erro selecionando dados! | ' || SQLERRM);
            END;
            -- 
            COMMIT;
         ELSE
            raise_application_error(-20006, 'Usu�rio ou Senha Inv�lidos!');
         END IF;
      END IF;
   END pr_valida_entrega;

   ------------------------------------------------------------------------------------------ 
   -- @autor:      jose.costa 
   -- @descri��o:  Valida no AD usu�rio e senha para recebimento 
   -- @data:       10/10/2017 
   ------------------------------------------------------------------------------------------ 
   PROCEDURE pr_valida_recebto(p_id_cliente IN cliente_os_posm.id_cliente%TYPE
                              ,p_id_os      IN cliente_os_posm.id_os%TYPE
                              ,p_id_posm    IN cliente_os_posm.id_posm%TYPE
                              ,p_username   IN VARCHAR2
                              ,p_password   IN VARCHAR2) IS
      -- Boolean parameters are translated from/to integers:  
      -- 0/1/null <--> false/true/null  
      RESULT        BOOLEAN;
      v_usuario_ent cliente_os_posm.cd_usuario_ent%TYPE;
   BEGIN
      BEGIN
         SELECT x.cd_usuario_ent
           INTO v_usuario_ent
           FROM cliente_os_posm x
          WHERE x.id_cliente = p_id_cliente
            AND x.id_os = p_id_os
            AND x.id_posm = p_id_posm;
      EXCEPTION
         WHEN no_data_found THEN
            v_usuario_ent := NULL;
         WHEN OTHERS THEN
            raise_application_error(-20001, 'Erro selecionando dados! | ' || SQLERRM);
      END;
      -- valiando os campos de usu�rio e senha 
      IF p_username IS NULL THEN
         raise_application_error(-20002, 'O nome do usu�rio n�o pode ser nulo!');
      ELSIF p_password IS NULL THEN
         raise_application_error(-20003, 'A senha do usu�rio n�o pode ser nulo!');
      ELSIF upper(p_username) = upper(v_usuario_ent) THEN
         raise_application_error(-20004, 'Usu�rio de recebimento n�o pode ser o mesmo da entrega!');
      ELSE
         -- Call the function 
         --RESULT := apex_040200.ldap_security_apex_spo(p_username, p_password); 
         -- Convert false/true/null to 0/1/null  
         --:result := sys.diutil.bool_to_int(result); 
         IF RESULT THEN
            -- 
            BEGIN
               UPDATE cliente_os_posm x
                  SET x.ds_recebe      = 'Recebimento Validada por ''' || p_username || ''' em ' || to_char(SYSDATE, 'dd/mm/rrrr hh24:mi:ss')
                     ,x.fl_valida_rec  = 'S'
                     ,x.cd_usuario_rec = p_username
                WHERE x.id_cliente = p_id_cliente
                  AND x.id_os = p_id_os
                  AND x.id_posm = p_id_posm;
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error(-20001, 'Erro selecionando dados! | ' || SQLERRM);
            END;
            -- 
            COMMIT;
         ELSE
            raise_application_error(-20006, 'Usu�rio ou Senha Inv�lidos!');
         END IF;
      END IF;
   END pr_valida_recebto;

   ------------------------------------------------------------------------------------------ 
   -- @autor:      jose.costa 
   -- @descri��o:  Cria OS's programadas para o dia informado 
   -- @p_date:     Se informada � utilizada para gerar OS's desta data espec�fica 
   -- @data:       10/11/2017 
   ------------------------------------------------------------------------------------------ 
   PROCEDURE pr_programacao(p_id_cliente IN cliente_os.id_cliente%TYPE DEFAULT 1
                           ,p_cd_usuario IN cliente_os.cd_usuario_tmp%TYPE DEFAULT NULL
                           ,p_date       IN DATE DEFAULT NULL) IS
      v_id_os             cliente_os.id_os%TYPE;
      v_problema          VARCHAR2(4000) := NULL;
      v_sysdate           DATE;
      v_qt_tempo_previsto NUMBER;
      v_count             NUMBER;
      v_data              DATE;
      v_sair              BOOLEAN;
   BEGIN
      v_sysdate := SYSDATE;
      -- verifica se � feriado, nos feriados tem de gerar com 'data de abertura' no pr�ximo dia util...
      v_data  := nvl(p_date, v_sysdate);
      v_sair  := TRUE;
      v_count := 0;
      --
      WHILE v_sair
      LOOP
         BEGIN
            SELECT COUNT(1) INTO v_count FROM cliente_calendario x WHERE x.dt_calendario = v_data;
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
         IF v_count = 1 THEN
            v_data := v_data + 1;
         ELSE
            v_sair := FALSE;
         END IF;
      END LOOP;
      -- 
      BEGIN
         DELETE FROM cliente_os_date_tmp;
      EXCEPTION
         WHEN OTHERS THEN
            NULL;
      END;
      IF p_date IS NOT NULL THEN
         BEGIN
            INSERT INTO cliente_os_date_tmp VALUES (v_data);
         EXCEPTION
            WHEN OTHERS THEN
               NULL;
         END;
      END IF;
      -- quebra por m�quina / tempo de recorrencia / tipo da manuten��o / equipamento parado ou n�o 
      FOR maqck_ IN (SELECT x.id_cliente
                           ,x.cd_maquina
                           ,x.tp_recorrencia
                           ,x.cd_tipo
                           ,x.fl_parado
                           ,COUNT(DISTINCT x.sq_checkitem) qtde
                       FROM vw_cliente_programacao_dia x
                      GROUP BY x.id_cliente
                              ,x.cd_maquina
                              ,x.tp_recorrencia
                              ,x.cd_tipo
                              ,x.fl_parado)
      LOOP
         v_problema          := NULL;
         v_qt_tempo_previsto := 0;
         -- 
         BEGIN
            SELECT nvl(MAX(x.id_os), 0) + 1 INTO v_id_os FROM cliente_os x WHERE x.id_cliente = nvl(p_id_cliente, 1);
         EXCEPTION
            WHEN no_data_found THEN
               v_id_os := 1;
            WHEN OTHERS THEN
               raise_application_error(-20000, 'Erro selecionando pr�ximo ID da OS! | ' || SQLERRM);
         END;
         -- 
         FOR maqckitem_ IN (SELECT *
                              FROM vw_cliente_programacao_dia a
                             WHERE a.id_cliente = p_id_cliente
                               AND a.cd_maquina = maqck_.cd_maquina
                               AND a.tp_recorrencia = maqck_.tp_recorrencia
                               AND a.cd_tipo = maqck_.cd_tipo
                               AND a.fl_parado = maqck_.fl_parado)
         LOOP
            IF v_problema IS NULL THEN
               v_problema := substr(maqckitem_.id_ckos || '.' || maqckitem_.nr_ordem || ' | ' || maqckitem_.ds_inspecao, 0, 3990);
            ELSE
               v_problema := substr(v_problema || chr(10) || maqckitem_.id_ckos || '.' || maqckitem_.nr_ordem || ' | ' || maqckitem_.ds_inspecao, 0, 3990);
            END IF;
            -- Qtde total de tempo previsto
            v_qt_tempo_previsto := v_qt_tempo_previsto + nvl(maqckitem_.qt_tempo_previsto, 0);
            -- Gravar LOG da Opera��o
            BEGIN
               INSERT INTO cliente_maquina_cklist_item_os
                  (id_cliente
                  ,cd_maquina
                  ,sq_checkitem
                  ,id_os
                  ,dt_programada
                  ,ds_obs
                  ,dt_log
                  ,cd_usuario_log
                  ,qt_tempo_previsto)
               VALUES
                  (p_id_cliente
                  ,maqck_.cd_maquina
                  ,maqckitem_.sq_checkitem
                  ,v_id_os
                  ,v_data
                  ,'Id. ' || maqckitem_.id_ckos || ' Ord. ' || maqckitem_.nr_ordem || ' Desc. ' || maqckitem_.ds_inspecao
                  ,v_sysdate
                  ,p_cd_usuario
                  ,maqckitem_.qt_tempo_previsto);
            EXCEPTION
               WHEN OTHERS THEN
                  BEGIN
                     PR_SEND_MAIL( P_TITULO => 'Erro LOG de OS. programada !',
                                   P_MENSAGEM => 'C�digo do Erro: ' || SQLCODE || ' | Favor verificar!',
                                   P_DE => 'contato.ws4ti@gmail.com',
                                   P_PARA => 'costafortes@gmail.com'
                                 );
                  EXCEPTION
                     WHEN OTHERS THEN
                        NULL;
                  END;
            END;
         END LOOP;
         -- 
         IF v_problema IS NOT NULL THEN
            -- 
            v_problema := substr(v_problema, 0, 3990) || '...';
            -- 
            IF v_id_os IS NOT NULL THEN
               -- 
               BEGIN
                  INSERT INTO cliente_os
                     (id_cliente
                     ,id_os
                     ,dt_os
                     ,cd_maquina
                     ,fl_parado
                     ,cd_tipo
                     ,ds_problema
                     ,st_os
                     ,fl_baixa_produto
                     ,cd_usuario_tmp
                     ,id_class
                     ,fl_prioridade
                     ,fl_avaliacao
                     ,ds_avaliacao
                     ,ds_email_opc
                     ,id_grupo
                     ,qt_tempo_previsto)
                  VALUES
                     (p_id_cliente
                     ,v_id_os
                     ,v_data
                     ,maqck_.cd_maquina
                     ,maqck_.fl_parado
                     ,maqck_.cd_tipo
                     ,v_problema
                     ,'PEN'
                     ,NULL
                     ,nvl(p_cd_usuario, 'SISTEMA')
                     ,NULL
                     ,'N' --Prioridade Alta, Baixa e Normal 
                     ,'P' --Positiva ou Negativa 
                     ,NULL --Avalia��o do atendimento 
                     ,'costafortes@gmail.com'
                     ,12 /*Manuten��o Industrial*/
                     ,v_qt_tempo_previsto);
               EXCEPTION
                  WHEN OTHERS THEN
                     BEGIN
                        -- deletar os criadas 
                        DELETE FROM cliente_os
                         WHERE id_cliente = p_id_cliente
                           AND id_os = v_id_os;
                        -- deletar programa��es criadas 
                        DELETE FROM cliente_maquina_cklist_item_os
                         WHERE id_cliente = p_id_cliente
                           AND id_os = v_id_os;
                        --      
                        PR_SEND_MAIL( P_TITULO => 'Erro na cria��o automatica de OS. programada !',
                                      P_MENSAGEM => 'C�digo do Erro: ' || SQLCODE || ' | Favor verificar!',
                                      P_DE => 'contato.ws4ti@gmail.com',
                                      P_PARA => 'costafortes@gmail.com'
                                    );                        
                     EXCEPTION
                        WHEN OTHERS THEN
                           NULL;
                     END;
               END;
            END IF;
            -- 
         END IF;
      END LOOP;
      -- 
      COMMIT;
      -- 
   END pr_programacao;

   ------------------------------------------------------------------------------------------ 
   -- @autor:      jose.costa 
   -- @descri��o:  Utilizada em JOB para relatar OS's finalizadas que n�o foram fechadas ainda 
   --             por e-mail e fecha as OS automaticamente a partir de 72 hs; 
   -- @data:       01/03/2018 
   ------------------------------------------------------------------------------------------ 
   PROCEDURE pr_email_fechar_os IS
   BEGIN
      /* Selecionar os's com fechamento pendente para os setores */
      FOR reg IN (SELECT DISTINCT a.id_cliente
                                 ,a.id_os AS os
                                 ,g.nm_grupo AS setor
                                 ,e.dt_abre AS finalizada
                                 ,fu_showdate(fu_datediff('SS', e.dt_abre, SYSDATE)) esperando
                                 ,round(fu_datediff('HH', e.dt_abre, SYSDATE)) esperando_hh
                                 ,m.ds_maquina AS maquina
                                 ,initcap(a.ds_problema) servico
                                 ,a.ds_email_opc email
                    FROM cliente_os a
                        ,cliente_grupo g
                        ,cliente_maquina m
                        ,(SELECT * FROM cliente_os_evento WHERE tp_evento = 'FIA') e
                   WHERE a.id_cliente = e.id_cliente
                     AND a.id_os = e.id_os
                     AND a.st_os = 'ATE'
                     AND a.id_cliente = g.id_cliente
                     AND a.id_grupo = g.id_grupo
                     AND a.id_cliente = m.id_cliente
                     AND a.cd_maquina = m.cd_maquina
                   ORDER BY 5 DESC)
      LOOP
         IF reg.email IS NOT NULL THEN
            BEGIN
                --      
                PR_SEND_MAIL( P_TITULO => 'Favor Fechar ou Reabrir OS n� ' || reg.os || ' !' ,
                              P_MENSAGEM => 'Mensagem enviada automaticamente pelo Sistema de OS.' || chr(10) || chr(10) || 'OS. N�: ' || reg.os || ' foi atendida em ' || reg.finalizada || 
                                             ' mais ainda n�o foi fechada ou reaberta!' || chr(10) || 'Tempo de espera: ' || reg.esperando || chr(10) || 'Status: ''Atendida''' || chr(10) || 'M�quina: ' || 
                                             reg.maquina || chr(10) || 'Setor Solicitante: ' || reg.setor || chr(10) || 'Descri��o do Servi�o: ' || reg.servico,
                              P_DE => 'contato.ws4ti@gmail.com',
                              P_PARA => 'costafortes@gmail.com'
                            );              
            EXCEPTION
               WHEN OTHERS THEN
                  NULL;
            END;
         ELSE
            BEGIN
                --      
                PR_SEND_MAIL( P_TITULO => 'Favor Fechar ou Reabrir OS n� ' || reg.os || ' !' ,
                              P_MENSAGEM => 'Mensagem enviada automaticamente pelo Sistema de OS.' || chr(10) || chr(10) || 'OS. N�: ' || reg.os || ' foi atendida em ' || reg.finalizada || 
                                             ' mais ainda n�o foi fechada ou reaberta!' || chr(10) || 'Tempo de espera: ' || reg.esperando || chr(10) || 'Status: ''Atendida''' || chr(10) || 'M�quina: ' || 
                                             reg.maquina || chr(10) || 'Setor Solicitante: ' || reg.setor || chr(10) || 'Descri��o do Servi�o: ' || reg.servico,
                              P_DE => 'contato.ws4ti@gmail.com',
                              P_PARA => 'costafortes@gmail.com'
                            );          
            EXCEPTION
               WHEN OTHERS THEN
                  NULL;
            END;
         END IF;
         -- Conforme conversamos o tempo para o fechamento autom�tico das OS atendidas � de 48 horas. 
         IF reg.esperando_hh > 24 AND reg.esperando_hh < 72 THEN
            BEGIN
                --      
                PR_SEND_MAIL( P_TITULO => 'Favor Fechar ou Reabrir OS n� ' || reg.os || ' !' ,
                              P_MENSAGEM => 'Favor Fechar ou Reabrir OS n� ' || reg.os || ' !' || chr(10) || chr(10) || 'Favor Fechar ou Reabrir OS n� ' || reg.os || ' !' || chr(10) || 
                                            'Mensagem enviada automaticamente pelo Sistema de OS.' || chr(10) || chr(10) || 'OS. N�: ' || reg.os || ' foi atendida em ' || reg.finalizada || 
                                            ' mais ainda n�o foi fechada ou reaberta!' || chr(10) || 'Tempo de espera: ' || reg.esperando || chr(10) || 'Status: ''Atendida''' || chr(10) || 'M�quina: ' || 
                                            reg.maquina || chr(10) || 'Setor Solicitante: ' || reg.setor || chr(10) || 'Descri��o do Servi�o: ' || reg.servico,
                              P_DE => 'contato.ws4ti@gmail.com',
                              P_PARA => 'costafortes@gmail.com'
                            );                 
            EXCEPTION
               WHEN OTHERS THEN
                  raise_application_error(-20001, SQLERRM);
            END;
         ELSIF reg.esperando_hh > 72 THEN
            BEGIN
               -- Call the procedure     
               pck_ordem_servico.pr_evento(reg.id_cliente
                                          ,reg.os
                                          ,'FOS'
                                          ,'Ordem de Servi�o Fechada'
                                          ,to_date(to_char(SYSDATE, 'dd/mm/rrrr hh24:mi'), 'dd/mm/rrrr hh24:mi')
                                          ,to_date(to_char(SYSDATE, 'dd/mm/rrrr hh24:mi'), 'dd/mm/rrrr hh24:mi')
                                          ,'sistema');
            EXCEPTION
               WHEN OTHERS THEN
                  htp.p('{"error":"Erro executando pck_ordem_servico.pr_evento! | ' || SQLERRM || ' "}');
            END;
         END IF;
         -- 
      END LOOP;
      -- 
   END pr_email_fechar_os;

   ------------------------------------------------------------------------------------------
   -- @autor:      jose.costa
   -- @descri��o:  Calcula por OS. o tempo de atendimento do per�odo (em horas)
   -- calcula (intevalo entre primeira dt_abre e ultima dt_fecha) - intervalos sem atendimento
   -- @data:       16/04/2018
   ------------------------------------------------------------------------------------------
   FUNCTION fu_tempo_atend_maquina(p_id_cliente     cliente_os.id_cliente%TYPE
                                  ,p_id_os          cliente_os.id_os%TYPE
                                  ,p_dt_fim_periodo DATE DEFAULT SYSDATE) RETURN NUMBER IS
      v_dt_abre_atos DATE;
      v_dt_fecha     DATE;
      v_qt_int       NUMBER;
      v_qt_tot_int   NUMBER;
      v_qt_tot_ate   NUMBER;
   BEGIN
      v_qt_int       := 0;
      v_qt_tot_int   := 0;
      v_dt_abre_atos := NULL;
      --
      FOR at_ IN (SELECT id_os
                        ,sq_evento
                        ,dt_abre
                        ,nvl(dt_fecha, p_dt_fim_periodo) dt_fecha
                        ,ls_usuario
                    FROM cliente_os_evento
                   WHERE id_cliente = p_id_cliente
                     AND id_os = p_id_os
                     AND tp_evento = 'AAT'
                   ORDER BY id_os
                           ,dt_abre)
      LOOP
         -- armazena a dt inicial do primeiro atendimento...
         IF v_dt_abre_atos IS NULL THEN
            v_dt_abre_atos := at_.dt_abre;
            v_dt_fecha     := at_.dt_fecha;
         ELSE
            --
            IF v_dt_fecha < at_.dt_abre THEN
               BEGIN
                  SELECT (at_.dt_abre - v_dt_fecha) * (24) INTO v_qt_int FROM dual;
               EXCEPTION
                  WHEN OTHERS THEN
                     raise_application_error(-20001, 'Erro calculando intervalo em segundos! ' || SQLERRM);
               END;
               v_qt_tot_int := v_qt_tot_int + v_qt_int;
            END IF;
         END IF;
         -- armazena a dt final do sq. se for maior que a anterior
         IF v_dt_fecha < at_.dt_fecha THEN
            v_dt_fecha := at_.dt_fecha;
         END IF;
      END LOOP;
      -- calcula todo o tempo de atendimento do primeiro at� o ultimo initerrupto...
      BEGIN
         SELECT (v_dt_fecha - v_dt_abre_atos) * (24) INTO v_qt_tot_ate FROM dual;
      EXCEPTION
         WHEN OTHERS THEN
            raise_application_error(-20002, 'Erro calculando total de atendimento em segundos! ' || SQLERRM);
      END;
      -- debita o tempo de intervalo do tempo total de atendimento initerrupto...
      RETURN abs(v_qt_tot_ate - v_qt_tot_int);
      --
   END fu_tempo_atend_maquina;

   ------------------------------------------------------------------------------------------
   -- @autor:      jose.costa
   -- @descri��o:  Retorna no formato (char) 00h 00m 00s uma entrada numerica de segundos
   -- @data:       16/04/2018
   ------------------------------------------------------------------------------------------
   FUNCTION fu_showdate(p_qt_seg IN NUMBER) RETURN VARCHAR2 AS
      l_result VARCHAR2(100);
   BEGIN
      IF p_qt_seg > 0 THEN
         --
         BEGIN
            SELECT to_char(floor((p_qt_seg / 86399) * 24)) || 'h ' || to_char(to_date(round(MOD(p_qt_seg, 86399), 0), 'sssss'), 'mi"m" ss"s"') INTO l_result FROM dual;
         EXCEPTION
            WHEN OTHERS THEN
               raise_application_error(-20099, 'Erro ao converter tempo ! seg.: ' || p_qt_seg || ' | ' || SQLERRM);
         END;
         --
         IF TRIM(l_result) = 'd' THEN
            l_result := NULL;
         END IF;
      END IF;
      --
      RETURN l_result;
   END fu_showdate;

END;

/
