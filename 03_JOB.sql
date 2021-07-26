/*==============================================================*/
/* JOB: CRIAÇÃO DO JOB                                          */
/*==============================================================*/   
BEGIN
DBMS_SCHEDULER.CREATE_JOB (
     job_name      => 'JOB_INATIVAR_USUARIOS',
     job_type      => 'STORED_PROCEDURE',
     job_action    => 'PKG_USUARIO_SISTEMA.PRC_INATIVAR_USUARIO',
     START_DATE    => SYSDATE,
     REPEAT_INTERVAL => 'FREQ=DAILY;INTERVAL=1',
     enabled       => TRUE,
     comments      => 'Inativar os usuários que estão com mais de 60 dias sem se autenticar na aplicação.');
END;
/