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
  B.mem_last_name as 'Second Name',
  B.mem_id_no as 'Member ID',
  (SELECT SectorName from TblSector where TblSector.sectorId = A.ctmbr_sector) as 'Sector',
  A.ctmbr_win_sts   as 'Win staus',
  A.ctmbr_due_count as 'Due Count'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
)
GO

select * from VW_CHIT_MEMBER_INFO
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

