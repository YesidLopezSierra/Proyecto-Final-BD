CREATE OR REPLACE PACKAGE pkmodificacionnivel2
AS --spec
  FUNCTION fbuscaractividades(
      ivfechavencimiento IN actividades.fecha_fin%TYPE,
      ivpartedescripcion IN actividades.descripcion%TYPE,
      ivprioridad        IN actividades.prioridad%TYPE,
      ividentificador    IN actividades.ID%TYPE )
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
      ivcategoriaid          IN actividades.categorias_id%TYPE );
  PROCEDURE pmodificarcategoria(
      ivId          IN categorias.ID%TYPE,
      ivnombre      IN categorias.nombre%TYPE,
      ivprioridad   IN categorias.peso%TYPE,
      ivdescripcion IN categorias.descripcion%TYPE,
      ivpadreid     IN categorias.categorias_id%TYPE );
  /*  PROCEDURE pmodificardependenciasact (
  ivactrequisito     dependenciasacts.actividadrequisitoid%TYPE,
  ivactdependiente   dependenciasacts.actividaddependienteid%TYPE
  );*/
  PROCEDURE pmodificarestados(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ivnombre      IN estados.nombre%TYPE,
      ivdescripcion IN estados.descripcion%TYPE );
  PROCEDURE pmodificargerente(
      ivid       IN gerentes.ID%TYPE,
      ivnombre   IN gerentes.nombre%TYPE,
      ivtelefono IN gerentes.telefono%TYPE );
  PROCEDURE pmodificarproyecto(
      ivid          IN proyectos.ID%TYPE,
      ivNombre      IN PROYECTOS.NOMBRE%TYPE,
      ivfechainicio IN proyectos.fecha_inicio%TYPE,
      ivfechafin    IN proyectos.fecha_fin%TYPE,
      ivgerenteid   IN proyectos.gerentes_id%TYPE );
  PROCEDURE peliminaractividad(
      ividactividad IN actividades.ID%TYPE );
  PROCEDURE peliminarcategoria(
      ivid IN categorias.ID%type );
  PROCEDURE peliminardependenciasacts(
      ivactrequisito   IN dependenciasacts.actividadrequisitoid%TYPE,
      ivactdependiente IN dependenciasacts.actividaddependienteid%TYPE );
  PROCEDURE peliminarestado(
      ivconsecutivo IN estados.consecutivo%TYPE );
  PROCEDURE peliminargerente(
      ivid IN gerentes.ID%TYPE );
  PROCEDURE peliminarproyecto(
      ivid IN proyectos.ID%TYPE );
