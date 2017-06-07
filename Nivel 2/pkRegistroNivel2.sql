CREATE OR REPLACE PACKAGE pkRegistroNivel2 AS
   PROCEDURE pCrearGerente(ivNombreGerente IN Gerentes.Nombre%TYPE, ivTelefonoGerente IN Gerentes.Telefono%TYPE);
   PROCEDURE pCrearProyecto(ivNombre IN PROYECTOS.NOMBRE%TYPE,ivFechaInicio IN PROYECTOS.FECHA_INICIO%TYPE, ivFechaFin IN PROYECTOS.FECHA_FIN%TYPE, ivGerentes_Id IN PROYECTOS.GERENTES_ID%TYPE);
   PROCEDURE pCrearEstados(ivNombreEstado IN ESTADOS.NOMBRE%TYPE, ivDescripcion IN ESTADOS.DESCRIPCION%TYPE);
   --El siguiente procedimiento solo sirve para funcionamiento interno.
   PROCEDURE pCrearDependenciasActs(ivActividadRequisito IN DEPENDENCIASACTS.ACTIVIDADREQUISITOID%TYPE, ivActividadDependiente IN DEPENDENCIASACTS.ACTIVIDADDEPENDIENTEID%TYPE);
   PROCEDURE pCrearCategoria(ivNombre IN CATEGORIAS.NOMBRE%TYPE, ivDescripcion IN CATEGORIAS.DESCRIPCION%TYPE, ivCategoriaId IN CATEGORIAS.CATEGORIAS_ID%TYPE, ivPeso IN CATEGORIAS.PESO%TYPE);
   PROCEDURE pCrearActividad(ivPrioridad IN ACTIVIDADES.PRIORIDAD%TYPE,
    ivFechaInicio IN ACTIVIDADES.FECHA_INICIO%TYPE, 
    ivFechaFin IN ACTIVIDADES.FECHA_FIN%TYPE,
    ivDescripcion IN ACTIVIDADES.DESCRIPCION%TYPE,
    ivNombre IN ACTIVIDADES.NOMBRE%TYPE,
    ivTemporalidad IN ACTIVIDADES.TEMPORALIDAD%TYPE,
    ivCantidadRepeticiones IN ACTIVIDADES.CANTIDADREPETICIONES%TYPE,
    ivProyectosID IN ACTIVIDADES.PROYECTOS_ID%TYPE,
    ivEstado IN ACTIVIDADES.ESTADOS_CONSECUTIVO%TYPE,
    ivCategoria IN ACTIVIDADES.CATEGORIAS_ID%TYPE); 
  END pkRegistroNivel2;
/

