CREATE OR REPLACE PACKAGE pkRegistroNivel3
AS
  PROCEDURE pInsertarActividad(
      ivPrioridad ACTIVIDADES.PRIORIDAD%TYPE,
      ivFechaInicio ACTIVIDADES.FECHA_INICIO%TYPE,
      ivFechaFin ACTIVIDADES.FECHA_FIN%TYPE,
      ivDescripcion ACTIVIDADES.DESCRIPCION%TYPE,
      ivNombre ACTIVIDADES.NOMBRE%TYPE,
      ivTemporalidad ACTIVIDADES.TEMPORALIDAD%TYPE,
      ivCantidadRepeticiones ACTIVIDADES.CANTIDADREPETICIONES%TYPE,
      ivProyectoId ACTIVIDADES.PROYECTOS_ID%TYPE,
      ivEstadoConsecutivo ACTIVIDADES.ESTADOS_CONSECUTIVO%TYPE,
      ivCategoriaId ACTIVIDADES.CATEGORIAS_ID%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2 );
  PROCEDURE pInsertarCategoria(
      ivNombre CATEGORIAS.NOMBRE%TYPE,
      ivPrioridad CATEGORIAS.PESO%TYPE,
      ivDescripcion CATEGORIAS.DESCRIPCION%TYPE,
      ivPadreId CATEGORIAS.CATEGORIAS_ID%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2);
  PROCEDURE pInsertarDependenciasAct(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2);
  PROCEDURE pInsertarEstados(
      ivNombre ESTADOS.nombre%type,
      ivDescripcion ESTADOS.descripcion%type,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2);
  PROCEDURE pInsertarGerente(
      ivNombre GERENTES.NOMBRE%TYPE,
      ivTelefono Gerentes.TELEFONO%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2);
  PROCEDURE pInsertarProyecto(
      ivNombre IN PROYECTOS.NOMBRE%TYPE,
      ivFechaInicio PROYECTOS.Fecha_Inicio%TYPE,
      ivFechaFin PROYECTOS.Fecha_Fin%TYPE,
      ivGerenteId PROYECTOS.Gerentes_Id%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2);
END pkRegistroNivel3;
/
CREATE OR REPLACE PACKAGE body pkRegistroNivel3
IS
  PROCEDURE pInsertarActividad(
      ivPrioridad ACTIVIDADES.PRIORIDAD%TYPE,
      ivFechaInicio ACTIVIDADES.FECHA_INICIO%TYPE,
      ivFechaFin ACTIVIDADES.FECHA_FIN%TYPE,
      ivDescripcion ACTIVIDADES.DESCRIPCION%TYPE,
      ivNombre ACTIVIDADES.NOMBRE%TYPE,
      ivTemporalidad ACTIVIDADES.TEMPORALIDAD%TYPE,
      ivCantidadRepeticiones ACTIVIDADES.CANTIDADREPETICIONES%TYPE,
      ivProyectoId ACTIVIDADES.PROYECTOS_ID%TYPE,
      ivEstadoConsecutivo ACTIVIDADES.ESTADOS_CONSECUTIVO%TYPE,
      ivCategoriaId ACTIVIDADES.CATEGORIAS_ID%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkRegistroNivel2.pCrearActividad(ivPrioridad, ivFechaInicio, ivFechaFin, ivDescripcion,ivNombre, ivTemporalidad, ivCantidadRepeticiones, ivProyectoId,ivEstadoConsecutivo, ivCategoriaId);
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarActividad;
  PROCEDURE pInsertarCategoria(
      ivNombre CATEGORIAS.NOMBRE%TYPE,
      ivPrioridad CATEGORIAS.PESO%TYPE,
      ivDescripcion CATEGORIAS.DESCRIPCION%TYPE,
      ivPadreId CATEGORIAS.CATEGORIAS_ID%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2)
  IS
  BEGIN
    pkRegistroNivel2.pCrearCategoria( ivNombre, ivDescripcion ,ivPadreId, ivPrioridad);
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarCategoria;
  PROCEDURE pInsertarDependenciasAct(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2)
  IS
  BEGIN
    pkRegistroNivel2.pCrearDependenciasActs(ivActRequisito, ivActDependiente);
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarDependenciasAct;
  PROCEDURE pInsertarEstados(
      ivNombre ESTADOS.nombre%type,
      ivDescripcion ESTADOS.descripcion%type,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2)
  IS
  BEGIN
    pkRegistroNivel2.pCrearestados( ivNombre, ivDescripcion);
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarEstados;
  PROCEDURE pInsertarGerente(
      ivNombre GERENTES.NOMBRE%TYPE,
      ivTelefono Gerentes.TELEFONO%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2)
  IS
  BEGIN
    pkRegistroNivel2.pCrearGerente( ivNombre, ivTelefono);
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarGerente;
  PROCEDURE pInsertarProyecto(
      ivNombre IN PROYECTOS.NOMBRE%TYPE,
      ivFechaInicio PROYECTOS.Fecha_Inicio%TYPE,
      ivFechaFin PROYECTOS.Fecha_Fin%TYPE,
      ivGerenteId PROYECTOS.Gerentes_Id%TYPE,
      ivCodigoMensajeError OUT NUMBER,
      ivMensajeError OUT VARCHAR2)
  IS
  BEGIN
    pkRegistroNivel2.pCrearProyecto(ivNombre, ivFechaInicio , ivFechaFin, ivGerenteId );
    ivCodigoMensajeError :=0;
  EXCEPTION
  WHEN OTHERS THEN
    ivCodigoMensajeError :=1;
    ivMensajeError       := SQLERRM;
  END pInsertarProyecto;
END pkRegistroNivel3;
