-- 1
-- Crear el usuario USER300, asignarle privilegios de 
-- apertura de SESSION y se permita crear tablas que le 
-- pertenecen a dicho usuario. Confírmelo.

CREATE USER USER300 IDENTIFIED BY 123
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE TABLE , CREATE SESSION TO USER300;

-- 2
-- Conectado como el USER300, compruebe el privilegio 
-- asignado creando la tabla ARTICULO

CREATE TABLE ARTICULO ( ID INTEGER, NOMBRE  CHAR(50));


-- 3
-- Conectado como el USER300, cree la tabla SCOTT.CATEGORIA 
-- con un solo campo. ¿Qué sucede? ¿Por qué?

CREATE TABLE HR.CATEGORIA ( NOMBRE  CHAR(50));

-- 4
-- Asignarle los privilegios necesarios a USER300 para 
-- crear tablas de cualquier esquema. ( ANY ). Crear la 
-- tabla SCOTT.CATEGORIA con el campo NOMBRE CHAR(50).

GRANT CREATE ANY TABLE TO USER300;

CREATE TABLE HR.CATEGORIA ( NOMBRE  CHAR(50));

-- 5
-- Crear el usuario nombrado como PRODUCCION el que tendrá 
-- privilegios para crear nuevos usuarios, crear sesión, 
-- crear tablas con opciones de ceder estos privilegios a 
-- otros usuarios.

CREATE USER PRODUCCION IDENTIFIED BY 123
DEFAULT TABLESPACE USERS
QUOTA UNLIMITED ON USERS;

GRANT CREATE USER, CREATE TABLE, CREATE SESSION 
TO PRODUCCION WITH ADMIN OPTION;

 
#PRIVILEGIOS DE OBJETOS

-- 6
-- Asignarle al usuario USER300  privilegios de consulta 
-- sobre la tabla HR.EMPLOYEES

GRANT SELECT ON HR.EMPLOYEES TO USER300;

-- 7
-- Asignarle al usuario USER300 privilegios de consulta, 
-- inserción y actualización sobre la tabla HR.REGIONS

GRANT SELECT , INSERT, UPDATE , DELETE ON HR.REGIONS TO USER300;


-- 8
-- Quitar el privilegio de inserción sobre la tabla 
-- HR.RGIONS al usuario “USER300”
REVOKE SELECT ON SCOTT.EMP FROM USER300;




-- MANEJO DE ROLES

#ROLES

---------------
-- 1. ROLES 
---------------
CREATE ROLE JEFATURA NOT IDENTIFIED;

-----------------------------------------
-- 2. ASIGNANDO PRIVILEGIOS A LOS ROLES 
-----------------------------------------
GRANT SELECT, INSERT, UPDATE ON HR.JOBS TO JEFATURA;
GRANT CREATE SESSION TO JEFATURA01;

CREATE USER USER500 IDENTIFIED BY 123;

GRANT JEFATURA TO USER500;

-- Conéctese como USER500 y compruebe que el rol cedió los
-- privilegios de JEFATURA.

SELECT * FROM HR.JOBS;




