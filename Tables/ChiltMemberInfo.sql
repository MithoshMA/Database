drop TABLE TblChitMemberInfo
CREATE TABLE TblChitMemberInfo
(
  [ctmbr_no]	              INT IDENTITY,
  [ctmbr_lot_no]            INT,
  [ctmbr_mbr_id]            INT,
  [ctmbr_sector]            VARCHAR(50),
  [ctmbr_win_sts]           INT DEFAULT 0,
  [ctmbr_due_count]         INT DEFAULT 0,
  [ctmbr_status]            SMALLINT DEFAULT 0,
  CONSTRAINT pk_ctmbr_no PRIMARY KEY (ctmbr_no),
  CONSTRAINT pk_ctmbr_id UNIQUE(ctmbr_lot_no),
  FOREIGN KEY (ctmbr_mbr_id) REFERENCES TblMembers(mem_id_no),  
  FOREIGN KEY (ctmbr_sector) REFERENCES TblSector(sectorId),  
);

-- Delete rows from table '[TableName]' in schema '[dbo]'
-- Select rows from a Table or View '[TableOrViewName]' in schema '[dbo]'
SELECT * FROM [dbo].[TblChitMemberInfo]

--DROP VIEW VW_CHIT_MEMBER_INFO
--https://www.w3schools.com/mysql/mysql_join.asp
GO
CREATE VIEW VW_CHIT_MEMBER_INFO
(
  SELECT 
  A.ctmbr_lot_no    as 'Lot No',
  B.mem_first_name as 'First Name',
  B.mem_last_name as 'Last Name',
  B.mem_id_no as 'Member ID',
  (SELECT SectorName from TblSector where TblSector.sectorId = A.ctmbr_sector) as 'Sector',
  A.ctmbr_win_sts   as 'Win staus',
  A.ctmbr_due_count as 'Due Count'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
)
GO

SELECT * FROM RPT_VW_CHIT_MEMBER_INFO

--DROP VIEW RPT_VW_CHIT_MEMBER_INFO
--https://www.w3schools.com/mysql/mysql_join.asp
GO
CREATE VIEW RPT_VW_CHIT_MEMBER_INFO
as
  SELECT 
  A.ctmbr_lot_no    as 'Lot_No',
  B.mem_first_name as 'First_Name',
  B.mem_last_name as 'Last_Name',
  B.mem_id_no as 'Member_ID',
  (SELECT SectorName from TblSector where TblSector.sectorId = A.ctmbr_sector) as 'Sector',
  A.ctmbr_win_sts   as 'Win_Staus',
  A.ctmbr_due_count as 'Due_Count'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
GO

SELECT * from VW_CHIT_MEMBER_INFO
SELECT * from RPT_VW_CHIT_MEMBER_INFO

delete from TblChitMemberInfo
-- Insert rows into table 'TableName' in schema '[dbo]'
INSERT INTO [dbo].[TblChitMemberInfo]
( -- Columns to insert data into
 [ctmbr_lot_no]
)
VALUES
(1000),
(1001),
(1002),
(1003),
(1004),
(1005)

INSERT INTO [dbo].[TblChitMemberInfo]
( -- Columns to insert data into
 [ctmbr_lot_no], [ctmbr_mbr_id]
)
VALUES (1007, 1004)


select * from TblChitMemberInfo

update TblChitMemberInfo set ctmbr_sector = 'AKL_001' where ctmbr_mbr_id = 1004
update TblChitMemberInfo set ctmbr_sector = 'KAK_001' where ctmbr_mbr_id = 1000

update TblChitMemberInfo set ctmbr_mbr_id = 1000 where ctmbr_no = 7
update TblChitMemberInfo set ctmbr_mbr_id = 1001 where ctmbr_no = 8
update TblChitMemberInfo set ctmbr_mbr_id = 1002 where ctmbr_no = 9
update TblChitMemberInfo set ctmbr_mbr_id = 1003 where ctmbr_no = 10
update TblChitMemberInfo set ctmbr_mbr_id = 1004 where ctmbr_no = 11
update TblChitMemberInfo set ctmbr_mbr_id = 1005 where ctmbr_no = 12
update TblChitMemberInfo set ctmbr_mbr_id = 1005 where ctmbr_no = 12

update TblChitMemberInfo set ctmbr_win_sts = 0 

update TblChitMemberInfo set ctmbr_lot_no = ctmbr_lot_no * 10

SELECT * from TblChitMemberInfo order by ctmbr_lot_no
INSERT INTO TblChitMemberInfo (ctmbr_mbr_id, ctmbr_lot_no, ctmbr_sector) 
select mem_id_no, mem_id_no -999, 
CASE
WHEN (mem_id_no % 4) = 0 then 'AKL_001'
WHEN (mem_id_no % 4) = 1 then 'KAK_001'
WHEN (mem_id_no % 4) = 2 then 'NYK_001'
WHEN (mem_id_no % 4) = 3 then 'TPR_001'
ELSE 'TPR_001'
END as 'Sector'
from TblMembers


SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'TblChitMemberInfo'

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'RPT_VW_CHIT_MEMBER_INFO' 

SELECT C.ctmbr_lot_no FROM  TblChitMemberInfo C
JOIN TblLotDateInfo L ON C.ctmbr_lot_no = L.lot_winner_no

SELECT CASE
WHEN Lot_No % 2 = 0 then NULL ELSE Lot_No END as 'Lot_No' from RPT_VW_CHIT_MEMBER_INFO 

--DROP VIEW RPT_VW_CHIT_MEMBER_INFO
--https://www.w3schools.com/mysql/mysql_join.asp
GO
CREATE VIEW RPT_VW_CHIT_MEMBER_INFO
as

  SELECT 
  A.ctmbr_lot_no    as 'Lot_No',
  B.mem_first_name as 'First_Name',
  B.mem_last_name as 'Last_Name',
  B.mem_id_no as 'Member_ID',
  T.SectorName as 'Sector',  
  CASE
        WHEN A.ctmbr_win_sts = 0 
            THEN NULL 
            ELSE 'YES' 
　END as 'Win_Staus' ,
  A.ctmbr_due_count as 'Due_Count'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
  LEFT JOIN TblSector T ON T.sectorId = A.ctmbr_sector