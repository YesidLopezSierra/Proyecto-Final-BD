CREATE OR REPLACE PACKAGE pkClasificacionNivel2
AS
  FUNCTION fCalcularPrioridad(
      ivID ACTIVIDADES.ID%TYPE)
    RETURN NUMBER;
  FUNCTION fdarPrioridadPorFecha(
      ivfechaFin DATE)
    RETURN NUMBER;
  FUNCTION fdarFechaActual
    RETURN DATE;
  PROCEDURE pRecalcularPrioridades;
  FUNCTION fdarAnteriorActividad(
      ivID actividades.id%type)
    RETURN actividades%rowType;
  FUNCTION fdarPrioridadPorCategoria(
      ivID actividades.id%type)
    RETURN NUMBER;
  PROCEDURE pcambiarPrioridad(
      ivID ACTIVIDADES.ID%TYPE);
  PROCEDURE pcambiarPrioridadPorRechazo(
      ivID ACTIVIDADES.ID%TYPE,
      ivcausa NUMBER);
END pkClasificacionNivel2;
/


CREATE OR REPLACE PACKAGE body pkClasificacionNivel2
AS
  FUNCTION fCalcularPrioridad(
      ivID ACTIVIDADES.ID%TYPE)
    RETURN NUMBER
  IS
    vpredecesora ACTIVIDADES%ROWTYPE;
    vact ACTIVIDADES%ROWTYPE;
    vtotal INTEGER;
    vprioridadGP ACTIVIDADES.PRIORIDAD%TYPE;
    vfechaF     DATE;
    vdiferencia INTEGER;
    cuConsulta  sys_refcursor;
    vran number;
    ventero INTEGER;
  BEGIN
    vtotal                    :=99;
    cuconsulta:=pkActividades.fConsultar(ivID);
    fetch cuconsulta into vact;
   
    close cuconsulta;
    vprioridadGP              :=vact.prioridad;
     
    vfechaF                   :=vact.FECHA_FIN;
    vpredecesora              :=fdarAnteriorActividad(ivId);
    IF vpredecesora.prioridad IS NOT NULL THEN
    SELECT dbms_random.value(1,11) INTO vran FROM dual;
    ventero:=vran;
       
      vdiferencia             :=vact.prioridad+ventero;
      IF vdiferencia          <=0 THEN
        vtotal                :=1;
      ELSE
        vtotal:=vdiferencia;
      END IF;
    ELSE
      vtotal      :=vtotal      -10;
      vprioridadGP:=vprioridadGP*0.5;
      vtotal      :=vtotal      -vprioridadGP;
      vtotal      :=vtotal      -fdarPrioridadPorFecha(vfechaF);
      vtotal      :=vtotal      -fdarPrioridadPorCategoria(ivID);
    END IF;
    RETURN vtotal;
  END fCalcularPrioridad;
  
  
  FUNCTION fdarPrioridadPorFecha(
      ivfechaFin DATE)
    RETURN NUMBER
  IS
    vtotal      NUMBER;
    vnumeroDias NUMBER;
    vfechaI     DATE;
  BEGIN
    vfechaI       :=fdarFechaActual;
    vnumeroDias   :=to_date(ivfechaFin,'DD/MM/YYYY' )-to_date(vfechaI,'DD/MM/YYYY' );
    IF vnumeroDias<=10 THEN
      vtotal      :=20;
    END IF;
    IF vnumeroDias >10 AND vnumeroDias <=25 THEN
      vtotal      :=15;
    END IF;
    IF vnumeroDias >25 AND vnumeroDias <=40 THEN
      vtotal      :=10;
    END IF;
    IF vnumeroDias>40 THEN
      vtotal     :=5;
    END IF;
    RETURN vtotal;
  END fdarPrioridadPorFecha;
  
  
  PROCEDURE pRecalcularPrioridades
  IS
    viprioridad actividades.id%type;
    prioridadN number;
    CURSOR c1
    IS
      SELECT actividades.id FROM actividades;
  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO viprioridad;
      prioridadN:=fCalcularPrioridad(viprioridad);
      SYS.DBMS_OUTPUT.PUT_LINE(viprioridad);
      EXIT
    WHEN c1%NOTFOUND;
      UPDATE actividades
      SET actividades.PRIORIDAD= prioridadN
      WHERE actividades.id     =viprioridad;
    END LOOP;
   CLOSE c1;
  END pRecalcularPrioridades;
   
  
  FUNCTION fdarFechaActual
    RETURN DATE
  IS
    vfechaA DATE;
  BEGIN
    vfechaA:=to_date(vfechaA,'DD/MM/YYYY' );
    SELECT TO_date(SysDate,'DD/MM/YYYY') todays_date INTO vfechaA FROM dual;
    RETURN vfechaA;
  END fdarFechaActual;
  
  
  FUNCTION fdarAnteriorActividad(
      ivId actividades.id%type)
    RETURN actividades%rowType
  IS
    pre DEPENDENCIASACTS.ACTIVIDADREQUISITOID%type;
    vpreAct actividades%rowtype;
    vpreAct2 actividades%rowtype;
    CURSOR C1
    IS
      SELECT DEPENDENCIASACTS.ACTIVIDADREQUISITOID
      FROM actividades, DEPENDENCIASACTS
      WHERE ivId=DEPENDENCIASACTS.ACTIVIDADDEPENDIENTEID;
      cuVariable sys_refcursor;
  BEGIN
    OPEN c1;
    LOOP
      FETCH c1 INTO pre;
      EXIT
    WHEN c1%notFound;
     
    END LOOP;
    CLOSE c1;
    cuVariable:=pkActividades.fConsultar(pre);
    DBMS_OUTPUT.PUT_LINE(pre);
    fetch cuVariable into vpreAct;
    close cuVariable;
    IF pre    IS NOT NULL THEN
      vpreAct2:=vpreAct;
      
    else
    vpreAct2:=null;
     
    end if;
    RETURN vpreAct2;
  END fdarAnteriorActividad;
  
  
  FUNCTION fdarPrioridadPorCategoria(
      ivID actividades.id%type)
    RETURN NUMBER
  IS
    vPRio number;
    vtotal NUMBER;
    vpesoC NUMBER;
    vcat categorias%rowtype;
    vact actividades%rowtype;
    cuActividad sys_refCursor;
    cuCategoria sys_refCursor;
  BEGIN
    cuActividad :=pkactividades.fConsultar(ivID);
    fetch cuActividad into vact;
    vprio:=vact.prioridad;
    cuCategoria :=pkCategoria.fConsultar(vact.categorias_id);
    fetch cuActividad into vact;
    close cuActividad;
    fetch cuCategoria into vcat;
    close cuCategoria;
    IF vcat.peso IS NOT NULL THEN
      vpesoC     :=vcat.peso;
      IF vpesoC   <25 THEN
        vtotal   :=3;
      END IF;
      IF vpesoC>24 AND vpesoC <=50 THEN
        vtotal:=9;
      END IF;
      IF vpesoC>50 AND vpesoC <=75 THEN
        vtotal:=14;
      END IF;
      IF vpesoC>75 THEN
        vtotal:=19;
      END IF;
    END IF;
    RETURN vtotal;
  END fdarPrioridadPorCategoria;
  
  
  PROCEDURE pcambiarPrioridad(
      ivID ACTIVIDADES.ID%TYPE)
  IS
    vprio NUMBER;
  BEGIN
    vprio:=fCalcularPrioridad(ivID);
    UPDATE ACTIVIDADES SET ACTIVIDADES.PRIORIDAD=vprio WHERE actividades.id=ivID;
  END pcambiarPrioridad;
  
  
  PROCEDURE pcambiarPrioridadPorRechazo(
      ivID ACTIVIDADES.ID%TYPE,
      ivcausa NUMBER)
  IS
    vprio NUMBER;
    vran  NUMBER;
    ventero INTEGER;
    vresultado INTEGER;
    vact actividades%rowtype;
    cuConsulta  sys_refcursor;
  BEGIN
    cuconsulta:=pkActividades.fConsultar(ivID);
    fetch cuconsulta into vact;
    
    vprio:=vact.prioridad;
    close cuconsulta;
    SELECT dbms_random.value(1,10) INTO vran FROM dual;
    ventero:=vran;
    IF ivcausa=1 THEN
    vresultado:=vprio+ventero;
      if vresultado<100 then
      
        UPDATE ACTIVIDADES
        SET ACTIVIDADES.PRIORIDAD=vprio+ventero
        WHERE actividades.id     =ivID;
        else
        RAISE_APPLICATION_ERROR(-20622, 'No se puede cambiar más la prioridad');
      END IF;
    end if;
    
    IF ivcausa=0 THEN
    
      vresultado:=vprio-ventero;
      if vresultado>0 then
        UPDATE ACTIVIDADES
        SET ACTIVIDADES.PRIORIDAD=vprio-ventero
        WHERE actividades.id     =ivID;
      else
       RAISE_APPLICATION_ERROR(-20622, 'No se puede cambiar más la prioridad');
  
     end if;
    end if;
  END pcambiarPrioridadPorRechazo;
END pkClasificacionNivel2;
/
