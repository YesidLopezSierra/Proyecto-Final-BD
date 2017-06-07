CREATE OR REPLACE PACKAGE pkProyectos AS
  FUNCTION fValidar(ivId PROYECTOS.ID%TYPE) 
  RETURN NUMBER;
  PROCEDURE pAgregar(
      ivId PROYECTOS.ID%TYPE,
      ivNombre PROYECTOS.NOMBRE%TYPE,
      ivFechaInicio PROYECTOS.Fecha_Inicio%TYPE,
      ivFechaFin PROYECTOS.Fecha_Fin%TYPE,
      ivGerenteId PROYECTOS.Gerentes_Id%TYPE);
  PROCEDURE pEliminar(ivId PROYECTOS.ID%TYPE);
  PROCEDURE pModificar(ivFILA PROYECTOS%ROWTYPE);
  FUNCTION fConsultar(ivId PROYECTOS.ID%TYPE) RETURN SYS_REFCURSOR;
END pkProyectos;
/
CREATE OR REPLACE PACKAGE BODY pkProyectos AS
  FUNCTION fValidar(ivID PROYECTOS.ID%TYPE)
    RETURN NUMBER
  IS
    vID PROYECTOS.ID%TYPE;
  BEGIN
    SELECT pro.ID INTO vID FROM Proyectos pro WHERE pro.ID = ivId;
    RETURN 1;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
  END fValidar;

  PROCEDURE pAgregar(
      ivID PROYECTOS.ID%TYPE,
      ivNombre PROYECTOS.NOMBRE%TYPE,
      ivFechaInicio PROYECTOS.Fecha_Inicio%TYPE,
      ivFechaFin PROYECTOS.Fecha_Fin%TYPE,
      ivGerenteId PROYECTOS.Gerentes_Id%TYPE)
  IS
    existeProyecto NUMBER;
  BEGIN
    existeProyecto   := fValidar(ivID);
    IF existeProyecto = 0 THEN
      INSERT INTO Proyectos VALUES
        (ivID,ivNombre,ivFechaInicio,ivFechaFin,ivGerenteId
        );
    ELSE
      RAISE_APPLICATION_ERROR(-20301, 'No se puede agregar un proyecto que ya existe');
    END IF;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20302, 'Hay un error desconocido al agregar el proyecto'|| SQLERRM);
  END pAgregar;


  PROCEDURE pEliminar
    (
      ivID PROYECTOS.ID%TYPE
    )
  IS
    existeProyecto NUMBER;
  BEGIN
    existeProyecto   := fValidar(ivID);
    IF existeProyecto = 1 THEN
      DELETE FROM Proyectos pro WHERE pro.ID = ivID;
    ELSE
      RAISE_APPLICATION_ERROR(-20303, 'No se puede eliminar un proyecto que no existe');
    END IF;
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20304, 'Hay un error desconocido al eliminar el proyecto'|| SQLERRM);
  END pEliminar;
  
  PROCEDURE pModificar(ivFILA PROYECTOS%ROWTYPE)
  IS
  BEGIN
  UPDATE PROYECTOS
  SET
  ID = ivFILA.ID,
  NOMBRE = ivFILA.NOMBRE,
  FECHA_INICIO = ivFILA.FECHA_INICIO,
  FECHA_FIN = ivFILA.FECHA_FIN,
  GERENTES_ID = ivFILA.GERENTES_ID
  WHERE ID = ivFILA.ID;
      IF ivFILA.NOMBRE IS NULL THEN
      RAISE_APPLICATION_ERROR (-20608, 'El parametro NOMBRE de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
      IF ivFILA.FECHA_INICIO IS NULL THEN
      RAISE_APPLICATION_ERROR (-20607, 'El parametro FECHA_INICIO de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
    IF ivFILA.FECHA_FIN IS NULL THEN
      RAISE_APPLICATION_ERROR (-20608, 'El parametro FECHA_FIN de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
        IF ivFILA.GERENTES_ID IS NULL THEN
      RAISE_APPLICATION_ERROR (-20610, 'El parametro GERENTES_ID de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
    EXCEPTION
WHEN NO_DATA_FOUND THEN
  RAISE_APPLICATION_ERROR(-20605, 'No se encontro un Proyecto con el ID: ' || ivFILA.ID ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 1.');
WHEN OTHERS THEN
  RAISE_APPLICATION_ERROR(-20616,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 1.' || SQLERRM);
END pModificar; 
  FUNCTION fConsultar(
      ivID PROYECTOS.ID%TYPE)
    RETURN SYS_REFCURSOR
  IS
  cuProyecto sys_refcursor;
  BEGIN
  open cuProyecto for     SELECT *  FROM Proyectos pro WHERE pro.ID = ivID;
    RETURN cuProyecto;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20311, 'No existe el proyecto consultado');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20312, 'Hay un error desconocido al consultar el proyecto');
  END fConsultar;
END pkProyectos;
/