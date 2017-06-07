CREATE OR REPLACE PACKAGE pkmodificacionnivel3
AS --spec
  FUNCTION fbuscaractividades(
      ivfechavencimiento IN actividades.fecha_fin%TYPE,
      ivpartedescripcion IN actividades.descripcion%TYPE,
      ivprioridad        IN actividades.prioridad%TYPE,
      ividentificador    IN actividades.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN SYS_REFCURSOR;
  PROCEDURE pmodificaractividad(
      ivId                   IN actividades.ID%TYPE,
      ivprioridad            IN actividades.prioridad%TYPE,
      ivfechainicio          IN actividades.fecha_inicio%TYPE,
      ivfechafin             IN actividades.fecha_fin%TYPE,
      ivdescripcion          IN actividades.descripcion%TYPE,
      ivnombre               IN actividades.nombre%TYPE,
      ivtemporalidad         IN actividades.temporalidad%TYPE,
      ivcantidadrepeticiones IN actividades.cantidadrepeticiones%TYPE,
      ivproyectoid           IN actividades.proyectos_id%TYPE,
      ivestadoconsecutivo    IN actividades.estados_consecutivo%TYPE,
      ivcategoriaid          IN actividades.categorias_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE pmodificarcategoria(
      ivId          IN categorias.ID%TYPE,
      ivnombre      IN categorias.nombre%TYPE,
      ivprioridad   IN categorias.peso%TYPE,
      ivdescripcion IN categorias.descripcion%TYPE,
      ivpadreid     IN categorias.categorias_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  /*  PROCEDURE pmodificardependenciasact (
  ivactrequisito     dependenciasacts.actividadrequisitoid%TYPE,
  ivactdependiente   dependenciasacts.actividaddependienteid%TYPE
  );*/
  PROCEDURE pmodificarestados(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ivnombre      IN estados.nombre%TYPE,
      ivdescripcion IN estados.descripcion%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE pmodificargerente(
      ivid       IN gerentes.ID%TYPE,
      ivnombre   IN gerentes.nombre%TYPE,
      ivtelefono IN gerentes.telefono%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE pmodificarproyecto(
      ivid          IN proyectos.ID%TYPE,
      ivNombre      IN PROYECTOS.NOMBRE%TYPE,
      ivfechainicio IN proyectos.fecha_inicio%TYPE,
      ivfechafin    IN proyectos.fecha_fin%TYPE,
      ivgerenteid   IN proyectos.gerentes_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminaractividad(
      ividactividad IN actividades.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminarcategoria(
      ivid IN categorias.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminardependenciasacts(
      ivactrequisito   IN dependenciasacts.actividadrequisitoid%TYPE,
      ivactdependiente IN dependenciasacts.actividaddependienteid%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminarestado(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminargerente(
      ivid IN gerentes.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE peliminarproyecto(
      ivid IN proyectos.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
END pkmodificacionnivel3;
/
CREATE OR REPLACE PACKAGE BODY pkmodificacionnivel3
AS --body
  FUNCTION fbuscaractividades(
      ivfechavencimiento IN actividades.fecha_fin%TYPE,
      ivpartedescripcion IN actividades.descripcion%TYPE,
      ivprioridad        IN actividades.prioridad%TYPE,
      ividentificador    IN actividades.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN SYS_REFCURSOR
  IS
    listadoactividades SYS_REFCURSOR;
  BEGIN
    listadoactividades  :=pkmodificacionnivel2.fbuscaractividades(ivfechavencimiento , ivpartedescripcion , ivprioridad, ividentificador);
    ovCodigoMensajeError:=0;
    RETURN listadoactividades;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END fbuscaractividades;
  PROCEDURE pmodificaractividad(
      ivId                   IN actividades.ID%TYPE,
      ivprioridad            IN actividades.prioridad%TYPE,
      ivfechainicio          IN actividades.fecha_inicio%TYPE,
      ivfechafin             IN actividades.fecha_fin%TYPE,
      ivdescripcion          IN actividades.descripcion%TYPE,
      ivnombre               IN actividades.nombre%TYPE,
      ivtemporalidad         IN actividades.temporalidad%TYPE,
      ivcantidadrepeticiones IN actividades.cantidadrepeticiones%TYPE,
      ivproyectoid           IN actividades.proyectos_id%TYPE,
      ivestadoconsecutivo    IN actividades.estados_consecutivo%TYPE,
      ivcategoriaid          IN actividades.categorias_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.pmodificaractividad( ivId , ivprioridad , ivfechainicio , ivfechafin , ivdescripcion , ivnombre , ivtemporalidad , ivcantidadrepeticiones , ivproyectoid , ivestadoconsecutivo , ivcategoriaid );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END pmodificaractividad;
  PROCEDURE pmodificarcategoria(
      ivId          IN categorias.ID%TYPE,
      ivnombre      IN categorias.nombre%TYPE,
      ivprioridad   IN categorias.peso%TYPE,
      ivdescripcion IN categorias.descripcion%TYPE,
      ivpadreid     IN categorias.categorias_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.pmodificarcategoria( ivId , ivnombre , ivprioridad , ivdescripcion, ivpadreid );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END pmodificarcategoria;
/*PROCEDURE pmodificardependenciasact (
ivactrequisito,
ivactdependiente
) is*/
  PROCEDURE pmodificarestados(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ivnombre      IN estados.nombre%TYPE,
      ivdescripcion IN estados.descripcion%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.pmodificarestados( ivconsecutivo , ivnombre , ivdescripcion );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END pmodificarestados;
  PROCEDURE pmodificargerente(
      ivid       IN gerentes.ID%TYPE,
      ivnombre   IN gerentes.nombre%TYPE,
      ivtelefono IN gerentes.telefono%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.pmodificargerente( ivid , ivnombre , ivtelefono);
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END pmodificargerente;
  PROCEDURE pmodificarproyecto(
      ivid          IN proyectos.ID%TYPE,
      ivNombre      IN PROYECTOS.NOMBRE%TYPE,
      ivfechainicio IN proyectos.fecha_inicio%TYPE,
      ivfechafin    IN proyectos.fecha_fin%TYPE,
      ivgerenteid   IN proyectos.gerentes_id%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.pmodificarproyecto( ivid , ivNombre , ivfechainicio, ivfechafin , ivgerenteid );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END pmodificarproyecto;
--PROCEDIMIENTOS PARA ELIMINAR
  PROCEDURE peliminaractividad(
      ividactividad IN actividades.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminaractividad( ividactividad);
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminaractividad;
  PROCEDURE peliminarcategoria(
      ivid IN categorias.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminarcategoria( ivid);
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminarcategoria;
--REVISAR
  PROCEDURE peliminardependenciasacts(
      ivactrequisito   IN dependenciasacts.actividadrequisitoid%TYPE,
      ivactdependiente IN dependenciasacts.actividaddependienteid%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminardependenciasacts( ivactrequisito , ivactdependiente);
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminardependenciasacts;
  PROCEDURE peliminarestado(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminarestado( ivconsecutivo);
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminarestado;
  PROCEDURE peliminargerente(
      ivid IN gerentes.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminargerente( ivid );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminargerente;
  PROCEDURE peliminarproyecto(
      ivid IN proyectos.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    pkmodificacionnivel2.peliminarproyecto( ivid );
    ovCodigoMensajeError:=0;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError:=1;
    ovMensajeError      := SQLERRM;
  END peliminarproyecto;
END pkmodificacionnivel3;