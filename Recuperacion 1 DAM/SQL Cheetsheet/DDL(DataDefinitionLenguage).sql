-- Muestran los diferentes tipos de datos en una tabla con sus respectivas caracteristicas
SHOW DATABASES; -- Listar BBDD
SHOW TABLES; -- Listar Tablas de una BDD
SHOW CHARACTER SET; -- Listar los dierentes tipos de Character set
SHOW COLLATION; -- Listar los diferentes tipos de Collation

-- SQLs de creacion de BDD y tablas respectivamente
SHOW CREATE DATABASE nombre_bd; 
SHOW CREATE TABLE nombre_tabla; 

-- Usar BDD
USE nombre_bd;

-- Ver detalles de una tabla (filas y sus tipos de valores, si pueden ser null o no...
DESCRIBE nombre_tabla; 
DESC nombre_tabla;

-- Ejecucion de SQL desde CLI
-- SOURCE fichero.sql

-- Lienea de creacion de la BDD incluyendo la clausula IF NOT EXISTS, el juego de caracteres y el cotejamiento
CREATE DATABASE IF NOT EXISTS nombre_bd CHARACTER SET juego_de_caracteres COLLATE cotejamiento;
/*
	> CHARACTER SET: Juego de caracteres que se usa en la BDD en nuestro caso usaremos el por defecto (UTF8mb4)
    > COLLATE: Critrtio de ordenacion de cadenas de caracteres que se usara, usaremos el por defecto (utf8mb4_0900_ai_ci)
		- accent-sensitive (_as): Los caracteres a y á son diferentes. (a!=á)
		- accent-insensitive (_ai): Los caracteres a y á son iguales. (a=á)
		- case-sensitive (_cs): Los caracteres a y A son diferentes. (a!=A)
		- case-insensitive (_ci): Los caracteres a y A son iguales. (a=A)
	> IF NOT EXISTS: Clausula que evita error durante la creación de una BD que ya exista.
*/

-- Ejemplo del codigo de consulta del CHARACTER SET y COLLATION de una bd
SELECT schema_name AS 'database',
default_character_set_name AS 'charset',
default_collation_name AS 'collation'
FROM information_schema.SCHEMATA
WHERE schema_name = "nombre_bd";

-- Lienea de eliminacion de la BDD incluyendo la clausula IF NOT EXISTS
DROP DATABASE IF EXISTS nombre_bd;

-- Linea de odificacion de una BDD
ALTER DATABASE nombre_bd
CHARACTER SET charset_name
 COLLATE collation_name
 ENCRYPTION 'Y/N';
 
 CREATE TABLE IF NOT EXISTS nombre_tabla(
 nombre_fila bit default(2)
 );
 
  -- Restricciones sobre las columnas de una tabla: 
 /*
	> NOT NULL: Evita que un campo pueda tener valores vacíos.
	> UNIQUE: Se asegura de que todos los valores de una columna sean distintos.
	> PRIMARY KEY: Clave primaria. Combina NOT NULL y UNIQUE. Tiene un índice asociado.
	> FOREIGN KEY: Clave foránea. Identifica de forma única una fila de otra tabla. (NO USARLA SIN HABER CREADO LA REFEREMCIA FORANEA)
	> CHECK (CHECK (nombre_fila BETWEEN X AND Y)): Garantiza que todos los valores de una columna cumplen determinada condición.
	> DEFAULT: Fija el valor por defecto para un campo cuando no se especifica uno.
	> AUTO_INCREMENT: Columna autonumérica. Su valor se incrementa automáticamente en cada inserción de una fila. Sólo se utiliza en campos de tipo entero.
 */
 
 -- Tipos de datos:
/*
	> Cadenas de caracteres:
		- CHAR(n): Logitud de la cadena fija de n caracteres.
        - VARCHAR(n): Longitud de la cadena variante de n caracteres.
    > Numeros (permite usar la propiedad UNSIGNED):
		- BIT(n): Valor en binario de n digitos, para ingresar el valor se usa (b'XXXX') en binario o (X) en decimal, no permite negativos.
        - BIT: Valor binario de 2 digitos (0-1).
        - BYTE: Valor decimal equivalente a 8 BIT
        - TINYINT: Valor decimal equivalente a 1 byte, comprende del 0-255 (UNSIGNED) o del (-128-127)
        - SMALLINT: Valor decimal equivalente a 2 bytes (0-65535)
        - MEDIUMINT: Valor decimal equivalente a 3 bytes (0-16777215)
        - INT: Valor decimal equivalente a 4 bytes (0-4294967295)
        - BIGINT: Valor decimal equivalente a 8 bytes (0-2^64)
        - DECIMAL(n,m): Valor decimal que permite guardar numeros de hasta n digitos, siendo los m ultimos digitos decimales.
        - NUMERIC(n,m): Igual a DECIMAL
        - FLOAT: Valor decimal que permite guardar valores con decimales, no es exacto al contrario que el DECIMAL/NUMERIC
        - DOUBLE: Igual a FLOAT
    > Fechas:
		- DATE: YYYY-MM-DD ('1000-01-01' a '9999-12-31')
        - DATETIME: YYYY-MM-DD hh:mm:ss
        - TIMESTAMP: YYYY-MM-DD hh:mm:ss (‘1970-01-01 00:00:01’ a ‘2038-01-19 03:14:07’)
        - TIME: hh:mm:ss 
    > Booleanos:
		- BOOL: No existe pero se permite -> TINYINT(1)
        - BOOLEAN: No existe pero se permite -> TINYINT(1)
        - TINYINT(1): True = 0 False != 0
        - BIT: False = 0 True = 1
        - CHAR(1): False = 'N'/'F'/'0' True = 'Y'/'T'/'1'
        - ENUM(x,y): El valor depende de lo que se designe a la hora de comprobarlo
    > Enumerados y conjuntos:
		- ENUM(x,y,z,...): Conjunto de valores de texto que permite seleccionar uno de entre las diferentes opciones que se introduzcan
        - SET(x,y,z,...): Conjunto de valores de texto que permite seleccionar varios valores entre las diferentes opciones que se introduzcan
*/

-- Claves y restricciones de borrado(ON DELETE)/ de actualizacion(ON UPDATE):
/*
	CONSTRAINT rnombre_restriccion FOREIGN KEY (columna_tabla) REFERENCES ciudades (columna_foranea) ON DELETE/UPDATE (RESTRICT/NO ACTION/CASCADE/SET NULL)
		- RESTRICT/NO ACTION: Equivale a no poner nada, en el caso de eliminar/actualizar un elemento referenciado no te dejara.
		- CASCADE: En el caso de eliminar/actualizar un elemento referenciado eliminara/actualizara tambien la referencia.
		- SET NULL: En el caso de eliminar/actualizar un elemento referenciado cambiara la referencia a null.
*/

-- Aniadir/eliminar restricciones de integridad de datos
/*
	> Aniadir/eliminar restricciones de integridad de datos: 
		- ALTER TABLE nombre_tabla ADD/DROP CONSTRAIN nombre_constrain;
	> Aniadir/renombrar/modificar/borrar una columna: 
		- ALTER TABLE nombre_tabla ADD/MODIFY nombre_columna tipo_dato;
        - ALTER TABLE nombre_tabla RENAME nombre_columna TO nuevo_nombre;
        - ALTER TABLE nombre_tabla DROP COLUMN nombre_columna;
    > Modificar restricciones a nivel de columna: 
		- ALTER TABLE nombre_tabla ALTER nombre_columna SET DEFAULT nuevo_valor;
        - ALTER TABLE nombre_tabla ALTER nombre_columna DROP DEFAULT;
        - ALTER TABLE nombre_tabla MODIFY nombre_columna tipo_dato_nuevo NOT NULL;
*/

-- Vistas: Tablas virtuales sin contenido que devuelven las filas resultantes de una sentencia SELECT, siendo mas eficientes en tiempo de ejecucion.
/*
	CREATE VIEW nombre_view (campo1, campo2...) AS <sentencia SELECT>;
    DROP VIEW IF EXIST nombre_view;
    ALTER VIEW nombre_view (campo1, campo2...) AS <sentencia SELECT>;
*/