END pkmodificacionnivel2;
/
CREATE OR REPLACE PACKAGE BODY pkmodificacionnivel2
AS --body
  FUNCTION fbuscaractividades(
      ivfechavencimiento IN actividades.fecha_fin%TYPE,
      ivpartedescripcion IN actividades.descripcion%TYPE,
      ivprioridad        IN actividades.prioridad%TYPE,
      ividentificador    IN actividades.ID%TYPE )
    RETURN SYS_REFCURSOR
  IS
    vfechavencimiento actividades.fecha_fin%TYPE;
    vpartedescripcion actividades.descripcion%TYPE;
    vprioridad actividades.prioridad%TYPE;
    videntificador actividades.ID%TYPE;
    listadoactividades SYS_REFCURSOR;
  BEGIN
    vfechavencimiento :=ivfechavencimiento;
    IF ividentificador = 0 THEN
      videntificador  := NULL;
    ELSE
      videntificador :=ividentificador;
    END IF;
    IF ivprioridad = 0 THEN
      vprioridad  := NULL;
    ELSE
      vprioridad :=ivprioridad;
    END IF;
     IF ivpartedescripcion is null THEN
    OPEN listadoactividades FOR SELECT * FROM actividades act WHERE act.fecha_fin = NVL(vfechavencimiento,act.fecha_fin)  AND act.prioridad = NVL(vprioridad, act.prioridad ) AND act.ID = NVL(videntificador,act.ID);
    ELSE
    OPEN listadoactividades FOR SELECT * FROM actividades act WHERE act.fecha_fin = NVL(vfechavencimiento,act.fecha_fin) AND act.descripcion LIKE NVL('%'||ivpartedescripcion||'%',act.descripcion) AND act.prioridad = NVL(vprioridad, act.prioridad ) AND act.ID = NVL(videntificador,act.ID);
    END IF;
    RETURN listadoactividades;
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20401, 'No se encontró ninguna actividad con los parámetros dados');
  WHEN OTHERS THEN
    raise_application_error(-20402, 'Error inesperado');
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
      ivcategoriaid          IN actividades.categorias_id%TYPE )
  IS
    ivfila actividades%rowtype;
    vprioridad actividades.prioridad%TYPE;
    vfechainicio actividades.fecha_inicio%TYPE;
    vfechafin actividades.fecha_fin%TYPE;
    vdescripcion actividades.descripcion%TYPE;
    vnombre actividades.nombre%TYPE;
    vtemporalidad actividades.temporalidad%TYPE;
    vcantidadrepeticiones actividades.cantidadrepeticiones%TYPE;
    vproyectoid actividades.proyectos_id%TYPE;
    vestadoconsecutivo actividades.estados_consecutivo%TYPE;
    vcategoriaid actividades.categorias_id%TYPE;
  BEGIN

    vprioridad :=ivprioridad;
    vfechainicio :=ivfechainicio;
    vfechafin :=ivfechafin;
    vdescripcion := ivdescripcion;
    vnombre :=ivNombre;
    vtemporalidad :=ivtemporalidad;
    vcantidadrepeticiones :=ivcantidadrepeticiones;
    vproyectoid:= ivproyectoid;
    vestadoconsecutivo :=ivestadoconsecutivo;
    vcategoriaid:=ivcategoriaid;

    IF ivid IS NULL THEN
      raise_application_error (-20403, 'El parámetro ID es nulo. Error en el procedimiento pModificar nivel 2.');
    END IF;
    IF ivprioridad IS NULL or ivprioridad=0 THEN
      SELECT prioridad INTO vprioridad FROM actividades WHERE ID=ivID;
    END IF;
    IF ivfechainicio IS NULL THEN
      SELECT fecha_inicio INTO vfechainicio FROM actividades WHERE ID=ivID;
    END IF;
    IF ivfechafin IS NULL THEN
      SELECT fecha_fin INTO vfechafin FROM actividades WHERE ID=ivID;
    END IF;
    IF ivdescripcion IS NULL THEN
      SELECT descripcion INTO vdescripcion FROM actividades WHERE ID=ivID;
    END IF;
    IF ivnombre IS NULL THEN
      SELECT nombre INTO vNombre FROM actividades WHERE ID=ivID;
    END IF;
    IF ivtemporalidad IS NULL  THEN
      SELECT temporalidad INTO vtemporalidad FROM actividades WHERE ID=ivID;
    END IF;
    IF ivcantidadrepeticiones IS NULL or ivcantidadrepeticiones =0 THEN
      SELECT cantidadrepeticiones
      INTO vcantidadrepeticiones
      FROM actividades
      WHERE ID=ivID;
    END IF;
    IF ivproyectoid IS NULL or ivproyectoid=0 THEN
      SELECT proyectos_id INTO vproyectoid FROM actividades WHERE ID=ivID;
    END IF;
    IF ivestadoconsecutivo IS NULL  or ivestadoconsecutivo=0 THEN
      SELECT estados_consecutivo
      INTO vestadoconsecutivo
      FROM actividades
      WHERE ID=ivID;
    END IF;
    IF ivcategoriaid IS  NULL or ivcategoriaid=0 THEN
      SELECT categorias_id INTO vcategoriaid FROM actividades WHERE ID=ivID;
    END IF;
    SELECT ivId,
      vprioridad,
      vfechainicio,
      vfechafin,
      vdescripcion,
      vnombre,
      vtemporalidad,
      vcantidadrepeticiones,
      vproyectoid,
      vestadoconsecutivo,
      vcategoriaid
    INTO ivfila
    FROM dual;
    pkactividades.pmodificar(ivfila);
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20414, 'No se encontro una actividad con el ID: ' || ivid ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 2.');
  WHEN OTHERS THEN
    raise_application_error(-20415,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 2.' || SQLERRM);
  END pmodificaractividad;
  PROCEDURE pmodificarcategoria(
      ivId          IN categorias.ID%TYPE,
      ivnombre      IN categorias.nombre%TYPE,
      ivprioridad   IN categorias.peso%TYPE,
      ivdescripcion IN categorias.descripcion%TYPE,
      ivpadreid     IN categorias.categorias_id%TYPE )
  IS
    vfila categorias%rowtype;
    vnombre categorias.nombre%TYPE;
    vprioridad categorias.peso%TYPE;
    vdescripcion categorias.descripcion%TYPE;
    vpadreid categorias.categorias_id%TYPE;
  BEGIN
    vnombre :=ivNombre;
    vprioridad :=ivprioridad;
    vdescripcion :=ivdescripcion;
    vpadreid :=ivpadreid;
    --arreglaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaar
    IF ivid IS NULL THEN
      raise_application_error (-20416, 'El parametro ID es nulo. Error en el procedimiento pModificar nivel 2.');
    END IF;
    IF ivnombre IS NULL THEN
      SELECT nombre INTO vNombre FROM categorias WHERE ID=ivID;
    END IF;
    IF ivprioridad IS NULL or ivprioridad=0 THEN
      SELECT peso INTO vprioridad FROM categorias WHERE ID=ivID;
    END IF;
    IF ivdescripcion IS NULL THEN
      SELECT descripcion INTO vdescripcion FROM categorias WHERE ID=ivID;
    END IF;
    IF ivpadreid IS NULL or ivpadreid =0 THEN
      SELECT categorias_id INTO vpadreid FROM categorias WHERE ID=ivID;
    END IF;
    SELECT ivid,vnombre,vdescripcion,vpadreid,vprioridad INTO vFila FROM dual;
    pkcategoria.pmodificar(vfila);
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20421, 'No se encontro una categoria con el ID: ' || ivid ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 2.');
  WHEN OTHERS THEN
    raise_application_error(-20422,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 2.' || SQLERRM);
  END pmodificarcategoria;
/*PROCEDURE pmodificardependenciasact (
ivactrequisito,
ivactdependiente
) is*/
  PROCEDURE pmodificarestados(
      ivconsecutivo IN estados.consecutivo%TYPE,
      ivnombre      IN estados.nombre%TYPE,
      ivdescripcion IN estados.descripcion%TYPE )
  IS
    vnombre estados.nombre%TYPE;
    vdescripcion estados.descripcion%TYPE;
  BEGIN
  vnombre := ivNombre;
    vdescripcion := ivdescripcion;
    IF ivconsecutivo IS NULL THEN
      raise_application_error (-20423, 'El parametro CONSECUTIVO es nulo. Error en el procedimiento pModificar nivel 2.');
    END IF;
    IF ivnombre IS NULL THEN
      SELECT nombre INTO vNombre FROM estados WHERE consecutivo=ivconsecutivo;
    END IF;
    IF ivdescripcion IS NULL THEN
      SELECT descripcion
      INTO vdescripcion
      FROM estados
      WHERE consecutivo=ivconsecutivo;
    END IF;
    pkestados.pmodificar(ivconsecutivo, vnombre, vdescripcion);
  EXCEPTION
  WHEN no_data_found THEN
    raise_application_error(-20426, 'No se encontro una categoria con el CONSECUTIVO: ' || ivconsecutivo ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 2.');
  WHEN OTHERS THEN
    raise_application_error(-20427,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 2.' || SQLERRM);
  END pmodificarestados;
  PROCEDURE pmodificargerente(
      ivid       IN gerentes.ID%TYPE,
      ivnombre   IN gerentes.nombre%TYPE,
      ivtelefono IN gerentes.telefono%TYPE )
  IS
    vFila gerentes%rowtype;
    vnombre gerentes.nombre%TYPE;
    vtelefono gerentes.telefono%TYPE;
  BEGIN
    vnombre := ivNombre;
    vtelefono:=ivtelefono;
    IF ivid IS NULL THEN
      RAISE_APPLICATION_ERROR (-20428, 'El parametro ID es nulo. Error en el procedimiento pModificar nivel 2.');
    END IF;
    IF ivnombre IS NULL THEN
      SELECT nombre INTO vNombre FROM gerentes WHERE id=ivId;
    END IF;
    IF ivtelefono IS NULL THEN
      SELECT telefono INTO vtelefono FROM gerentes WHERE id=ivId;
    END IF;
    SELECT ivId, vNombre, vtelefono INTO vFila FROM dual;
    pkGerentes.pModificar (vFila);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20431, 'No se encontro un Gerente con el ID: ' || ivid||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 2.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20432,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 2.' || SQLERRM);
  END pmodificargerente;
  PROCEDURE pmodificarproyecto(
      ivid          IN proyectos.ID%TYPE,
      ivNombre      IN PROYECTOS.NOMBRE%TYPE,
      ivfechainicio IN proyectos.fecha_inicio%TYPE,
      ivfechafin    IN proyectos.fecha_fin%TYPE,
      ivgerenteid   IN proyectos.gerentes_id%TYPE )
  IS
    vFila proyectos%rowtype;
    vfechainicio proyectos.fecha_inicio%TYPE;
    vfechafin proyectos.fecha_fin%TYPE;
    vNombre PROYECTOS.NOMBRE%TYPE;
    vgerenteid proyectos.gerentes_id%TYPE;
  BEGIN
  vfechainicio :=ivfechainicio;
    vfechafin :=ivfechafin;
    vNombre :=ivNombre;
    vgerenteid :=ivgerenteid;
    IF ivid IS NULL THEN
      RAISE_APPLICATION_ERROR (-20433, 'El parametro ID es nulo. Error en el procedimiento pModificar nivel 2.');
    END IF;
    IF ivfechainicio IS NULL THEN
      SELECT fecha_inicio INTO vfechainicio FROM proyectos WHERE id=ivId;
    END IF;
    IF ivfechafin IS NULL THEN
      SELECT fecha_fin INTO vfechafin FROM proyectos WHERE id=ivId;
    END IF;
    IF ivgerenteid IS NULL or ivgerenteid=0 THEN
      SELECT gerentes_id INTO vgerenteid FROM proyectos WHERE id=ivId;
    END IF;
    IF ivNombre IS NULL THEN
      SELECT nombre INTO vNombre FROM proyectos WHERE id=ivId;
    END IF;
    SELECT ivId,
      vNombre,
      vfechainicio,
      vfechafin,
      vgerenteid
    INTO vFila
    FROM dual;
    pkProyectos.pModificar(vFila);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20437, 'No se encontro un Proyecto con el ID: ' || ivid ||' Para la cual modificar sus atributos. Error en la procedimiento pModificar nivel 2.');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20438,'Ha occurrido un error inesperado en el procedimiento pModificar nivel 2.' || SQLERRM);
  END pmodificarproyecto;
--PROCEDIMIENTOS PARA ELIMINAR
  PROCEDURE peliminaractividad(
      ividactividad IN actividades.ID%TYPE )
  IS
  BEGIN
    IF ividactividad IS NULL THEN
      RAISE_APPLICATION_ERROR(-20439, 'LA ACTIVIDAD A BORRAR NO EXISTE');
    END IF;
    pkActividades.pEliminar(ividactividad);
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20440,'Error al eliminar una actividad. Funcion pEliminar nivel 1.' || SQLERRM);
  END peliminaractividad;
  PROCEDURE peliminarcategoria(
      ivid IN categorias.ID%type )
  IS
  BEGIN
    IF ivid IS NULL THEN
      RAISE_APPLICATION_ERROR (-20441, 'El parámetro ID es nulo. Error en el procedimiento pModificar nivel 2.' || SQLERRM);
    END IF;
    pkCategoria.pEliminar(ivid);
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20441, 'La categoria que desea Eliminar no existe');
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20442, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkModificacion nivel 2'|| SQLERRM);
  END peliminarcategoria;
