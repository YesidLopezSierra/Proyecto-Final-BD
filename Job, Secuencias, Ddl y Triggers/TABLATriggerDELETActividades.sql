DROP TABLE TriggerActividades CASCADE CONSTRAINTS ;
CREATE TABLE TriggerActividades
  (
    Id                   NUMBER NOT NULL ,
    Prioridad            VARCHAR2 (30) NOT NULL ,
    Fecha_Inicio         DATE NOT NULL ,
    Fecha_Fin            DATE NOT NULL ,
    Descripcion          VARCHAR2 (30) NOT NULL ,
    Nombre               VARCHAR2 (30) NOT NULL ,
    Temporalidad         VARCHAR2 (30) NOT NULL ,
    CantidadRepeticiones INTEGER NOT NULL ,
    Proyectos_Id         NUMBER NOT NULL ,
    Estados_Consecutivo  NUMBER NOT NULL ,
    Categorias_Id        NUMBER NOT NULL
  ) ;
ALTER TABLE TriggerActividades ADD CONSTRAINT TriggerActividades_PK PRIMARY KEY ( Id ) ;