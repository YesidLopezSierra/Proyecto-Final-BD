CREATE OR REPLACE PACKAGE pkCategoria AS
  PROCEDURE pInsertar(
      ivID CATEGORIAS.ID%TYPE,
      ivNombre CATEGORIAS.NOMBRE%TYPE,
      ivDescripcion CATEGORIAS.DESCRIPCION%TYPE,
      ivPadreID CATEGORIAS.CATEGORIAS_ID%TYPE,
      ivPeso CATEGORIAS.PESO%TYPE); --El peso es la Prioridad!!
  PROCEDURE pEliminar(ivID CATEGORIAS.ID%TYPE);
  PROCEDURE pModificar(ivFILA CATEGORIAS%ROWTYPE);
  FUNCTION fDarPeso(ivIDCategoria CATEGORIAS.ID%TYPE) RETURN CATEGORIAS.PESO%TYPE;
  FUNCTION fConsultar(ivIDCat CATEGORIAS.ID%TYPE) RETURN SYS_REFCURSOR;
END pkCategoria;
/
CREATE OR REPLACE PACKAGE BODY pkCategoria AS
  PROCEDURE pInsertar(
      ivID CATEGORIAS.ID%TYPE,
      ivNombre CATEGORIAS.NOMBRE%TYPE,
      ivDescripcion CATEGORIAS.DESCRIPCION%TYPE,
      ivPadreID CATEGORIAS.CATEGORIAS_ID%TYPE,
      ivPeso CATEGORIAS.PESO%TYPE)
  IS
  BEGIN
  if ivPadreID=0 then
    INSERT INTO CATEGORIAS VALUES
      (
        ivID,
        ivNombre,
        ivDescripcion,
        NUll,
        ivPeso
      );
      else
INSERT INTO CATEGORIAS VALUES
      (
        ivID,
        ivNombre,
        ivDescripcion,
        ivPadreID,
        ivPeso
      );
      end if;
  EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    RAISE_APPLICATION_ERROR(-20101, 'La categoria que intenta ingresar ya existe');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20102, 'Se genero una excepcion inesperada en el procedimiento pInsertar del pkCategoria ');
  END pInsertar;
  
    PROCEDURE pEliminar(
      ivID CATEGORIAS.ID%TYPE )
  IS
    VTEMP CATEGORIAS.ID%TYPE;
  BEGIN
    SELECT ID INTO VTEMP FROM CATEGORIAS WHERE ivID = ID;
    DELETE FROM CATEGORIAS WHERE CATEGORIAS.ID = ivID;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20103, 'La categoria que desea Eliminar no existe');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20104, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkCategoriasNivel1');
  END pEliminar;
  
  PROCEDURE pModificar(ivFILA CATEGORIAS%ROWTYPE)
  IS
  BEGIN
    UPDATE CATEGORIAS
    SET ID   = ivFILA.ID ,
      NOMBRE          = ivFILA.NOMBRE,
      PESO       = ivFILA.PESO,
      DESCRIPCION     = ivFILA.DESCRIPCION,
      CATEGORIAS_ID           = ivFILA.CATEGORIAS_ID
    WHERE ID          = ivFILA.ID;
    IF ivFILA.NOMBRE IS NULL THEN
      RAISE_APPLICATION_ERROR (-20606, 'El parametro NOMBRE de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
    IF ivFILA.PESO IS NULL THEN
      RAISE_APPLICATION_ERROR (-20607, 'El parametro PRIORIDAD de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
    IF ivFILA.DESCRIPCION IS NULL THEN
      RAISE_APPLICATION_ERROR (-20609, 'El parametro DESCRIPCION de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
    IF ivFILA.CATEGORIAS_ID IS NULL THEN
      RAISE_APPLICATION_ERROR (-20610, 'El parametro IDCATEGORIAPADRE de la fila es nulo. Error en el procedimiento pModificar nivel 1.');
    END IF;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20605, 'No se encontro una categoria con el ID: ' || ivFILA.ID ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 1.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20616,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 1.' || SQLERRM);
  END pModificar;
  
  FUNCTION fDarPeso(ivIDCategoria CATEGORIAS.ID%TYPE) RETURN CATEGORIAS.PESO%TYPE 
  IS
  Peso CATEGORIAS.PESO%TYPE;
  BEGIN
    SELECT cat.PESO INTO Peso FROM CATEGORIAS cat WHERE ID = ivIDCategoria;
    RETURN Peso;
      EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20601, 'No se encontro una Categoria con el ID: ' || ivIDCategoria ||'. Error en la funcion fDarPeso nivel 1.');
  WHEN TOO_MANY_ROWS THEN
    RAISE_APPLICATION_ERROR(-20602, 'La consulta por el ID: ' || ivIDCategoria || 'ha arrojado mas de un registro. Error en la funcion fDarPeso nivel 1.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20604, 'Ha occurrido un error inesperado en la funcion fDarPeso nivel 1.' || SQLERRM);
  END fDarPeso;
  
  FUNCTION fConsultar(
      ivIDCat CATEGORIAS.ID%TYPE)
    RETURN SYS_REFCURSOR
  IS
    cuCategoria  sys_refcursor;
  BEGIN
    open cuCategoria for SELECT *  FROM CATEGORIAS WHERE ID = ivIDCat;
    RETURN cuCategoria;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20601, 'No se encontro una Categoria con el ID: ' || ivIDCat ||'. Error en la funcion fConsultar nivel 1.');
  WHEN TOO_MANY_ROWS THEN
    RAISE_APPLICATION_ERROR(-20602, 'La consulta por el ID: ' || ivIDCat || 'ha arrojado mas de un registro. Error en la funcion fConsultar nivel 1.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20604, 'Ha occurrido un error inesperado en la funcion fConsultar nivel 1.' || SQLERRM);
  END fConsultar;
END pkCategoria;
/