--REVISAR
  PROCEDURE peliminardependenciasacts(
      ivactrequisito   IN dependenciasacts.actividadrequisitoid%TYPE,
      ivactdependiente IN dependenciasacts.actividaddependienteid%TYPE )
  IS
  BEGIN
    IF ivactrequisito IS NULL THEN
      RAISE_APPLICATION_ERROR(-20441, 'El id de la actividad prerequisito debe ser diferente de null');
    END IF;
    IF ivactdependiente IS NULL THEN
      RAISE_APPLICATION_ERROR(-20441, 'El id de la actividad pendiente debe ser diferente de null');
    END IF;
    pkDependenciaAct.pEliminar(ivactrequisito, ivactdependiente);
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20442, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkModificacion nivel 2 '|| SQLERRM);
  END peliminardependenciasacts;
  PROCEDURE peliminarestado(
      ivconsecutivo IN estados.consecutivo%TYPE )
  IS
  BEGIN
    IF ivconsecutivo IS NULL THEN
      RAISE_APPLICATION_ERROR(-20441, 'El consecutivo del estado debe ser diferente de null');
    END IF;
    pkestados.pEliminar(ivconsecutivo);
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20442, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkModificacion nivel 2 '|| SQLERRM);
  END peliminarestado;
  PROCEDURE peliminargerente(
      ivid IN gerentes.ID%TYPE )
  IS
  BEGIN
    IF ivId IS NULL THEN
      RAISE_APPLICATION_ERROR(-20441, 'El ID del gerente debe ser diferente de null');
    END IF;
    pkGerentes.pEliminar(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20442, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkModificacion nivel 2 '|| SQLERRM);
  END peliminargerente;
  PROCEDURE peliminarproyecto(
      ivid IN proyectos.ID%TYPE )
  IS
  BEGIN
    IF ivId IS NULL THEN
      RAISE_APPLICATION_ERROR(-20441, 'El ID del proyecto debe ser diferente de null');
    END IF;
    pkProyectos.pEliminar(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20442, 'Se genero una excepcion inesperada en el procedimiento pEliminar del pkModificacion nivel 2 '|| SQLERRM);
  END peliminarproyecto;
END pkmodificacionnivel2;