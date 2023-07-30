CREATE DATABASE testDb on (name = 'testDb', filename = 'C:\mit\C#\TestDb\TestDb.mdf')

-- Table: userdetail
DROP TABLE userdetail;


CREATE TABLE userdetail
(
  userid integer NOT NULL,
  useraname character varying(50),
  userpassword character varying(50),
  userright integer,
  userrightname character varying(50),
  status integer,
  CONSTRAINT pk_userid PRIMARY KEY (userid),
  CONSTRAINT "Uc_Username" UNIQUE (useraname)
);

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'TblMembers'

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TblMembers'



SELECT DISTINCT 'Select * FROM ', TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS


SELECT name as Foreign_Key
,schema_name(schema_id) as Schema_Name
,object_name(parent_object_id) as Table_Name
FROM sys.foreign_keys
WHERE Referenced_object_id = object_id('dbo.TblSector','U');


GO
CREATE VIEW V_TBLE_FKEY
AS
SELECT 
OBJECT_NAME(F.parent_object_id) AS 'Child Table',
COL_NAME(FC.parent_object_id, FC.parent_column_id) AS 'Child Column',
OBJECT_NAME(FC.referenced_object_id) AS 'Parent Table',
COL_NAME(FC.referenced_object_id, FC.referenced_column_id) AS 'Parent Column'
FROM sys.foreign_keys AS F
INNER JOIN sys.foreign_key_columns AS FC
ON F.OBJECT_ID = FC.constraint_object_id
--WHERE OBJECT_NAME (F.referenced_object_id) = 'TblSector'
--ORDER BY OBJECT_NAME(F.parent_object_id)
GO
Select * from V_TBLE_FKEY WHERE [Parent Table] = 'TblMembers'
Select * from V_TBLE_FKEY WHERE [Child Table] = 'TblMembers'

SELECT COLUMN_NAME, DATA_TYPE, [T].[Parent Table] + '(' + [T].[Parent Column] + ')' as 'FK'
FROM INFORMATION_SCHEMA.COLUMNS S
LEFT JOIN V_TBLE_FKEY T ON [T].[Child Column] = S.COLUMN_NAME WHERE S.TABLE_NAME = 'TblMembers'


SELECT * FROM INFORMATION_SCHEMA.COLUMNS
UNION ALL
EXEC sp_fkeys 'TblMembers'

sp_help 'TblMembers'