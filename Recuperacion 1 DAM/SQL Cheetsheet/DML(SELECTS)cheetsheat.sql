# Variables:
SET @Variable_usuario = 'VALOR';
SELECT @Variable_usuario AS alias;
SELECT @@VARIABLE_DEL_SISTEMA
#DECLARE variable_local VARCHAR(12) DEFAULT 'VALOR'; 
#Solo se puede usar dentro de funciones procedimientos o algun tipo de recurso de programacion de bbdd
DELIMITER $$ #Se usa para crear funciones procedures,triggers...
DELIMITER ;

DROP PROCEDURE nombre_del_procedimiento;
delimiter $$
create procedure nombre_procedimiento()
begin
 # INSTRUCCIONES;
end $$
delimiter ;
CALL nombre_procedimiento(/*VARIABLES*/)# Se deben incluir las variables de entrada salida o mixtas q pida el procedimiento

delimiter $$
create function nombre_funcion() 
returns tipoVbleX #Solo hay que especificar el tipo, no el nombre
DETERMINISTIC
NOSQL
READS/MODIFIES/CONTAINS SQL DATA
begin
 # INSTRUCCIONES;
return vbleX;
end $$
delimiter ;

delimiter $$
CREATE TRIGGER nombre_trigger {BEFORE | AFTER}
{INSERT | UPDATE | DELETE} ON nombre_tabla
FOR EACH ROW
BEGIN
 # INSTRUCCIONES;
END$$
delimiter ;

delimiter $$
CREATE EVENT nombre_evento ON SCHEDULE AT X
DO
BEGIN
INSTRUCCIONES;
END$$
delimiter ;