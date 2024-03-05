#PERFILES

Los perfiles permiten limitar los recursos que los usuarios usan al conectarse con la base de datos. Puede limitar el uso de CPU, máximo número de bloques leídos por sesión, minutos máximos de inactividad entre otros. 

Por defecto la Limitación de Recursos esta inhabilitada, debemos activar esta funcionalidad.

---------------------------------------
-- 1. CONSULTANDO LIMITACION DE RECURSOS
---------------------------------------
SELECT NAME , VALUE FROM V$PARAMETER 
WHERE UPPER ( NAME ) = 'RESOURCE_LIMIT';

---------------------------------------
-- 2. ACTIVANDO LIMITACION DE RECURSOS
---------------------------------------
ALTER SYSTEM SET RESOURCE_LIMIT = TRUE;

LIMITACIONES EN CONTRASEÑAS
RECURSO	DETALLE
FAILED_LOGIN_ATTEMPTS	Número consecutivo de errores en las contraseñas antes de bloquear la cuenta. Por defecto son 10
PASSWORD_LOCK_TIME	Número de días hasta que se bloquea una cuenta si se supera el límite de intentos al INGRESAR una contraseña. Por defecto es uno
PASSWORD_LIFE_TIME	Números de días que tiene vigencia una contraseña. Por defecto es 180
PASSWORD_GRACE_TIME	
Días que la contraseña se la concede un periodo extra de gracia tras consumir su tiempo de vida. Por defecto es 7

PASSWORD_REUSE_TIME	Número de días que una contraseña puede ser reutilizada



LIMITACIONES DE RECURSOS
SESSIONS_PER_USER	Número de conexiones de usuario concurrentes que se permiten.
CPU_PER_SESSION	Límite de tiempo (en centésimas de segundo) que se permite a un usuario utilizar la CPU antes de ser echado del sistema. De esa forma se evitan peligros de rendimiento
CPU_PER_CALL	Como la anterior pero referida a cada proceso
CONNECT_TIME	Minutos como máximo que se permite a una sesión
IDLE_TIME	Minutos máximos de inactividad de una sesión
LOGICAL_READS_PER_SESSION	Máximo número de bloques leídos en una sesión
LOGICAL_READS_PER_CALL	Máximo número de bloques leídos por un proceso

-----------------------------------------
-- 3. CREANDO UN PERFIL
-----------------------------------------
CREATE PROFILE OPERADOR LIMIT
        --Máximo # de conexiones
        SESSIONS_PER_USER 1
        -- Tiempo en minutos sin operar, para eliminar la sesión  
        IDLE_TIME 2
        -- Minutos máximos de conexión
        CONNECT_TIME 4
        -- Número de ingresos errados para bloquear el usuario
        FAILED_LOGIN_ATTEMPTS 3
        -- Número de días que tiene vigencia una contraseña
        PASSWORD_LOCK_TIME 30;


------------------------------------------------
-- 4. CREAR USUARIO Y ASIGNARLE ROL DE OPERADOR
------------------------------------------------

CREATE USER MARIA IDENTIFIED BY 123;

GRANT DBA TO MARIA;

ALTER USER MARIA PROFILE OPERADOR; 

 
------------------------------------------------
-- 5. NUMERO DE CONEXIONES POR USUARIOS
------------------------------------------------

SELECT USERNAME USUARIO_ORACLE, COUNT(USERNAME) NUMERO_SESIONES
FROM V$SESSION
GROUP BY USERNAME
ORDER BY NUMERO_SESIONES DESC;

-----------------------------------------
-- 5. MODIFICANDO EL PERFIL
-----------------------------------------
ALTER PROFILE OPERADOR LIMIT
        --Máximo # de conexiones
        SESSIONS_PER_USER 2
        -- Tiempo en minutos sin operar, para eliminar la sesión  
        IDLE_TIME 1
        -- Minutos máximos de conexión
        CONNECT_TIME 2
        -- Número de ingresos errados para bloquear el usuario
        FAILED_LOGIN_ATTEMPTS 3
        -- Número de días que tiene vigencia una contraseña
        PASSWORD_LOCK_TIME 30;

-----------------------------------------
-- 6. ELIMINAR EL PERFIL
-----------------------------------------
DROP PROFILE OPERADOR;
  	
