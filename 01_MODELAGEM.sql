/*==============================================================*/
/* Sequences:                                                   */
/*==============================================================*/
CREATE SEQUENCE seq_departamento;
CREATE SEQUENCE seq_historico_acesso;
CREATE SEQUENCE seq_modulo_sistema;
CREATE SEQUENCE seq_perfil_usuario;
CREATE SEQUENCE seq_usuario_departamento;
CREATE SEQUENCE seq_usuario_sistema;

/*==============================================================*/
/* Table: TB_DEPARTAMENTO                                       */
/*==============================================================*/
CREATE TABLE tb_departamento (
    co_departamento  NUMBER(3)    NOT NULL,
    no_departamento  VARCHAR2(50) NOT NULL,
    in_ativo         NUMBER(1)    DEFAULT 1 NOT NULL 
);

ALTER TABLE tb_departamento
    ADD CONSTRAINT ck_departamento_01 CHECK ( in_ativo IN ( 0, 1 ) );

ALTER TABLE tb_departamento ADD CONSTRAINT pk_departamento PRIMARY KEY ( co_departamento )
    USING INDEX;

ALTER TABLE tb_departamento ADD CONSTRAINT uk_departamento_01 UNIQUE ( no_departamento )
    USING INDEX;
    
comment on table TB_DEPARTAMENTO is
'Armazena os departamentos de alocação dos funcionários da empresa.';

comment on column TB_DEPARTAMENTO.CO_DEPARTAMENTO is
'Número gerado automaticamente por um objeto sequencial (SEQ_DEPARTAMENTO) que auxilia na identificação das demais informações do departamento.';

comment on column TB_DEPARTAMENTO.NO_DEPARTAMENTO is
'Nome do departamento.';

comment on column TB_DEPARTAMENTO.IN_ATIVO is
'Identifica se o departametno está ativo: Aceita os seguintes valores: 0 (Inativo) e 1 (Ativo).';

/*==============================================================*/
/* Table: TB_HISTORICO_ACESSO                                   */
/*==============================================================*/
CREATE TABLE tb_historico_acesso (
    id_historico_acesso  NUMBER(10)    NOT NULL,
    id_usuario_sistema   NUMBER(9)     NOT NULL,
    dt_acesso            DATE          DEFAULT SYSDATE NOT NULL,
    nu_ip                VARCHAR2(55)  NOT NULL,
    no_navegador         VARCHAR2(500) NOT NULL
);

ALTER TABLE tb_historico_acesso ADD CONSTRAINT pk_historico_acesso PRIMARY KEY ( id_historico_acesso )
    USING INDEX;

CREATE INDEX idx_historico_acesso_01 ON tb_historico_acesso ( id_usuario_sistema ASC );

comment on table TB_HISTORICO_ACESSO is
'Armazena o histórico de acesso dos usuários no sistema.';

comment on column TB_HISTORICO_ACESSO.ID_HISTORICO_ACESSO is
'Número gerado automaticamente por um objeto sequencial (SEQ_HISTORICO_ACESSO) que auxilia na identificação das demais informações do histórico de acesso do usuário.';

comment on column TB_HISTORICO_ACESSO.ID_USUARIO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_USUARIO_SISTEMA) que auxilia na identificação das demais informações do usuário. Chave estrangeira oriunda da tabela tb_usuario_sistema.';

comment on column TB_HISTORICO_ACESSO.DT_ACESSO is
'Data de acesso do usuário na aplicação.';

comment on column TB_HISTORICO_ACESSO.NU_IP is
'Número de IP de acesso do usuário na aplicação.';

comment on column TB_HISTORICO_ACESSO.NO_NAVEGADOR is
'Navegador de acesso do usuário na aplicação.';

/*==============================================================*/
/* Table: TB_MODULO_SISTEMA                                     */
/*==============================================================*/
CREATE TABLE tb_modulo_sistema (
    co_modulo_sistema  NUMBER(3)     NOT NULL,
    no_modulo_sistema  VARCHAR2(255) NOT NULL,
    in_ativo           NUMBER(1)     DEFAULT 1 NOT NULL
);

ALTER TABLE tb_modulo_sistema
    ADD CONSTRAINT ck_modulo_sistema_01 CHECK ( in_ativo IN ( 0, 1 ) );

ALTER TABLE tb_modulo_sistema ADD CONSTRAINT pk_modulo_sistema PRIMARY KEY ( co_modulo_sistema )
    USING INDEX;

ALTER TABLE tb_modulo_sistema ADD CONSTRAINT uk_modulo_sistema_01 UNIQUE ( no_modulo_sistema )
    USING INDEX;
    
comment on table TB_MODULO_SISTEMA is
'Armazena os módulos do sistema. Os módulos são funcionalidades que o usuário possui acesso no sistema.';

