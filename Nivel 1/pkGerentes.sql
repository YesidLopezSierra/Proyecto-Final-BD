CREATE OR REPLACE PACKAGE pkGerentes
AS
  FUNCTION fValidarGerente(
      ivID Gerentes.Id%TYPE)
    RETURN NUMBER;
  PROCEDURE pInsertar(
      ivID Gerentes.Id%TYPE,
      ivNombre GERENTES.NOMBRE%TYPE,
      ivTelefono Gerentes.TELEFONO%TYPE);
  PROCEDURE pEliminar(
      ivID Gerentes.Id%TYPE);
  PROCEDURE pModificar(
      ivFILA GERENTES%ROWTYPE);
  FUNCTION fConsultar(
      ivID Gerentes.Id%TYPE)
    RETURN SYS_REFCURSOR;
END pkGerentes;
/
CREATE OR REPLACE PACKAGE BODY pkGerentes
AS
  FUNCTION fValidarGerente(
      ivID Gerentes.Id%TYPE)
    RETURN NUMBER
  IS
    vID GERENTES.ID%TYPE;
  BEGIN
    SELECT ger.ID INTO vID FROM Gerentes ger WHERE ger.ID = ivID;
    RETURN 1;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
  END fValidarGerente;
  PROCEDURE pInsertar(
      ivID Gerentes.Id%TYPE,
      ivNombre Gerentes.Nombre%TYPE,
      ivTelefono Gerentes.Telefono%TYPE)
  IS
    existeGerente NUMBER;
  BEGIN
    existeGerente   := fValidarGerente(ivID);
    IF existeGerente = 0 THEN
      INSERT INTO GERENTES VALUES (ivID,ivNombre,ivTelefono);
      ELSE
      RAISE_APPLICATION_ERROR(-20400,'El cliente con id'|| ivID ||'ya existe en la base de datos');
    END IF;
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20401,'El cliente con id'|| ivID ||'ya ha sido agregado anteriormente en la base de datos');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20402,'Ha ocurrido un error inesperado en el paquete de nivel 1 de la tabla gerente en el procedimiento de agregar gerente');
  END pInsertar;
  PROCEDURE pModificar
    (
      ivFILA GERENTES%ROWTYPE
    )
  IS
  BEGIN
    UPDATE GERENTES
    SET
      ID = ivFILA.ID,
      NOMBRE = ivFILA.NOMBRE,
      TELEFONO = ivFILA.TELEFONO
    WHERE ID   = ivFILA.ID ;
    IF ivFILA.NOMBRE IS NULL THEN RAISE_APPLICATION_ERROR (-20606, 'El parametro NOMBRE de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
  END IF;
IF ivFILA.TELEFONO IS NULL THEN
  RAISE_APPLICATION_ERROR (-20607, 'El parametro TELEFONO de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
END IF;
EXCEPTION
WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20605, 'No se encontro un Gerente con el ID: ' || ivFILA.ID ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 1.');
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20616,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 1.' || SQLERRM);
END pModificar;
PROCEDURE pEliminar(
    ivID Gerentes.Id%TYPE)
IS
  existeGerente Gerentes.Id%TYPE;
BEGIN
  existeGerente   := fValidarGerente(ivID);
  IF existeGerente = 1 THEN
    DELETE FROM Gerentes ger WHERE ger.ID = ivID;
  ELSE
    RAISE_APPLICATION_ERROR(-20403,'El cliente con id'|| ivID ||'no existe en la base de datos');
  END IF;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20404,'Ha ocurrido un error inesperado en el paquete de nivel 1 de la tabla gerente en el procedimiento de eliminar gerente');
END pEliminar;
FUNCTION fConsultar(
    ivID Gerentes.Id%TYPE)
  RETURN SYS_REFCURSOR
IS
  existeGerente NUMBER;
  cuGerente sys_refcursor; 
BEGIN
 open cuGerente for     SELECT *  FROM Gerentes ger WHERE ger.ID = ivID;
  existeGerente   := fValidarGerente(ivID);
  IF existeGerente = 0 THEN
    RAISE_APPLICATION_ERROR(-20409,'El cliente con id'|| ivID ||'no existe en la base de datos');
  END IF;
  RETURN cuGerente;
EXCEPTION
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20410,'Ha ocurrido un error inesperado en el paquete de nivel 1 de la tabla gerente en la funcion consultar gerente');
END fConsultar;
END pkGerentes;
/