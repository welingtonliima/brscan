CREATE OR REPLACE PACKAGE pkg_usuario_sistema AS

    --// Constantes de Retorno Operação
    cg_operacao_sucesso CONSTANT NUMBER := 1;
    cg_operacao_falha CONSTANT NUMBER := 0;
    
    TYPE rec_usuario_sistema IS RECORD (
        no_pessoa          tb_usuario_sistema.no_pessoa%TYPE,
        tx_email           tb_usuario_sistema.tx_email%TYPE,
        tx_senha           tb_usuario_sistema.tx_senha%TYPE,
        co_perfil_usuario  tb_usuario_sistema.tx_senha%TYPE
    );
    
    TYPE rec_acesso_sistema IS RECORD (
        tx_email            tb_usuario_sistema.tx_email%TYPE,
        tx_senha            tb_usuario_sistema.tx_senha%TYPE,
        nu_ip               tb_historico_acesso.nu_ip%TYPE,
        no_navegador        tb_historico_acesso.no_navegador%TYPE
    );
    
    TYPE rec_vincula_departamento IS RECORD (
        id_usuario_sistema  tb_usuario_departamento.id_usuario_sistema%TYPE,
        co_departamento     tb_usuario_departamento.co_departamento%TYPE
    );
    
    TYPE typ_usuario_sistema IS TABLE OF vw_usuario_sistema%rowtype;

    /**
    * Função responsável pela consulta dos usuários no banco;
    * @param p_id_usuario_sistema: Identificador do usuário no sistema;
    * @return typ_usuario_sistema: Lista de 0(zero) ou mais usuários. Quando não retornar
    * nenhuma linha, significa que dos parâmetros passados não existe.
    **/    
    FUNCTION fnc_consultar_usuario ( p_id_usuario_sistema IN tb_usuario_sistema.id_usuario_sistema%TYPE ) RETURN typ_usuario_sistema PIPELINED;
    
    
    /**
    * Método responsável pela gravação do usuário nno banco;
    * @param rec_usuario_sistema: RECORD com todas os atributos do usuário.;
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/
    PROCEDURE prc_incluir_usuario (
        p_usuario_sistema      IN   rec_usuario_sistema,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    );

    /**
    * Método responsável pela alteração do usuário no banco;
    * @param p_id_usuario_sistema: Identificador do usuário no sistema que será alterado;
    * @param rec_usuario_sistema: RECORD com todas os atributos do usuário.;
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/
    PROCEDURE prc_alterar_usuario (
        p_id_usuario_sistema   IN   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_usuario_sistema      IN   rec_usuario_sistema,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    );

    /**
    * Método responsável pela exclusão do usuário no banco;
    * @param p_id_usuario_sistema: Identificador do usuário no sistema que será excluído;
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/
    PROCEDURE prc_deletar_usuario (
        p_id_usuario_sistema   IN   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    );

    /**
    * Método responsável pela atualização da situação do usuário no banco;
    * @param p_id_usuario_sistema: Identificador do usuário no sistema que terá o status atualizado;
    * @param p_in_situacao: Identifica se o usuário será desativado (1) ou ativado (1).
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/
    PROCEDURE prc_atualizar_situacao_usuario (
        p_id_usuario_sistema   IN   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_in_situacao          IN   tb_usuario_sistema.in_ativo%TYPE,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    );
    
    /**
    * Método responsável pelo inativação do usuário com mais de 60 dias sem acesso no sistema.
    **/        
    PROCEDURE prc_inativar_usuario;
    

    /**
    * Método responsável pela autenticação e historico de acesso do usuário no banco;
    * @param p_historico_acesso: RECORD com todas os atributos do HISTORICO DE ACESSO;
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/    
    PROCEDURE prc_registrar_acesso_sistema (
        p_historico_acesso     IN rec_acesso_sistema,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2    
    );
 
    /**
    * Método responsável pelo vinculo do usuário em um departamento.
    * @param p_vincula_departamento: RECORD com todas os atributos do vinculo departamento;
    * @return p_nu_retorno:  0: Operação com Erro; 1: Operação com Sucesso;
    * @return p_tx_mensagem_retorno:  Mensagem com o retorno da operação;
    **/       
    PROCEDURE prc_vincular_usuario_departamento (
        p_vincula_departamento     IN rec_vincula_departamento,
        p_nu_retorno               OUT  NUMBER,
        p_tx_mensagem_retorno      OUT  VARCHAR2    
    ); 
 

