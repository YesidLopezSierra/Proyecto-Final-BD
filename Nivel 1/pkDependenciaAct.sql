CREATE OR REPLACE PACKAGE pkDependenciaAct
AS
  PROCEDURE pAgregar(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE);
  PROCEDURE pEliminar(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE);
  FUNCTION fConsultar(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE)
    RETURN SYS_REFCURSOR;
END pkDependenciaAct;
/
CREATE OR REPLACE PACKAGE BODY pkDependenciaAct AS
  PROCEDURE pAgregar(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE)
  IS
  BEGIN
    INSERT INTO DEPENDENCIASACTS VALUES
      (ivActRequisito, ivActDependiente
      );
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    raise_application_error(-20501, 'Error al insertar Dependencias de actividad. Ya existe una dependencia con esas IDs'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20502, 'Se generó una excepcion inesperada en el procedimiento pAgregar del        
paquete pkDependenciaAct.'||SQLERRM);
  END pAgregar;
  PROCEDURE pEliminar
    (
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE
    )
  IS
  BEGIN
 
    DELETE DEPENDENCIASACTS
    WHERE ACTIVIDADDEPENDIENTEID = ivActDependiente
    AND ACTIVIDADREQUISITOID     = ivActRequisito;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20503, 'Error al eliminar Dependencias de actividas. no existe una dependencia con esas IDs'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20504, 'Se generó una excepcion inesperada en el procedimiento pEliminar del        
paquete pkDependenciaAct.'||SQLERRM);
  END pEliminar;
  FUNCTION fConsultar(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE)
    RETURN SYS_REFCURSOR
  IS
    cuRetorno sys_refcursor; 
  BEGIN
    open cuRetorno for SELECT d.*
    FROM DEPENDENCIASACTS d
    WHERE d.ACTIVIDADDEPENDIENTEID = NVL(ivActDependiente,d.ACTIVIDADDEPENDIENTEID)
    AND d.ACTIVIDADREQUISITOID     = NVL(ivActRequisito,d.ACTIVIDADREQUISITOID);
    RETURN curetorno;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20505, 'Error al consultar Dependencias de actividas. no existe una dependencia con esas IDs'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20506, 'Se generó una excepcion inesperada en la funcion fConsultar del      
paquete pkDependenciaAct.'||SQLERRM);
  END fConsultar;
END pkDependenciaAct;
/