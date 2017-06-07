CREATE OR REPLACE PACKAGE pkConsultaNivel2
AS
  FUNCTION fActividadMayorPrioridad(
      ivId IN Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarProyecto(
      ivId PROYECTOS.ID%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarCategoria(
      ivIdCat CATEGORIAS.ID%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarActividad(
      ivIdProyecto Proyectos.Id%TYPE,
      ivIdActividad Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarDependencias(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarEstados(
      ivConsecutivo ESTADOS.CONSECUTIVO%type)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsultarGerente(
      ivId Gerentes.Id%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsActividadCategoria(
      ivIdCategoria Actividades.Categorias_Id%TYPE)
    RETURN VARCHAR2;
    Function fConsultarCategoriasHijas(
      ivIdCategoria Categorias.Categorias_Id%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsActividadFechaInicio(
      ivFecha Actividades.Fecha_Inicio%TYPE)
    RETURN VARCHAR2;
  FUNCTION fConsActividadFechaFin(
      ivFecha Actividades.Fecha_Fin%TYPE)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesPrioridad(
      ivPrioridad Actividades.Prioridad%TYPE)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesEstado(
      ivEstado Actividades.Estados_Consecutivo%TYPE)
    RETURN VARCHAR2;
  FUNCTION fConsActividadesId(
      ivId Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR;
  FUNCTION fConsActPendientes
    RETURN VARCHAR2;
  FUNCTION fConsActNoPendientes
    RETURN VARCHAR2;
  FUNCTION fDarGerentes
    RETURN SYS_REFCURSOR;
    FUNCTION fDarProyectos
    RETURN SYS_REFCURSOR;
    FUNCTION fDarActividades(idProyecto in Actividades.PROYECTOS_ID%type)
    RETURN SYS_REFCURSOR;
    FUNCTION fDarEstados
    RETURN SYS_REFCURSOR;
    FUNCTION fDarCategorias
    RETURN SYS_REFCURSOR;
    FUNCTION fDarDependenciasActs
    RETURN SYS_REFCURSOR;
END pkConsultaNivel2;
/
CREATE OR REPLACE PACKAGE BODY pkConsultaNivel2
AS
  FUNCTION fActividadMayorPrioridad(
      ivId IN Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR
  IS
    cuActividadesMasAltas SYS_REFCURSOR;
  BEGIN
    
    OPEN cuActividadesMasAltas FOR SELECT * FROM Actividades AC WHERE AC.Proyectos_Id = IVId AND AC.Prioridad =
    (SELECT MAX(AC2.Prioridad) FROM Actividades AC2 WHERE AC2.Proyectos_Id = IVId );
    RETURN cuActividadesMasAltas;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001,'No se encontró la actividad especificada. Por favor revise que el proyecto exista y que tenga actividades asociadas.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20002, 'Error inesperado. ' || SQLERRM);
  END fActividadMayorPrioridad;
  FUNCTION fConsultarProyecto(
      ivId PROYECTOS.ID%TYPE)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    IF ivId IS NULL THEN
      RAISE_APPLICATION_ERROR(-20003, 'Para consultar un proyecto el id no puede ser vacio');
    END IF;
    RETURN pkProyectos.fConsultar(ivId);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004, 'El proyecto con el id ' || ivId || ' no se encuentra');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarProyecto;
  FUNCTION fConsultarCategoria(
      ivIdCat CATEGORIAS.ID%TYPE)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    IF ivIdCat IS NULL THEN
      RAISE_APPLICATION_ERROR(-20005, 'Para consultar una categoría el id no puede ser vacio');
    END IF;
    RETURN pkCategoria.fConsultar(ivIdCat);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20006, 'La categoría con el id ' || ivIdCat || ' no se encuentra');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarCategoria;
  FUNCTION fConsultarActividad(
      ivIdProyecto Proyectos.Id%TYPE,
      ivIdActividad Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR
  IS
    cuActividad sys_refcursor;
  BEGIN
    IF ivIdProyecto IS NULL OR ivIdActividad IS NULL THEN
      RAISE_APPLICATION_ERROR(-20020, 'Para consultar actividades el Id no pueden ser vacío');
    END IF;
    OPEN cuActividad FOR SELECT * FROM Actividades WHERE ivIdProyecto = Actividades.Proyectos_Id AND ivIdActividad = Actividades.Id;
    RETURN cuActividad;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20007, 'No se encontró la actividad especificada. Por favor revise que el proyecto exista y que tenga actividades asociadas');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarActividad;
  FUNCTION fConsultarDependencias(
      ivActRequisito DEPENDENCIASACTS.ActividadRequisitoId%TYPE,
      ivActDependiente DEPENDENCIASACTS.ActividadDependienteId%TYPE)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    RETURN pkDependenciaAct.fConsultar(ivActRequisito, ivActDependiente);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20009, 'No se encontraron dependencias');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarDependencias;
  FUNCTION fConsultarEstados(
      ivConsecutivo ESTADOS.CONSECUTIVO%type)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    IF ivConsecutivo IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Para consultar el estado de una actividad las entradas no pueden ser vacias');
    END IF;
    RETURN pkEstados.fConsultar(ivConsecutivo);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20011, 'No se encontró el consecutivo ' || ivConsecutivo);
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarEstados;
  FUNCTION fConsultarGerente(
      ivId Gerentes.Id%TYPE)
    RETURN SYS_REFCURSOR
  IS
  BEGIN
    IF ivId IS NULL THEN
      RAISE_APPLICATION_ERROR(-20012, 'Para consultar un gerente el Id no pueden ser vacío');
    END IF;
    RETURN pkGerentes.fConsultar(ivId);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20013, 'No se encontró el gerente con el Id ' || ivId);
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsultarGerente;
  FUNCTION fConsActividadCategoria(
      ivIdCategoria Actividades.Categorias_Id%TYPE)
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id FROM Actividades WHERE ivIdCategoria = Actividades.Id
      );
  BEGIN
    IF ivIdCategoria IS NULL THEN
      RAISE_APPLICATION_ERROR(-20040, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20014, 'No se encontraron actividades con la categoria especificada');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadCategoria;
  FUNCTION fConsActividadFechaInicio(
      ivFecha Actividades.Fecha_Inicio%TYPE)
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE ivFecha = Actividades.Fecha_Inicio
      );
  BEGIN
    IF ivFecha IS NULL THEN
      RAISE_APPLICATION_ERROR(-20033, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20015, 'No se encontraron actividades con la fecha de inicio especificada.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadFechaInicio;
  FUNCTION fConsActividadFechaFin(
      ivFecha Actividades.Fecha_Fin%TYPE)
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE ivFecha = Actividades.Fecha_Fin
      );
  BEGIN
    IF ivFecha IS NULL THEN
      RAISE_APPLICATION_ERROR(-20055, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20016, 'No se encontraron actividades con la fecha de fin especificada');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadFechaFin;
  FUNCTION fConsActividadesPrioridad(
      ivPrioridad Actividades.Prioridad%TYPE)
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE ivPrioridad = Actividades.Prioridad
      );
  BEGIN
    IF ivPrioridad IS NULL THEN
      RAISE_APPLICATION_ERROR(-20050, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20017, 'No se encontraron actividades con la prioridad especificada');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadesPrioridad;
  FUNCTION fConsActividadesEstado(
      ivEstado Actividades.Estados_Consecutivo%TYPE)
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE ivEstado = Actividades.Estados_Consecutivo
      );
  BEGIN
    IF ivEstado IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20018, 'No se encontraron actividades con estado especificado');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadesEstado;
  FUNCTION fConsActividadesId(
      ivId Actividades.Id%TYPE)
    RETURN SYS_REFCURSOR
  IS
    cuActividad SYS_REFCURSOR;
  BEGIN
    IF ivId IS NULL THEN
      RAISE_APPLICATION_ERROR(-20010, 'Para consultar una actividad las entradas no pueden ser vacias');
    END IF;
    OPEN cuActividad FOR SELECT * FROM Actividades WHERE ivId = Actividades.Id;
    RETURN cuActividad;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20007, 'La actividad con el id ' || ivId || ' no exite.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActividadesId;
  FUNCTION fConsActPendientes
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE Actividades.Estados_Consecutivo = 1043
      );
  BEGIN
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20018, 'No se encontraron actividades pendientes');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActPendientes;
  FUNCTION fConsActNoPendientes
    RETURN VARCHAR2
  IS
    vRespuesta VARCHAR2(1000);
    CURSOR vActividades
    IS
      (SELECT Actividades.Id
      FROM Actividades
      WHERE Actividades.Estados_Consecutivo <> 1043
      );
  BEGIN
    FOR indice IN vActividades
    LOOP
      vRespuesta := vRespuesta || indice.Id || ',';
    END LOOP;
    RETURN vRespuesta;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20018, 'No se encontraron actividades pendientes');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);
  END fConsActNoPendientes;
  FUNCTION fDarGerentes
    RETURN SYS_REFCURSOR
  IS
    cuListadogerentes SYS_REFCURSOR;
  BEGIN
    OPEN cuListadogerentes FOR SELECT * FROM gerentes ;
    RETURN cuListadogerentes;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ningun gerente');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarGerentes;

  FUNCTION fDarProyectos
    RETURN SYS_REFCURSOR
  IS
    cuListadoProyectos SYS_REFCURSOR;
  BEGIN
    OPEN cuListadoProyectos FOR SELECT * FROM proyectos ;
    RETURN cuListadoProyectos;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ningun Proyecto');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarProyectos;
