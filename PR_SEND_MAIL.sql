--------------------------------------------------------
--  DDL for Procedure PR_SEND_MAIL
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "WS4TI"."PR_SEND_MAIL" (p_titulo IN VARCHAR2,
                                            p_mensagem IN VARCHAR2,
                                            p_de IN VARCHAR2,
                                            p_para IN VARCHAR2)
is
    l_body   CLOB;    
BEGIN
    BEGIN
        l_body := 'WS4MIND Mail'
        || utl_tcp.crlf;
        l_body := l_body
        ||p_mensagem
        || utl_tcp.crlf
        || utl_tcp.crlf;
        l_body := l_body
        || ' E-mail autom�tico, favor n�o responder!'
        || utl_tcp.crlf;
        apex_mail.send(p_to => p_para, -- change to your email address
        p_from => p_de, -- change to a real senders email address
        p_body => l_body,p_subj => 'WS4MIND | '||p_titulo);            
    EXCEPTION
       WHEN OTHERS THEN
          raise_application_error(-20099, 'Erro enviando e-mail! | '||SQLERRM);
    END;
end PR_SEND_MAIL;

/
