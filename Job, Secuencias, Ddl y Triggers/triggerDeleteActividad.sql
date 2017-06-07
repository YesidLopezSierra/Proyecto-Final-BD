CREATE OR REPLACE TRIGGER borradoRegistroActividad
AFTER DELETE
ON ACTIVIDADES
FOR EACH ROW
BEGIN
INSERT INTO TRIGGERACTIVIDADES
VALUES
(:OLD.Id, :OLD.Prioridad, :OLD.Fecha_Inicio,
:OLD.Fecha_Fin, :OLD.Descripcion, :OLD.Nombre, :OLD.Temporalidad,
:OLD.CantidadRepeticiones, :OLD.Proyectos_Id, :OLD.Estados_Consecutivo,
:OLD.Categorias_Id);
END;