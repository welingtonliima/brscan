/*==============================================================*/
/* Insert: TB_DEPARTAMENTO                                      */
/*==============================================================*/
INSERT INTO tb_departamento ( co_departamento, no_departamento, in_ativo ) VALUES ( seq_departamento.nextval, 'Administrativo', 1);
INSERT INTO tb_departamento ( co_departamento, no_departamento, in_ativo ) VALUES ( seq_departamento.nextval, 'Financeiro', 1);
INSERT INTO tb_departamento ( co_departamento, no_departamento, in_ativo ) VALUES ( seq_departamento.nextval, 'Recursos Humanos', 1);
INSERT INTO tb_departamento ( co_departamento, no_departamento, in_ativo ) VALUES ( seq_departamento.nextval, 'Comercial', 1);
INSERT INTO tb_departamento ( co_departamento, no_departamento, in_ativo ) VALUES ( seq_departamento.nextval, 'Operacional', 1);

/*==============================================================*/
/* Insert: TB_MODULO_SISTEMA                                    */
/*==============================================================*/
INSERT INTO tb_modulo_sistema ( co_modulo_sistema, no_modulo_sistema, in_ativo) VALUES (seq_modulo_sistema.nextval, 'Manter Departamento', 1);
INSERT INTO tb_modulo_sistema ( co_modulo_sistema, no_modulo_sistema, in_ativo) VALUES (seq_modulo_sistema.nextval, 'Manter Perfil Acesso', 1);
INSERT INTO tb_modulo_sistema ( co_modulo_sistema, no_modulo_sistema, in_ativo) VALUES (seq_modulo_sistema.nextval, 'Manter Módulo', 1);
INSERT INTO tb_modulo_sistema ( co_modulo_sistema, no_modulo_sistema, in_ativo) VALUES (seq_modulo_sistema.nextval, 'Manter Usuário', 1);
INSERT INTO tb_modulo_sistema ( co_modulo_sistema, no_modulo_sistema, in_ativo) VALUES (seq_modulo_sistema.nextval, 'Manter Perfil Usuário', 1);

/*==============================================================*/
/* Insert: TB_PERFIL_USUARIO                                    */
/*==============================================================*/
INSERT INTO tb_perfil_usuario ( co_perfil_usuario, no_perfil_usuario, in_ativo) VALUES (seq_perfil_usuario.nextval, UPPER('Padrão'),1);
INSERT INTO tb_perfil_usuario ( co_perfil_usuario, no_perfil_usuario, in_ativo) VALUES (seq_perfil_usuario.nextval, UPPER('Administrador Recursos Humanos'), 1);
INSERT INTO tb_perfil_usuario ( co_perfil_usuario, no_perfil_usuario, in_ativo) VALUES (seq_perfil_usuario.nextval, UPPER('Administrador de TI'), 1);

/*==============================================================*/
/* Insert: TB_PERFIL_MODULO                                    */
/*==============================================================*/
INSERT INTO tb_perfil_modulo ( co_perfil_usuario, co_modulo_sistema, tp_operacao) VALUES ( 1, 1, 5);
INSERT INTO tb_perfil_modulo ( co_perfil_usuario, co_modulo_sistema, tp_operacao) VALUES ( 1, 2, 5);
INSERT INTO tb_perfil_modulo ( co_perfil_usuario, co_modulo_sistema, tp_operacao) VALUES ( 1, 3, 5);
INSERT INTO tb_perfil_modulo ( co_perfil_usuario, co_modulo_sistema, tp_operacao) VALUES ( 1, 4, 5);

/*==============================================================*/
/* Insert: TB_USUARIO_SISTEMA                                    */
/*==============================================================*/
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Rita e Valentina', 'ritaevalentina@hotmail.com', '19998216434', 1);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Jennifer e Yago Entulhos', 'jenniferyago@hotmail.com', '1829702336', 0);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Paulo e Caleb', 'paulocaleb@hotmail.com', '1937332418', 1);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Heitor e Isaac ', 'heitorissac@hotmail.com', '16981851352', 1);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Giovanni e Tomás', 'giovanitomar@hotmail.com', '69984451821', 1);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Diogo Juan Oliveira', 'diogojuanoliveira@hotmail.com', '83992854060', 0);
INSERT INTO tb_usuario_sistema ( id_usuario_sistema, co_perfil_usuario, no_pessoa, tx_email, tx_senha, in_ativo) VALUES ( seq_usuario_sistema.nextval, 1, 'Nelson Ian dos Santos', 'nelsoniandossantos@hotmail.com', '79994266153', 1);

COMMIT;


/*==============================================================*/
/* Insert: TB_USUARIO_DEPARTAMENTO                              */
/*==============================================================*/
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 1, 1, '20/11/2006', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 2, 1, '25/08/2007', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 3, 2, '17/06/2009', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 4, 2, '19/05/2011', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 5, 3, '05/08/2013', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 6, 3, '12/11/2015', NULL, 0);
INSERT INTO tb_usuario_departamento ( id_usuario_departamento, id_usuario_sistema, co_departamento, dt_ingresso_departamento, dt_saida_departamento, in_pendente_login) VALUES (seq_usuario_departamento.nextval, 7, 4, '13/12/2017', NULL, 0);

COMMIT;

/*==============================================================*/
/* Insert: TB_USUARIO_DEPARTAMENTO                              */
/*==============================================================*/
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 1, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 2, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 3, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 4, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 5, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 6, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 7, sysdate, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 1, sysdate-9, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 2, sysdate-8, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 3, sysdate-5, '127.0.01','Mozzila Firefox');
INSERT INTO tb_historico_acesso ( id_historico_acesso, id_usuario_sistema, dt_acesso, nu_ip, no_navegador) VALUES ( seq_historico_acesso.nextval, 4, sysdate-4, '127.0.01','Mozzila Firefox');

COMMIT;