comment on column TB_MODULO_SISTEMA.CO_MODULO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_MODULO_SISTEMA) que auxilia na identificação das demais informações do modulo do sistema.';

comment on column TB_MODULO_SISTEMA.IN_ATIVO is
'Identifica se o módulo do sistema está ativo: Aceita os seguintes valores: 0 (Inativo) e 1 (Ativo).';

/*==============================================================*/
/* Table: TB_PERFIL_MODULO                                      */
/*==============================================================*/
CREATE TABLE tb_perfil_modulo (
    co_perfil_usuario  NUMBER(3) NOT NULL,
    co_modulo_sistema  NUMBER(3) NOT NULL,
    tp_operacao        NUMBER(1) NOT NULL
);

ALTER TABLE TB_PERFIL_MODULO
   ADD CONSTRAINT CK_PERFIL_MODULO_01 check (TP_OPERACAO in (1,2,3,4,5));
   
ALTER TABLE tb_perfil_modulo ADD CONSTRAINT pk_perfil_modulo PRIMARY KEY ( co_perfil_usuario, co_modulo_sistema )
    USING INDEX;
    
comment on table TB_PERFIL_MODULO is
'Armazena os vinculos entre os perfis do usuários e os modulos do sistema.';

comment on column TB_PERFIL_MODULO.CO_PERFIL_USUARIO is
'Número gerado automaticamente por um objeto sequencial (SEQ_PERFIL_USUARIO) que auxilia na identificação das demais informações do perfil. Chave estrangeira oriunda da tabela tb_perfil_usuario.';

comment on column TB_PERFIL_MODULO.CO_MODULO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_MODULO_SISTEMA) que auxilia na identificação das demais informações do modulo do sistema. Chave estrangeira oriunda da tabela tb_modulo_sistema.';

comment on column TB_PERFIL_MODULO.TP_OPERACAO is
'Identifica a operação que o perfil pode realizar no módulo de sistema vinculado: 
Aceita os seguintes valores: 1 (Acesso total), 2 (Inclusão), 3 (Edição), 4(Exclusão) e 5 (Visualização).';

/*==============================================================*/
/* Table: TB_PERFIL_USUARIO                                     */
/*==============================================================*/
CREATE TABLE tb_perfil_usuario (
    co_perfil_usuario  NUMBER(3)    NOT NULL,
    no_perfil_usuario  VARCHAR2(50) NOT NULL,
    in_ativo           NUMBER(1)    DEFAULT 1 NOT NULL
);

ALTER TABLE tb_perfil_usuario
    ADD CONSTRAINT ck_perfil_usuario_01 CHECK ( in_ativo IN ( 0, 1 ) );

ALTER TABLE tb_perfil_usuario ADD CONSTRAINT pk_perfil_usuario PRIMARY KEY ( co_perfil_usuario )
    USING INDEX;

ALTER TABLE tb_perfil_usuario ADD CONSTRAINT uk_perfil_usuario_01 UNIQUE ( no_perfil_usuario )
    USING INDEX;

comment on table TB_PERFIL_USUARIO is
'Armazena os perfis dos sistemas. Os perfis são utilizados para configurar os níveis de acesso que o usuário possui no sistema.';

comment on column TB_PERFIL_USUARIO.CO_PERFIL_USUARIO is
'Número gerado automaticamente por um objeto sequencial (SEQ_PERFIL_USUARIO) que auxilia na identificação das demais informações do perfil.';

comment on column TB_PERFIL_USUARIO.NO_PERFIL_USUARIO is
'Nome do perfil do usuário.';

comment on column TB_PERFIL_USUARIO.IN_ATIVO is
'Identifica se o perfil do usuário está ativo: Aceita os seguintes valores: 0 (Inativo) e 1 (Ativo).';

/*==============================================================*/
/* Table: TB_USUARIO_DEPARTAMENTO                               */
/*==============================================================*/
CREATE TABLE tb_usuario_departamento (
    id_usuario_departamento   NUMBER(10) NOT NULL,
    id_usuario_sistema        NUMBER(9)  NOT NULL,
    co_departamento           NUMBER(3)  NOT NULL,
    dt_ingresso_departamento  DATE,
    dt_saida_departamento     DATE,
    in_pendente_login         NUMBER(1)  DEFAULT 1 NOT NULL
);

ALTER TABLE tb_usuario_departamento
    ADD CONSTRAINT ck_usuario_departamento_01 CHECK ( in_pendente_login IN ( 0, 1 ) );
    
ALTER TABLE tb_usuario_departamento
    ADD CONSTRAINT ck_usuario_departamento_02 CHECK ( dt_ingresso_departamento IS NULL AND in_pendente_login = 1
                                                      OR dt_ingresso_departamento IS NOT NULL AND in_pendente_login = 0 );

