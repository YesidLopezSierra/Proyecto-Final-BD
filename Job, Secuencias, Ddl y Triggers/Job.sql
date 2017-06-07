BEGIN
  DBMS_SCHEDULER.CREATE_JOB (
   job_name           =>  'Prioridades_Job',
   job_type           =>  'STORED_PROCEDURE',
   job_action         =>  'pkClasificacionNivel2.pRecalcularPrioridades',
   repeat_interval    =>  'FREQ=MINUTELY;INTERVAL=5', /* every other day */
   comments           =>  'My new job');
END;
/
BEGIN
  DBMS_SCHEDULER.RUN_JOB(
    JOB_NAME            => 'Prioridades_Job',
    USE_CURRENT_SESSION => FALSE);
END;
/