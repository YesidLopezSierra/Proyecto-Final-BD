CREATE OR REPLACE PACKAGE pkEstados
AS
  PROCEDURE pInsertar(
      ivNom ESTADOS.nombre%type,
      ivDescrip ESTADOS.descripcion%type);
  PROCEDURE pEliminar(ivCons ESTADOS.CONSECUTIVO%type);
  PROCEDURE pModificar(
      ivConsecutivo ESTADOS.CONSECUTIVO%type,
      ivNombre ESTADOS.NOMBRE%type,
      ivDescripcion ESTADOS.DESCRIPCION%type);
  FUNCTION fConsultar(ivConsecutivo ESTADOS.CONSECUTIVO%type) RETURN sys_refcursor;
END pkEstados;
/
CREATE OR REPLACE PACKAGE BODY pkEstados
IS
  PROCEDURE pInsertar(
      ivNom ESTADOS.nombre%type,
      ivDescrip ESTADOS.descripcion%type)
  IS
    consec NUMBER;
  BEGIN
    SELECT NVL(MAX(consecutivo),0)+1 INTO consec FROM ESTADOS;
    INSERT INTO ESTADOS VALUES
      (consec, ivNom, ivDescrip
      );
  EXCEPTION
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Error al insertar ESTADOS.'||SQLERRM);
  END pInsertar;
  PROCEDURE pEliminar
    (
      ivCons ESTADOS.consecutivo%type
    )
  IS
    vEstado ESTADOS%ROWTYPE;
  BEGIN
    SELECT * INTO vEstado FROM ESTADOS WHERE CONSECUTIVO = ivCons;
    DELETE ESTADOS WHERE CONSECUTIVO = ivCons;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20503, 'Error al eliminar estado. No existe un estado con ese consecutivo'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20504, 'Se gener� una excepcion inesperada en el procedimiento pEliminar del paquete pkEstados.'||SQLERRM);
  END pEliminar;
  PROCEDURE pModificar(
      ivConsecutivo ESTADOS.CONSECUTIVO%type,
      ivNombre ESTADOS.NOMBRE%type,
      ivDescripcion ESTADOS.DESCRIPCION%type)
  IS
    vEstado ESTADOS%ROWTYPE;
  BEGIN
    SELECT * INTO vEstado FROM ESTADOS WHERE CONSECUTIVO = ivConsecutivo;
    UPDATE ESTADOS
    SET Nombre       = ivNombre,
      Descripcion    = ivDescripcion
    WHERE CONSECUTIVO = ivConsecutivo;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20503, 'Error al actualizar estado. No existe un estado con ese consecutivo'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20001, 'Error al actualizar la informacion del estado.'||SQLERRM);
  END pModificar;
  FUNCTION fConsultar(
      ivConsecutivo ESTADOS.CONSECUTIVO%type)
    RETURN SYS_REFCURSOR
  IS
    cuRetorno sys_refcursor; 
  BEGIN
   open cuRetorno for  SELECT e.*  FROM ESTADOS e WHERE e.CONSECUTIVO = ivConsecutivo;
    RETURN curetorno;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    raise_application_error(-20505, 'Error al consultar ESTADOS. No existe un estado con ese consecutivo.'||SQLERRM);
  WHEN OTHERS THEN
    raise_application_error(-20506, 'Se genero una excepcion inesperada en la funcion fConsultar del paquete pkEstados.'||SQLERRM);
  END fConsultar;
END pkEstados;
/