ALTER TABLE tb_usuario_departamento ADD CONSTRAINT pk_usuario_departamento PRIMARY KEY ( id_usuario_departamento )
    USING INDEX;
    
alter table TB_USUARIO_DEPARTAMENTO
   add constraint UK_USUARIO_DEPARTAMENTO_01 unique (id_usuario_sistema, co_departamento, dt_ingresso_departamento)
      using index;

CREATE INDEX idx_usuario_departamento_01 ON tb_usuario_departamento ( co_departamento ASC );

CREATE INDEX idx_usuario_departamento_02 ON tb_usuario_departamento ( id_usuario_sistema ASC );

comment on table TB_USUARIO_DEPARTAMENTO is
'Armazena o histórico de alocação dos usuários nos departamentos.';

comment on column TB_USUARIO_DEPARTAMENTO.ID_USUARIO_DEPARTAMENTO is
'Número gerado automaticamente por um objeto sequencial (SEQ_USUARIO_SISTEMA) que auxilia na identificação das demais informações do histórico de alocação do usuário no departamento';

comment on column TB_USUARIO_DEPARTAMENTO.ID_USUARIO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_USUARIO_SISTEMA) que auxilia na identificação das demais informações do usuário. Chave estrangeira oriunda da tabela tb_usuario_sistema.';

comment on column TB_USUARIO_DEPARTAMENTO.CO_DEPARTAMENTO is
'Número gerado automaticamente por um objeto sequencial (SEQ_DEPARTAMENTO) que auxilia na identificação das demais informações do departamento. Chave estrangeira oriunda da tabela tb_departamento.';

comment on column TB_USUARIO_DEPARTAMENTO.DT_INGRESSO_DEPARTAMENTO is
'Data de ingresso do usuário no departamento.';

comment on column TB_USUARIO_DEPARTAMENTO.DT_SAIDA_DEPARTAMENTO is
'Data de saída do usuário no departamento.';

comment on column TB_USUARIO_DEPARTAMENTO.IN_PENDENTE_LOGIN is
'Identifica se alocação do usuário no departamento está pendente de ciencia do usuário: Aceita os seguintes valores: 0 (Não) e 1 (Sim).';

/*==============================================================*/
/* Table: TB_USUARIO_SISTEMA                                    */
/*==============================================================*/
CREATE TABLE tb_usuario_sistema (
    id_usuario_sistema  NUMBER(9)     NOT NULL,
    co_perfil_usuario   NUMBER(3)     NOT NULL,
    no_pessoa           VARCHAR2(120) NOT NULL,
    tx_email            VARCHAR2(120) NOT NULL,
    tx_senha            VARCHAR2(120) NOT NULL,
    in_ativo            NUMBER(1)     DEFAULT 1 NOT NULL
);

ALTER TABLE tb_usuario_sistema
    ADD CONSTRAINT ck_usuario_sistema_01 CHECK ( in_ativo IN ( 0, 1 ) );

ALTER TABLE tb_usuario_sistema ADD CONSTRAINT pk_usuario_sistema PRIMARY KEY ( id_usuario_sistema )
    USING INDEX;

ALTER TABLE tb_usuario_sistema ADD CONSTRAINT uk_usuario_sistema_01 UNIQUE ( tx_email )
    USING INDEX;

CREATE INDEX idx_usuario_sistema_01 ON tb_usuario_sistema ( co_perfil_usuario ASC );

comment on table TB_USUARIO_SISTEMA is
'Armazena os usuários que possui cadastro no sistema.';

comment on column TB_USUARIO_SISTEMA.ID_USUARIO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_USUARIO_SISTEMA) que auxilia na identificação das demais informações do usuário.';

comment on column TB_USUARIO_SISTEMA.CO_PERFIL_USUARIO is
'Número gerado automaticamente por um objeto sequencial (SEQ_PERFIL_USUARIO) que auxilia na identificação das demais informações do perfil. Chave estrangeira oriunda da tabela tb_perfil_usuario.';

comment on column TB_USUARIO_SISTEMA.NO_PESSOA is
'Nome do usuário.';

comment on column TB_USUARIO_SISTEMA.TX_EMAIL is
'Endereço de email que será utilizado para o login do usuário.';

comment on column TB_USUARIO_SISTEMA.TX_SENHA is
'Senha criptogradaque será utilizado para o login do usuário';

comment on column TB_USUARIO_SISTEMA.IN_ATIVO is
'Identifica se o usuário está ativo: Aceita os seguintes valores: 0 (Inativo) e 1 (Ativo).';

