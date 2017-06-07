CREATE OR REPLACE PACKAGE pkClasificacionNivel3
AS
  FUNCTION fCalcularPrioridad(
      ivID ACTIVIDADES.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER;
  FUNCTION fDarPrioridadPorFecha(
      ivFechaFin DATE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER;
  FUNCTION fDarFechaActual(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN DATE;
  FUNCTION fDarAnteriorActividad(
      ivID ACTIVIDADES.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN actividades%rowType;
  FUNCTION fDarPrioridadPorCategoria(
      ivID ACTIVIDADES.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER;
  PROCEDURE pRecalcularPrioridades(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE pCambiarPrioridad(
      ivID ACTIVIDADES.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
  PROCEDURE pCambiarPrioridadPorRechazo(
      ivID ACTIVIDADES.ID%TYPE,
      ivCausa NUMBER,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 );
END pkClasificacionNivel3;
/
CREATE OR REPLACE PACKAGE body pkClasificacionNivel3
IS
  PROCEDURE pCambiarPrioridadPorRechazo(
      ivID ACTIVIDADES.ID%TYPE,
      ivCausa NUMBER,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    pkClasificacionNivel2.pCambiarPrioridadPorRechazo(ivId, ivCausa);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END pCambiarPrioridadPorRechazo;
  PROCEDURE pCambiarPrioridad(
      ivID ACTIVIDADES.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    pkClasificacionNivel2.pCambiarPrioridad(ivId);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END pCambiarPrioridad;
  PROCEDURE pRecalcularPrioridades(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    pkClasificacionNivel2.pRecalcularPrioridades;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END pRecalcularPrioridades;
  FUNCTION fCalcularPrioridad(
      ivID ACTIVIDADES.ID%TYPE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkClasificacionNivel2.fCalcularPrioridad(ivID);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fCalcularPrioridad;
  FUNCTION fDarPrioridadPorFecha(
      ivFechaFin DATE,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkClasificacionNivel2.fdarPrioridadPorFecha(ivFechaFin);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarPrioridadPorFecha;
  FUNCTION fDarFechaActual(
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN DATE
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkClasificacionNivel2.fdarFechaActual;
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarFechaActual;
  FUNCTION fDarAnteriorActividad(
      ivID ACTIVIDADES.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN actividades%rowType
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkClasificacionNivel2.fDarAnteriorActividad( ivID);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarAnteriorActividad;
  FUNCTION fDarPrioridadPorCategoria(
      ivID ACTIVIDADES.ID%type,
      ovCodigoMensajeError OUT NUMBER,
      ovMensajeError OUT VARCHAR2 )
    RETURN NUMBER
  IS
  BEGIN
    ovCodigoMensajeError :=0;
    RETURN pkClasificacionNivel2.fDarPrioridadPorCategoria( ivID);
  EXCEPTION
  WHEN OTHERS THEN
    ovCodigoMensajeError :=1;
    ovMensajeError       := SQLERRM;
  END fDarPrioridadPorCategoria;
END pkClasificacionNivel3;