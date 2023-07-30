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


Select * FROM 	RPT_VIEW_CHIT_TRANS
Select * FROM 	RPT_VIEW_CHIT_TRANS_DUE
Select * FROM 	RPT_VIEW_SECTOR_INFO
Select * FROM 	RPT_VIW_LOT_TAKEN_DATE
Select * FROM 	RPT_VW_AGENTS
Select * FROM 	RPT_VW_CHIT_MEM_DRAFT
Select * FROM 	RPT_VW_CHIT_MEMBER_INFO
Select * FROM 	RPT_VW_MEMBERS
Select * FROM 	RPT_VW_MEMBERS1
Select * FROM 	TblAgent
Select * FROM 	TblChitInfo
Select * FROM 	TblChitMemberDraft
Select * FROM 	TblChitMemberInfo
Select * FROM 	TblChitTrans
Select * FROM 	TblLotDateInfo
Select * FROM 	TblMembers
Select * FROM 	TblSector
Select * FROM 	TblSectorMl
Select * FROM 	TblUserGroup
Select * FROM 	TblWageInfo
Select * FROM 	UserName
Select * FROM 	VIW_CHIT_INFO
Select * FROM 	VW_CHIT_MEMBER_INFO
Select * FROM 	VW_MEMBERS

SELECT DISTINCT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS where TABLE_NAME LIKE 'Tbl%'
