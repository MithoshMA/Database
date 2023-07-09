drop TABLE TblChitMemberDraft
GO
CREATE TABLE TblChitMemberDraft
(
  [ctmbr_no]	            INT IDENTITY PRIMARY KEY,
  [ctmbr_chit_no]           INT UNIQUE,
  [ctmbr_mbr_id]            INT,
  FOREIGN KEY (ctmbr_mbr_id) REFERENCES TblMembers(mem_id_no),  
);

SELECT * FROm TblChitMemberDraft


GO
DROP VIEW RPT_VW_CHIT_MEM_DRAFT
GO
CREATE VIEW RPT_VW_CHIT_MEM_DRAFT
AS
SELECT
ctmbr_chit_no as 'Chit_No',
ctmbr_mbr_id as 'Member_ID',
M.mem_first_name as 'First_Name',
M.mem_last_name as 'Last_Name'
 FROM TblChitMemberDraft C
 LEFT JOIN TblMembers M ON C.ctmbr_mbr_id = M.mem_id_no
GO

 SELECT * FROM RPT_VW_CHIT_MEM_DRAFT
 

DECLARE @numRows int,@i int
SET @numRows = 100
SET @i=1

WHILE @i<@numRows
BEGIN
    INSERT TblChitMemberDraft(ctmbr_chit_no) SELECT @i
    SET @i=@i+1
END

GO
DROP PROCEDURE UpdateTblChitMemberDraft
GO
CREATE PROCEDURE UpdateTblChitMemberDraft
@row_count int,
@start_no int
AS
DECLARE @i INT
TRUNCATE TABLE TblChitMemberDraft
SET @i = 0
WHILE @i<@row_count
BEGIN
    INSERT TblChitMemberDraft(ctmbr_chit_no) SELECT @start_no+@i
    SET @i=@i+1
END

SELECT * FROM TblChitMemberDraft
TRUNCATE TABLE TblChitMemberDraft

EXECUTE UpdateTblChitMemberDraft 100,1000