FUNCTION fDarActividades(idProyecto in Actividades.PROYECTOS_ID%type)
    RETURN SYS_REFCURSOR
  IS
    cuListadoActividades SYS_REFCURSOR;
  BEGIN
  if idProyecto = 0 then
        OPEN cuListadoActividades FOR SELECT * FROM Actividades;

  else 
    OPEN cuListadoActividades FOR SELECT * FROM Actividades where PROYECTOS_ID= NVL(idProyecto,PROYECTOS_ID);
    end if;
    RETURN cuListadoActividades;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ninguna ACTIVIDAD');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarActividades;
  FUNCTION fDarCategorias
    RETURN SYS_REFCURSOR
  IS
    cuListadoCategorias SYS_REFCURSOR;
  BEGIN
    OPEN cuListadoCategorias FOR SELECT * FROM Categorias ;
    RETURN cuListadoCategorias;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ninguna CATEGORÍA');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarCategorias;
  FUNCTION fDarEstados
    RETURN SYS_REFCURSOR
  IS
    cuListadoEstados SYS_REFCURSOR;
  BEGIN
    OPEN cuListadoEstados FOR SELECT * FROM Estados ;
    RETURN cuListadoEstados;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ninguna ESTADO');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarEstados;

    FUNCTION fDarDependenciasActs
    RETURN SYS_REFCURSOR
  IS
    culistadoDependenciasActs SYS_REFCURSOR;
  BEGIN
    OPEN culistadoDependenciasActs FOR SELECT * FROM DEPENDENCIASACTS ;
    RETURN culistadoDependenciasActs;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ninguna Dependencia de actividades');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
  END fDarDependenciasActs;


  FUNCTION fConsultarCategoriasHijas(
      ivIdCategoria Categorias.Categorias_Id%TYPE)
    RETURN SYS_REFCURSOR is 
    cuCategoriasHijas sys_refcursor;
    begin 
    open cuCategoriasHijas for SELECT * from Categorias where Categorias_Id=ivIdCategoria;
    RETURN cuCategoriasHijas;
    end fConsultarCategoriasHijas;

END pkConsultaNivel2;
/