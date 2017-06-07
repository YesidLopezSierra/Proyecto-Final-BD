DROP TABLE TriggerCategorias CASCADE CONSTRAINTS ;
DROP TABLE TriggerDependenciasActs CASCADE CONSTRAINTS ;
DROP TABLE TriggerEstados CASCADE CONSTRAINTS ;
DROP TABLE TriggerGerentes CASCADE CONSTRAINTS ;
DROP TABLE TriggerProyectos CASCADE CONSTRAINTS ;

CREATE TABLE TriggerCategorias
  (
    Id            NUMBER NOT NULL ,
    Nombre        VARCHAR2 (30) NOT NULL ,
    Descripcion   VARCHAR2 (30) NOT NULL ,
    Categorias_Id NUMBER ,
    Peso          NUMBER NOT NULL
  ) ;
ALTER TABLE TriggerCategorias ADD CONSTRAINT TriggerCategorias_PK PRIMARY KEY ( Id ) ;

CREATE OR REPLACE TRIGGER borradoRegistroCategoria
AFTER DELETE
ON CATEGORIAS
FOR EACH ROW
BEGIN
INSERT INTO TriggerCategorias
VALUES
(:OLD.Id, :OLD.Nombre, :OLD.Descripcion,
:OLD.Categorias_Id, :OLD.Peso
);
END;
/

CREATE TABLE TriggerDependenciasActs
  (
    ActividadRequisitoId   NUMBER NOT NULL ,
    ActividadDependienteId NUMBER NOT NULL
  ) ;
ALTER TABLE TriggerDependenciasActs ADD CONSTRAINT TriggerDependenciasActs_PK PRIMARY KEY ( ActividadRequisitoId, ActividadDependienteId ) ;

CREATE OR REPLACE TRIGGER borradoRegistroDepen
AFTER DELETE
ON DEPENDENCIASACTS
FOR EACH ROW
BEGIN
INSERT INTO TriggerDependenciasActs
VALUES
(:OLD.ActividadRequisitoId, :OLD.ActividadRequisitoId
);
END;
/

CREATE TABLE TriggerEstados
  (
    Consecutivo NUMBER NOT NULL ,
    Nombre      VARCHAR2 (30) NOT NULL ,
    Descripcion VARCHAR2 (30) NOT NULL
  ) ;
ALTER TABLE TriggerEstados ADD CONSTRAINT TriggerEstados_PK PRIMARY KEY ( Consecutivo ) ;

CREATE OR REPLACE TRIGGER borradoRegistroEstados
AFTER DELETE
ON ESTADOS
FOR EACH ROW
BEGIN
INSERT INTO TriggerEstados
VALUES
(:OLD.Consecutivo, :OLD.Nombre
,:OLD.Descripcion
);
END;
/

CREATE TABLE TriggerGerentes
  (
    Id       NUMBER NOT NULL ,
    Nombre   VARCHAR2 (30) NOT NULL ,
    Telefono VARCHAR2 (30) NOT NULL
  ) ;
ALTER TABLE TriggerGerentes ADD CONSTRAINT TriggerGerentes_PK PRIMARY KEY ( Id ) ;


CREATE OR REPLACE TRIGGER borradoRegistroGerentes
AFTER DELETE
ON GERENTES
FOR EACH ROW
BEGIN
INSERT INTO TriggerGerentes
VALUES
(:OLD.Id, :OLD.Nombre
,:OLD.Telefono
);
END;
/

CREATE TABLE TriggerProyectos
  (
    Id           NUMBER NOT NULL ,
    Nombre       VARCHAR2 (20) NOT NULL ,
    Fecha_Inicio DATE NOT NULL ,
    Fecha_Fin    DATE NOT NULL ,
    Gerentes_Id  NUMBER NOT NULL
  ) ;
ALTER TABLE TriggerProyectos ADD CONSTRAINT TriggerProyectos_PK PRIMARY KEY ( Id ) ;


CREATE OR REPLACE TRIGGER borradoRegistroProyectos
AFTER DELETE
ON PROYECTOS
FOR EACH ROW
BEGIN
INSERT INTO TriggerProyectos
VALUES
(:OLD.Id, :OLD.Nombre,
:OLD.Fecha_Inicio,:OLD.Fecha_Fin,:OLD.Gerentes_Id
);
END;
/