/*==============================================================*/
/* References: Foreign Key                                      */
/*==============================================================*/
ALTER TABLE tb_historico_acesso
    ADD CONSTRAINT fk_usuar_sistema_histor_acesso FOREIGN KEY ( id_usuario_sistema )
        REFERENCES tb_usuario_sistema ( id_usuario_sistema )
    NOT DEFERRABLE;

ALTER TABLE tb_perfil_modulo
    ADD CONSTRAINT fk_modulo_sistema_perfil_modul FOREIGN KEY ( co_modulo_sistema )
        REFERENCES tb_modulo_sistema ( co_modulo_sistema )
    NOT DEFERRABLE;

ALTER TABLE tb_perfil_modulo
    ADD CONSTRAINT fk_perfil_usuario_perfil_modul FOREIGN KEY ( co_perfil_usuario )
        REFERENCES tb_perfil_usuario ( co_perfil_usuario )
    NOT DEFERRABLE;

ALTER TABLE tb_usuario_departamento
    ADD CONSTRAINT fk_departamento_usuario_depart FOREIGN KEY ( co_departamento )
        REFERENCES tb_departamento ( co_departamento )
    NOT DEFERRABLE;

ALTER TABLE tb_usuario_departamento
    ADD CONSTRAINT fk_usuario_sist_usuario_depart FOREIGN KEY ( id_usuario_sistema )
        REFERENCES tb_usuario_sistema ( id_usuario_sistema )
    NOT DEFERRABLE;

ALTER TABLE tb_usuario_sistema
    ADD CONSTRAINT fk_perfil_sistema_usuario FOREIGN KEY ( co_perfil_usuario )
        REFERENCES tb_perfil_usuario ( co_perfil_usuario )
    NOT DEFERRABLE;
    
    
/*==============================================================*/
/* View: VW_USUARIO_SISTEMA                                     */
/*==============================================================*/
CREATE OR REPLACE VIEW vw_usuario_sistema AS 
    WITH cte_historico_acesso AS (
        SELECT
            historico.id_usuario_sistema,
            MAX(historico.dt_acesso) as dt_ultimo_login
        FROM
            tb_historico_acesso historico
        GROUP BY
            historico.id_usuario_sistema
    ), cte_departamento AS (
        SELECT
            usuario_departamento.id_usuario_sistema,
            departamento.co_departamento as co_departamento_atual,
            departamento.no_departamento as no_departamento_atual
        FROM
            tb_usuario_departamento usuario_departamento
            INNER JOIN tb_departamento departamento ON usuario_departamento.co_departamento = departamento.co_departamento
        WHERE
            in_pendente_login != 1 -- sim 
            AND dt_saida_departamento IS NULL
    ), cte_modulo_sistema AS (
        SELECT
            perfil_modulo.co_perfil_usuario,
            LISTAGG (modulo_sistema.no_modulo_sistema, '; ') AS tx_lista_modulos
        FROM
            tb_perfil_modulo perfil_modulo
            INNER JOIN tb_modulo_sistema modulo_sistema ON perfil_modulo.co_modulo_sistema = modulo_sistema.co_modulo_sistema
        WHERE
            modulo_sistema.in_ativo = 1
        GROUP BY
            perfil_modulo.co_perfil_usuario
    ) SELECT
        usuario.id_usuario_sistema,
        usuario.no_pessoa,
        CASE WHEN usuario.in_ativo = 1 THEN 'ATIVO' ELSE 'INATIVO' END AS ds_status,
        historico_acesso.dt_ultimo_login,
        departamento.no_departamento_atual,
        modulo_sistema.tx_lista_modulos
    FROM
        tb_usuario_sistema usuario
        INNER JOIN cte_modulo_sistema modulo_sistema ON usuario.co_perfil_usuario = modulo_sistema.co_perfil_usuario
        LEFT JOIN cte_historico_acesso historico_acesso ON usuario.id_usuario_sistema = historico_acesso.id_usuario_sistema
        LEFT JOIN cte_departamento departamento ON usuario.id_usuario_sistema = departamento.id_usuario_sistema;

comment on column VW_USUARIO_SISTEMA.ID_USUARIO_SISTEMA is
'Número gerado automaticamente por um objeto sequencial (SEQ_USUARIO_SISTEMA) que auxilia na identificação das demais informações do usuário.';

comment on column VW_USUARIO_SISTEMA.NO_PESSOA is
'Nome do usuário.';

comment on column VW_USUARIO_SISTEMA.DS_STATUS is
'Identifica se o status do usuário.';

comment on column VW_USUARIO_SISTEMA.DT_ULTIMO_LOGIN is
'Data do último login do usuário.';

comment on column VW_USUARIO_SISTEMA.NO_DEPARTAMENTO_ATUAL is
'Nome do departamento atual do usuário.';

comment on column VW_USUARIO_SISTEMA.TX_LISTA_MODULOS is
'Módulos que o usuário tem acesso no sistema.';

