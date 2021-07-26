SET SERVEROUTPUT ON;

DECLARE
    p_usuario_sistema      pkg_usuario_sistema.rec_usuario_sistema;
    p_nu_retorno           NUMBER;
    p_tx_mensagem_retorno  VARCHAR2(200);
BEGIN
    p_nu_retorno           := NULL;
    p_usuario_sistema.no_pessoa         :=    'Francisco Leandro Samuel Barbosa';      
    p_usuario_sistema.tx_email          :=    'franciscoleandrosamuelbarbosa@gmail.com';  
    p_usuario_sistema.tx_senha          :=    '57483109459';  
    p_usuario_sistema.co_perfil_usuario :=    1;  

    pkg_usuario_sistema.prc_incluir_usuario( p_usuario_sistema => p_usuario_sistema,
                                             p_nu_retorno => p_nu_retorno,
                                             p_tx_mensagem_retorno => p_tx_mensagem_retorno);
                                             
    
    DBMS_OUTPUT.PUT_LINE( 'Retorno: '||p_nu_retorno|| CHR(10)||'Texto Mensagem: '||p_tx_mensagem_retorno);
END;
/

SELECT
    *
FROM
    pkg_usuario_sistema.fnc_consultar_usuario ( 8 );
    
DECLARE
  P_VINCULA_DEPARTAMENTO pkg_usuario_sistema.rec_vincula_departamento;
  P_NU_RETORNO NUMBER;
  P_TX_MENSAGEM_RETORNO VARCHAR2(200);
    
BEGIN
    p_vincula_departamento.id_usuario_sistema := 8;
    p_vincula_departamento.co_departamento := 5;
    p_nu_retorno := NULL;
    p_tx_mensagem_retorno := NULL;

    pkg_usuario_sistema.prc_vincular_usuario_departamento( p_vincula_departamento => p_vincula_departamento,
                                                           p_nu_retorno => p_nu_retorno,
                                                          p_tx_mensagem_retorno => p_tx_mensagem_retorno);
    DBMS_OUTPUT.PUT_LINE( 'Retorno: '||p_nu_retorno|| CHR(10)||'Texto Mensagem: '||p_tx_mensagem_retorno);
END;
/

SELECT
    *
FROM
    pkg_usuario_sistema.fnc_consultar_usuario ( 8 );
    
DECLARE
    p_historico_acesso      pkg_usuario_sistema.rec_acesso_sistema;
    p_nu_retorno           NUMBER;
    p_tx_mensagem_retorno  VARCHAR2(200);
BEGIN
    p_nu_retorno                        := NULL;
    p_historico_acesso.tx_email          :=    'franciscoleandrosamuelbarbosa@gmail.com';  
    p_historico_acesso.tx_senha          :=    '57483109459';
    p_historico_acesso.nu_ip               :=    '127.0.0.1';
    p_historico_acesso.no_navegador        :=    'Google Chorme';

   pkg_usuario_sistema.prc_registrar_acesso_sistema( p_historico_acesso => p_historico_acesso,
                                                     p_nu_retorno => p_nu_retorno,
                                                     p_tx_mensagem_retorno => p_tx_mensagem_retorno
);
END; 
/

SELECT
    *
FROM
    pkg_usuario_sistema.fnc_consultar_usuario ( 8 );

DECLARE
  P_VINCULA_DEPARTAMENTO pkg_usuario_sistema.rec_vincula_departamento;
  P_NU_RETORNO NUMBER;
  P_TX_MENSAGEM_RETORNO VARCHAR2(200);
    
BEGIN
    p_vincula_departamento.id_usuario_sistema := 8;
    p_vincula_departamento.co_departamento := 5;
    p_nu_retorno := NULL;
    p_tx_mensagem_retorno := NULL;

    pkg_usuario_sistema.prc_vincular_usuario_departamento( p_vincula_departamento => p_vincula_departamento,
                                                           p_nu_retorno => p_nu_retorno,
                                                          p_tx_mensagem_retorno => p_tx_mensagem_retorno);
    DBMS_OUTPUT.PUT_LINE( 'Retorno: '||p_nu_retorno|| CHR(10)||'Texto Mensagem: '||p_tx_mensagem_retorno);
END;
/


SELECT
    *
FROM
    pkg_usuario_sistema.fnc_consultar_usuario ( 8 );