END pkg_usuario_sistema;
/


CREATE OR REPLACE PACKAGE BODY pkg_usuario_sistema AS

    FUNCTION fnc_autenticar_usuario ( p_tx_email tb_usuario_sistema.tx_email%TYPE ,
                                     p_tx_senha tb_usuario_sistema.tx_senha%TYPE ) RETURN NUMBER IS
        v_id_usuario_sistema NUMBER := 0;
    BEGIN
        SELECT id_usuario_sistema INTO v_id_usuario_sistema
            FROM tb_usuario_sistema
            WHERE tx_email = p_tx_email
                  and tx_senha = p_tx_senha;
        RETURN v_id_usuario_sistema;
    END fnc_autenticar_usuario;
    
    
    FUNCTION fnc_existe_usuario ( p_id_usuario_sistema tb_usuario_sistema.id_usuario_sistema%TYPE ) RETURN NUMBER IS
        v_total_registros NUMBER := 0;
    BEGIN
        SELECT COUNT(1) INTO v_total_registros
            FROM tb_usuario_sistema
            WHERE id_usuario_sistema = p_id_usuario_sistema;
        RETURN v_total_registros;
    END fnc_existe_usuario;

    FUNCTION fnc_validacao_usuario ( p_usuario_sistema rec_usuario_sistema ) RETURN BOOLEAN IS
        v_in_valido BOOLEAN := false;
    BEGIN
        IF p_usuario_sistema.co_perfil_usuario IS NOT NULL
           AND p_usuario_sistema.no_pessoa IS NOT NULL
           AND p_usuario_sistema.tx_email IS NOT NULL
           AND p_usuario_sistema.tx_senha IS NOT NULL
        THEN
            v_in_valido := true;
        END IF;
        RETURN v_in_valido;
    END fnc_validacao_usuario;
    
    FUNCTION fnc_existe_usuar_vinc_pendente ( p_id_usuario_sistema tb_usuario_sistema.id_usuario_sistema%type ) RETURN NUMBER IS
        v_total_registros NUMBER := 0;
    BEGIN
        SELECT COUNT(1) INTO v_total_registros
            FROM tb_usuario_departamento
            WHERE id_usuario_sistema = p_id_usuario_sistema
                  AND in_pendente_login = 1;
        RETURN v_total_registros;
    END fnc_existe_usuar_vinc_pendente;
    
    
    FUNCTION fnc_consultar_usuario (p_id_usuario_sistema IN tb_usuario_sistema.id_usuario_sistema%TYPE ) RETURN typ_usuario_sistema PIPELINED 
    IS
        v_tx_consulta CLOB;
        v_usuarios typ_usuario_sistema := typ_usuario_sistema();
    BEGIN
        v_tx_consulta := 'SELECT * FROM VW_USUARIO_SISTEMA WHERE 1 = 1 ';
                
        IF p_id_usuario_sistema IS NOT NULL THEN
            v_tx_consulta := v_tx_consulta || ' AND id_usuario_sistema = ' || CHR(39) || p_id_usuario_sistema || CHR(39);
            
            EXECUTE IMMEDIATE v_tx_consulta BULK COLLECT INTO v_usuarios;
    
            FOR n_usuario IN 1..v_usuarios.COUNT LOOP
                PIPE ROW (v_usuarios(n_usuario));
            END LOOP;
            RETURN;
        END IF;
        RETURN;
    END fnc_consultar_usuario;

    PROCEDURE prc_incluir_usuario ( p_usuario_sistema      IN   rec_usuario_sistema,
                                    p_nu_retorno           OUT  NUMBER,
                                    p_tx_mensagem_retorno  OUT  VARCHAR2 ) IS
        c_usuario_ativo NUMBER := 1;
    BEGIN
        IF fnc_validacao_usuario(p_usuario_sistema) THEN
            INSERT INTO tb_usuario_sistema (
                id_usuario_sistema,
                co_perfil_usuario,
                no_pessoa,
                tx_email,
                tx_senha,
                in_ativo
            ) VALUES (
                seq_usuario_sistema.NEXTVAL,
                p_usuario_sistema.co_perfil_usuario,
                p_usuario_sistema.no_pessoa,
                p_usuario_sistema.tx_email,
                p_usuario_sistema.tx_senha,
                c_usuario_ativo
            );
            COMMIT;
            p_nu_retorno := cg_operacao_sucesso;
            p_tx_mensagem_retorno := 'Usuário inserido com sucesso. ';
        ELSE
            p_nu_retorno := cg_operacao_falha;
            p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar INCLUIR o usuário. Campos obrigatórios não Preenchidos';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_tx_mensagem_retorno := sqlerrm;
            p_nu_retorno := cg_operacao_falha;
    END prc_incluir_usuario;


    PROCEDURE prc_alterar_usuario (
        p_id_usuario_sistema   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_usuario_sistema      IN   rec_usuario_sistema,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    ) AS
    BEGIN
        IF fnc_existe_usuario(p_id_usuario_sistema) > 0 THEN
            IF fnc_validacao_usuario(p_usuario_sistema) THEN
                UPDATE tb_usuario_sistema
                    SET no_pessoa = p_usuario_sistema.no_pessoa,
                        tx_email = p_usuario_sistema.tx_email,
                        co_perfil_usuario = p_usuario_sistema.co_perfil_usuario
                WHERE
                    id_usuario_sistema = p_id_usuario_sistema;
                COMMIT;
                p_nu_retorno := cg_operacao_sucesso;
                p_tx_mensagem_retorno := 'Usuário alterado com sucesso. ';
            ELSE
                p_nu_retorno := cg_operacao_falha;
                p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar ALTERAR o usuário. Campos obrigatórios não Preenchidos';
            END IF;
        ELSE
            p_nu_retorno := cg_operacao_falha;
            p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar ALTERAR o usuário. O valor do id_usuario_sistema não existe na base. ';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_tx_mensagem_retorno := sqlerrm;
            p_nu_retorno := cg_operacao_falha;
    END prc_alterar_usuario;


    PROCEDURE prc_deletar_usuario (
        p_id_usuario_sistema   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    ) AS
    BEGIN
        IF fnc_existe_usuario(p_id_usuario_sistema) > 0 THEN
            DELETE FROM tb_historico_acesso
            WHERE
                id_usuario_sistema = p_id_usuario_sistema;

            DELETE FROM tb_usuario_departamento
            WHERE
                id_usuario_sistema = p_id_usuario_sistema;

            DELETE FROM tb_usuario_sistema
            WHERE
                id_usuario_sistema = p_id_usuario_sistema;

            COMMIT;
            p_tx_mensagem_retorno := 'Usuário excluído com sucesso. ';
            p_nu_retorno := cg_operacao_sucesso;
        ELSE
            p_nu_retorno := cg_operacao_falha;
            p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar EXCLUIR o usuário. O valor do id_usuario_sistema não existe na base. ';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_tx_mensagem_retorno := sqlerrm;
            p_nu_retorno := cg_operacao_falha;
    END prc_deletar_usuario;


    PROCEDURE prc_atualizar_situacao_usuario (
        p_id_usuario_sistema   IN   tb_usuario_sistema.id_usuario_sistema%TYPE,
        p_in_situacao          IN   tb_usuario_sistema.in_ativo%TYPE,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2
    ) AS
    BEGIN
        IF p_id_usuario_sistema IS NOT NULL
           AND p_in_situacao IS NOT NULL
           AND p_in_situacao IN ( 0, 1 )
        THEN
            IF fnc_existe_usuario(p_id_usuario_sistema) > 0 THEN
                UPDATE tb_usuario_sistema
                SET
                    in_ativo = p_in_situacao
                WHERE
                    id_usuario_sistema = p_id_usuario_sistema;
                COMMIT;
                p_tx_mensagem_retorno := 'Situação do usuário atualizada com sucesso. ';
                p_nu_retorno := cg_operacao_sucesso;
            ELSE
                p_nu_retorno := cg_operacao_falha;
                p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar ALTERAR SITUAÇÃO do usuário. O valor do id_usuario_sistema não existe na base. ';
            END IF;
        ELSE
            p_nu_retorno := cg_operacao_falha;
            p_tx_mensagem_retorno := 'ORA-20001: Erro ao tentar ALTERAR SITUAÇÃO do usuário. Campos obrigatórios não preenchidos ou inválidos';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_tx_mensagem_retorno := sqlerrm;
            p_nu_retorno := cg_operacao_falha;
    END prc_atualizar_situacao_usuario;
    
    PROCEDURE prc_inativar_usuario AS
    BEGIN
        UPDATE tb_usuario_sistema destino
        SET
            destino.in_ativo = 0
        WHERE
            EXISTS (
                SELECT
                    1
                FROM
                    vw_usuario_sistema origem
                WHERE
                    origem.id_usuario_sistema = destino.id_usuario_sistema
                    AND trunc(dt_ultimo_login) < add_months(trunc(sysdate), - 2 )
            );
        COMMIT;
    END;
    
    PROCEDURE prc_atualizar_usuario_depart (
        p_id_usuario_sistema IN tb_usuario_sistema.id_usuario_sistema%type
    ) AS
    BEGIN
        IF fnc_existe_usuar_vinc_pendente(p_id_usuario_sistema) > 0 THEN
            UPDATE tb_usuario_departamento
            SET
                dt_saida_departamento = sysdate
            WHERE
                id_usuario_sistema = p_id_usuario_sistema
                AND dt_saida_departamento IS NULL
                AND in_pendente_login = 0;

            UPDATE tb_usuario_departamento
            SET
                dt_ingresso_departamento = sysdate,
                in_pendente_login = 0
            WHERE
                id_usuario_sistema = p_id_usuario_sistema
                AND in_pendente_login = 1;
        END IF;
    END;
    
    PROCEDURE prc_vincular_usuario_departamento (
        p_vincula_departamento     IN rec_vincula_departamento,
        p_nu_retorno               OUT  NUMBER,
        p_tx_mensagem_retorno      OUT  VARCHAR2    
    ) AS 
    BEGIN
        IF p_vincula_departamento.id_usuario_sistema IS NOT NULL
           AND p_vincula_departamento.co_departamento IS NOT NULL
           AND fnc_existe_usuario (p_vincula_departamento.id_usuario_sistema) > 0
           AND fnc_existe_usuar_vinc_pendente (p_vincula_departamento.id_usuario_sistema) < 1
        THEN
            INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login ) 
                VALUES (seq_usuario_departamento.nextval, p_vincula_departamento.id_usuario_sistema, p_vincula_departamento.co_departamento, NULL, NULL, 1);
            COMMIT;
            p_tx_mensagem_retorno := ' Usuário vinculado ao departamento. Aguardando o login para aprovação ';
            p_nu_retorno := cg_operacao_sucesso;
        ELSE
            p_tx_mensagem_retorno := 'ORA-20001: Campos obrigatórios não preenchidos ou usuário não existe na base ou existe um registro em aberto. ';
            p_nu_retorno := cg_operacao_falha;   
        END IF;
    END prc_vincular_usuario_departamento; 
    
    
    PROCEDURE prc_registrar_acesso_sistema (
        p_historico_acesso     IN rec_acesso_sistema,
        p_nu_retorno           OUT  NUMBER,
        p_tx_mensagem_retorno  OUT  VARCHAR2    
    ) AS
        v_id_usuario_sistema NUMBER;
    BEGIN
        IF p_historico_acesso.tx_senha IS NOT NULL
           AND p_historico_acesso.tx_email IS NOT NULL
           AND p_historico_acesso.nu_ip IS NOT NULL
           AND p_historico_acesso.no_navegador IS NOT NULL
        THEN
            v_id_usuario_sistema := fnc_autenticar_usuario ( p_historico_acesso.tx_email , p_historico_acesso.tx_senha );
            
            IF v_id_usuario_sistema > 0 THEN
            
                INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) 
                    VALUES (seq_historico_acesso.nextval, v_id_usuario_sistema, sysdate, p_historico_acesso.nu_ip, p_historico_acesso.no_navegador);
                    
                prc_atualizar_usuario_depart (v_id_usuario_sistema);
                COMMIT;
                p_tx_mensagem_retorno := 'Usuário autenticado com sucesso. ';
                p_nu_retorno := cg_operacao_sucesso;
            ELSE
                p_tx_mensagem_retorno := 'ORA-20001: Erro na autenticação. ';
                p_nu_retorno := cg_operacao_falha;  
            END IF;
        ELSE
            p_tx_mensagem_retorno := 'ORA-20001: Campos obrigátorios não preenchidos. ';
            p_nu_retorno := cg_operacao_falha;
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            p_tx_mensagem_retorno := sqlerrm;
            p_nu_retorno := cg_operacao_falha;    
    END prc_registrar_acesso_sistema;
    

END pkg_usuario_sistema;
/