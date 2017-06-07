CREATE OR REPLACE PACKAGE pkConsultaNivel3
IS
  --• El GP  también  puede  realizar la  consulta  de actividades  por  diferentes  criterios,  como categoría,  fecha  programada,  prioridad  y  estado  (puede  visualizar  actividades pendientes y no pendientes).
  --• El resultado de este tipo de consulta, será un informe mostrando la lista de actividades de acuerdo con el criterio dado.
  --• El  GP  podrá  indicar  cuáles  son  los  campos  de la  consulta  que  desea  visualizar  en  el informe
  FUNCTION fActividadMayorPrioridad(
      ivId IN Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarProyecto(
      ivId PROYECTOS.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarActividad(
      ivIdProyecto Proyectos.Id%TYPE,
      ivIdActividad Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarCategoria(
      ivIdCat CATEGORIAS.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN  SYS_REFCURSOR;
  FUNCTION fConsultarDependencias(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarEstados(
      ivConsecutivo ESTADOS.CONSECUTIVO%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarGerente(
      ivId Gerentes.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsActividadCategoria(
      ivIdCategoria Actividades.Categorias_Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActividadFechaInicio(
      ivFecha Actividades.Fecha_Inicio%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActividadFechaFin(
      ivFecha Actividades.Fecha_Fin%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesPrioridad(
      ivPrioridad Actividades.Prioridad%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesEstado(
      ivEstado Actividades.Estados_Consecutivo%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesId(
      ivId Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsActPendientes(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
  FUNCTION fConsActNoPendientes(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2;
    FUNCTION fDarGerentes(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    FUNCTION fDarProyectos(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    FUNCTION fDarActividades(idProyecto in Actividades.PROYECTOS_ID%type, ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    --IMPLEMENTAR
    FUNCTION fDarEstados(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    FUNCTION fDarCategorias(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    FUNCTION fDarDependenciasActs(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
    FUNCTION fConsultarCategoriasHijas(
      ivIdCategoria Actividades.Categorias_Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR;
END pkConsultaNivel3;
/
CREATE OR REPLACE PACKAGE body pkConsultaNivel3
AS
  FUNCTION fActividadMayorPrioridad(
      ivId IN Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fActividadMayorPrioridad(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fActividadMayorPrioridad;

 FUNCTION fConsultarCategoriasHijas(
      ivIdCategoria Actividades.Categorias_Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsultarCategoriasHijas(ivIdCategoria);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarCategoriasHijas;


  FUNCTION fConsultarProyecto(
      ivId PROYECTOS.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    --busco en los proyectos
    RETURN pkConsultaNivel2.fConsultarProyecto(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarProyecto;
  FUNCTION fConsultarActividad(
      ivIdProyecto Proyectos.Id%TYPE,
      ivIdActividad Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsultarActividad(ivIdProyecto,ivIdActividad) ;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarActividad;
  FUNCTION fConsultarCategoria(
      ivIdCat CATEGORIAS.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsultarCategoria(ivIdCat);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarCategoria;
  FUNCTION fConsultarDependencias(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
    vActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE;
    vActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE;
  BEGIN
    ovCodigoMensajeError :=0;
    
    vActRequisito:=ivActRequisito;
    vActDependiente:=ivActDependiente;
    if ivActRequisito=0 then 
    vActRequisito:=null;
    end if;
    if ivActDependiente=0 then 
    vActDependiente:=null;
    end if;
    RETURN pkConsultaNivel2.fConsultarDependencias(vActRequisito,vActDependiente);

  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarDependencias;
  FUNCTION fConsultarEstados(
      ivConsecutivo ESTADOS.CONSECUTIVO%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsultarEstados(ivConsecutivo);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarEstados;
  FUNCTION fConsultarGerente(
      ivId Gerentes.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsultarGerente(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsultarGerente;
  FUNCTION fConsActividadCategoria(
      ivIdCategoria Actividades.Categorias_Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadCategoria(ivIdCategoria);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadCategoria;
  FUNCTION fConsActividadFechaInicio(
      ivFecha Actividades.Fecha_Inicio%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadFechaInicio(ivFecha);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadFechaInicio;
  FUNCTION fConsActividadFechaFin(
      ivFecha Actividades.Fecha_Fin%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadFechaFin(ivFecha);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadFechaFin;
  FUNCTION fConsActividadesPrioridad(
      ivPrioridad Actividades.Prioridad%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadesPrioridad(ivPrioridad);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadesPrioridad;
  FUNCTION fConsActividadesEstado(
      ivEstado Actividades.Estados_Consecutivo%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadesEstado(ivEstado);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadesEstado;
  FUNCTION fConsActividadesId(
      ivId Actividades.Id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActividadesId(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActividadesId;
  FUNCTION fConsActPendientes(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActPendientes;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActPendientes;
  FUNCTION fConsActNoPendientes(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN VARCHAR2
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fConsActNoPendientes;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fConsActNoPendientes;
  
   FUNCTION fDarGerentes(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarGerentes;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarGerentes;
  
   FUNCTION fDarProyectos(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarProyectos;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarProyectos;
  
  FUNCTION fDarActividades(idProyecto in Actividades.PROYECTOS_ID%type,ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarActividades(idProyecto);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarActividades;

  FUNCTION fDarEstados(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarEstados;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarEstados;

  FUNCTION fDarCategorias(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarCategorias;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarCategorias;

  FUNCTION fDarDependenciasActs(ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkConsultaNivel2.fDarDependenciasActs;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarDependenciasActs;
--FUNCTION fFiltrarActividadesPorProyecto(ivIdProyecto Proyectos.Id%TYPE, fFechaVencimiento Proyecto.Fecha_Inicio%TYPE, ivDescripcion Actividades.Descripcion%TYPE, ivPrioridad Actividades.Prioridades%TYPE, ivIdActividad Actividades.Id%TYPE) RETURN VARCHAR2
--is begin
--return pkConsultaNivel2.fFiltrarActividadesPorProyecto(ivIdProyecto,fFechaVencimiento,ivDescripcion,ivPrioridad,ivIdActividad);
--EXCEPTION WHEN OTHERS THEN
--    ovCodigoMensajeError :=1;
--   ovMensajeError       := SQLERRM;
--end fFiltrarActividadesPorProyecto;
END pkConsultaNivel3;