CREATE OR REPLACE PACKAGE BODY pkRegistroNivel2 AS

  PROCEDURE pCrearGerente(ivNombreGerente IN Gerentes.Nombre%TYPE, ivTelefonoGerente IN Gerentes.Telefono%TYPE) AS
    vsqGerente NUMBER;
    BEGIN
      if ivNombreGerente IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Nombre de Gerente v�lido');

      elsif ivTelefonoGerente IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Tel�fono v�lido');
      else
      SELECT sq_Gerentes.NextVal
      INTO vsqGerente
      FROM dual;
      pkGerentes.pInsertar(vsqGerente, ivNombreGerente, ivTelefonoGerente);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20302, 'Error: ' || SQLERRM);
  END pCrearGerente;      
  
  PROCEDURE pCrearProyecto(ivNombre IN PROYECTOS.NOMBRE%TYPE, ivFechaInicio IN PROYECTOS.FECHA_INICIO%TYPE, ivFechaFin IN PROYECTOS.FECHA_FIN%TYPE, ivGerentes_Id IN PROYECTOS.GERENTES_ID%TYPE) AS
    vsqProyectos NUMBER;
    BEGIN
      if ivNombre IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Nombre para el proyecto v�lido');
      elsif ivFechaInicio IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Fecha de Inicio v�lida');
      elsif ivFechaFin IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Fecha de Fin v�lida');
      elsif ivGerentes_Id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una identificaci�n del Gerente del Proyecto v�lida');
      else
      SELECT sq_Proyectos.NextVal
      INTO vsqProyectos
      FROM dual;
      pkProyectos.pAgregar(vsqProyectos, ivNombre, ivFechaInicio, ivFechaFin, ivGerentes_Id);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20302, 'Error: ' || SQLERRM);
  END pCrearProyecto;   
  
  PROCEDURE pCrearEstados(ivNombreEstado IN ESTADOS.NOMBRE%TYPE, ivDescripcion IN ESTADOS.DESCRIPCION%TYPE) AS
    BEGIN
      if ivNombreEstado IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Nombre de Estado v�lido');
      elsif ivDescripcion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Descripci�n v�lida');
      else
      pkEstados.pInsertar(ivNombreEstado, ivDescripcion);
      end if;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20302, 'Error: ' || SQLERRM);
  END pCrearEstados;
  
  PROCEDURE pCrearDependenciasActs(ivActividadRequisito IN DEPENDENCIASACTS.ACTIVIDADREQUISITOID%TYPE, ivActividadDependiente IN DEPENDENCIASACTS.ACTIVIDADDEPENDIENTEID%TYPE) AS
    BEGIN
      pkDependenciaact.pAgregar(ivActividadRequisito, ivActividadDependiente);
    END pCrearDependenciasActs;
    
  PROCEDURE pCrearCategoria(ivNombre IN CATEGORIAS.NOMBRE%TYPE, ivDescripcion IN CATEGORIAS.DESCRIPCION%TYPE, ivCategoriaId IN CATEGORIAS.CATEGORIAS_ID%TYPE, ivPeso IN CATEGORIAS.PESO%TYPE) AS
    vsqCategoria NUMBER;
    BEGIN
      if ivNombre IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Nombre v�lido para la categor�a');
      elsif ivDescripcion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Descripci�n v�lida');
      elsif ivCategoriaid IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un subCategor�a v�lida');
      elsif ivPeso IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un peso v�lido');
      else
      SELECT sq_Categorias.NextVal
      INTO vsqCategoria
      FROM dual;
      pkCategoria.pInsertar(vsqCategoria, ivNombre, ivDescripcion, ivCategoriaid, ivPeso);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20302, 'Error: ' || SQLERRM);
    END pCrearCategoria;
    
    PROCEDURE pCrearActividad(ivPrioridad IN ACTIVIDADES.PRIORIDAD%TYPE,
    ivFechaInicio IN ACTIVIDADES.FECHA_INICIO%TYPE, 
    ivFechaFin IN ACTIVIDADES.FECHA_FIN%TYPE,
    ivDescripcion IN ACTIVIDADES.DESCRIPCION%TYPE,
    ivNombre IN ACTIVIDADES.NOMBRE%TYPE,
    ivTemporalidad IN ACTIVIDADES.TEMPORALIDAD%TYPE,
    ivCantidadRepeticiones IN ACTIVIDADES.CANTIDADREPETICIONES%TYPE,
    ivProyectosID IN ACTIVIDADES.PROYECTOS_ID%TYPE,
    ivEstado IN ACTIVIDADES.ESTADOS_CONSECUTIVO%TYPE,
    ivCategoria IN ACTIVIDADES.CATEGORIAS_ID%TYPE) AS
    vsqActividad NUMBER;
    vnuevaPrioridad NUMBER;
    BEGIN
      if ivPrioridad IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Prioridad v�lida');
      elsif ivFechaInicio IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Fecha de Inicio v�lida');
      elsif ivFechaFin IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Fecha de Finalizaci�n v�lida');
      elsif ivDescripcion IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Descripci�n v�lida');
      elsif ivNombre IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Nombre v�lido');
      elsif ivTemporalidad IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Temporalidad v�lida');
      elsif ivCantidadRepeticiones IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Cantidad de Repeticiones v�lida');
      elsif ivProyectosId IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Identificaci�n de Proyecto v�lida');
      elsif ivEstado IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese un Estado v�lido');
      elsif ivCategoria IS NULL THEN
        RAISE_APPLICATION_ERROR(-20302, 'Ingrese una Categor�a v�lida');
      else
      SELECT sq_Actividades.NextVal
      INTO vsqActividad
      FROM dual;
      pkActividades.pInsertar(vsqActividad, ivPrioridad, ivFechaInicio, ivFechaFin, ivDescripcion, ivNombre, ivTemporalidad, ivCantidadRepeticiones, ivProyectosId, ivEstado, ivCategoria);
      vnuevaPrioridad := pkClasificacionNivel2.fCalcularPrioridad(vsqActividad);
      pkModificacionNivel2.pmodificaractividad(vsqActividad,vnuevaPrioridad,null,null,null,null,null,null,null,null, null);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20302, 'Error: ' || SQLERRM);
    END pCrearActividad;
END pkRegistroNivel2;
/