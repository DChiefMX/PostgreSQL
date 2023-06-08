---  Script to create a new Databases + schema + roles and logins

--- Logins to be created for each Database: 
-- 1) app_downer
-- 2) wiresauroraapp_usr
-- 3) wiresauroraread_usr

-- Roles to be created
--1) ownr role 
--2) dml role
--3) read_role



-----------------------------------------------------------------
-- DB creation
-----------------------------------------------------------------
CREATE DATABASE wiresaurora;

-----------------------------------------------------------------
-- Login creation
-----------------------------------------------------------------
-- DB owner
CREATE ROLE app_downer WITH LOGIN encrypted PASSWORD 'Changemel' NOSUPERUSER INHERIT NOCREATED NOCREATEROLE NOREPLICATION;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM public;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM app_downer;
GRANT app_downer to master;

-- App Login
CREATE ROLE wiresauroraapp_usr WITH LOGIN encrypted PASSWORD 'Changemel' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM wiresauroraapp_usr;
-- DB read
CREATE ROLE wiresauroraread_usr WITH LOGIN encrypted PASSWORD 'Changemel' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM wiresauroraread_usr;



-----------------------------------------------------------------
--DB Roles
-----------------------------------------------------------------
REVOKE ALL ON DATABASE wiresaurora FROM public;
GRANT ALL ON database wiresaurora TO master;

REVOKE ALL ON SCHEMA public FROM public;
GRANT ALL ON schema public To master:

-----------------------------------------------------------------
-- Roles creation
--1) ownr role
--2) dml role
--3) read_role
-----------------------------------------------------------------

CREATE ROLE wiresaurora_ownr_role NOLOGIN NOINHERIT;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM wiresaurora_ownr_role;
REVOKE ALL ON SCHEMA public FROM wiresaurora_ownr_role;

CREATE ROLE wiresaurora_dm_role NOLOGIN NOINHERIT;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM wiresaurora_dm_role ;
REVOKE ALL ON SCHEMA public FROM wiresaurora_dm_role;

CREATE ROLE wiresaurora_read_role NOLOGIN NOINHERIT;
REVOKE ALL PRIVILEGES ON SCHEMA PUBLIC FROM wiresaurora_read_role;
REVOKE ALL ON SCHEMA public FROM wiresaurora_read_role;

-----------------------------------------------------------------
--Role Privileges
-----------------------------------------------------------------
GRANT wiresaurora_ownr_role to app_dbowner;
GRANT wiresaurora_dm_role to wiresauroraapp_usr;
GRANT Wiresaurora_read_role to waresauroraredo_Ust

-----------------------------------------------------------------
-- Database level Privs
-----------------------------------------------------------------
GRANT CONNECT TEMPORARY ON DATABASE wiresaurora TO wiresaurora_ownr_role;
GRANT CONNECT TEMPORARY ON DATABASE Wiresaurora TO wiresaurora_dm_role;
GRANT CONNECT, TEMPORARY ON DATABASE wiresaurora TO wiresaurora_read_role;
GRANT ALL ON DATABASE wiresaurora TO wiresaurora_ownr_role;
GRANT ALL ON DATABASE wiresaurora TO master WITH GRANT option;
ALTER DATABASE wiresaurora OWNER TO app_dbowner;




-----------------------------------------------------------------
-- schema Creation
-----------------------------------------------------------------
create schema devschema;
REVOKE ALL ON SCHEMA devschema FROM public;

GRANT ALL ON SCHEMA devschema TO wiresaurora_own_role;
GRANT ALL ON SCHEMA devschema TO rds_superuser WITH GRANT OPTION;
GRANT USAGE ON SCHEMA devschema TO wiresaurora_dm_role;
GRANT USAGE ON SCHEMA devschema 10 wiresaurora__read_role;

-----------------------------------------------------------------
-- Schema level Privs
-----------------------------------------------------------------
SET ROLE app_dbowner;
GRANT ALL ON ALL TABLES IN SCHEMA devschema TO RDS_SUPERUSER WITH GRANT OPTION;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA devschema TO wiresaurora_ ownr_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA devschema TO wiresaurora_dm_role;
GRANT SELECT ON ALL TABLES IN SCHEMA devschema TO wiresaurora_read_role;

GRANT ALL ON ALL SEQUENCES IN SCHEMA devschema TO RDS_SUPERUSER WITH GRANT OPTION;
GRANT ALL ON ALL SEQUENCES IN SCHEMA devschema TO wiresaurora_ownr_role;
GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA devschema TO wiresaurora_dml_role;
GRANT SELECT, USAGE ON ALL SEQUENCES IN SCHEMA devschema TO wiresaurora read role;

GRANT ALL ON ALL FUNCTIONS IN SCHEMA devschema TO RDS_SUPERUSER WITH GRANT OPTION;
GRANT ALL ON ALL FUNCTIONS IN SCHEMA devschema TO wiresaurora_ownr_role;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA devschema TO wiresaurora_dm_role,


ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT ALL PRIVILEGES ON TABLES TO RDS_SUPERUSER WITH GRANT OPTION;
ALTER DEFAULTPRIVILEGES IN SCHEMA devschema
    GRANT ALL PRIVILEGES ON SEQUENCES TO RDS_SUPERUSER WITH GRANT OPTION;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT ALL PRIVILEGES ON FUNCTION TO RDS_SUPERUSER WITH GRANT OPTION;

ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT ALL ON TABLES TO wiresaurora_ownr_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT ALL ON SEQUENCES TO wiresaurora_ownr_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT ALL ON FUNCTIONS TO wiresaurora_ownr_role;


ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT INSERT, SELECT, UPDATE, DELETE ON TABLES TO wiresaurora_dmL_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT SELECT, USAGE ON SEQUENCES TO wiresaurora_dml_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT EXECUTE ON FUNCTIONS T0 wiresaurora_dml_role;



ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT SELECT ON TABLES TO wiresaurora_read_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT SELECT ON SEQUENCES TO wiresaurora_read_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA devschema
    GRANT EXECUTE ON FONCTIONS TO wiresaurora_read_role;

-----------------------------------------------------------------
-- Set Search Path
-----------------------------------------------------------------

SET ROLE master;
ALTER DAtABASE wiresaurora SET search path = devschema:
ALTER SCHEMA devschema owner to app_dbowner;

SET ROLE app_dbowner;
GRANT ALL ON database wiresaurora TO master;

-----------------------------------------------------------------
--END
-----------------------------------------------------------------