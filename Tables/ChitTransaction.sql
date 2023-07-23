/*

Transaction ID	
Participant ID	
Contribution	
Amount Paid	Balance
*/
GO
DROP table TblChitTrans
GO
CREATE TABLE TblChitTrans
(
tct_transId INT IDENTITY,
lot_chity_id VARCHAR(20),
tct_term_no INT NOT NULL,
tct_lot_no INT,
tct_agent_id INT,
tct_paid_amount INT DEFAULT 0,
tct_due_status SMALLINT DEFAULT 0,
tct_paydate DATETIME,
FOREIGN KEY (lot_chity_id, tct_term_no) REFERENCES TblLotDateInfo(lot_chity_id, lot_term_no),
FOREIGN KEY (tct_lot_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no)
)

insert into TblChitTrans (tct_lot_id, tct_lot_no)
select tct_lot_id, tct_lot_no from TblChitTrans

select * from TblChitTrans
--delete from TblChitTrans

SELECT * FROM
(
SELECT
A.tct_lot_no as 'Lot_No',
(select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
B.ctmbr_mbr_id as 'Memebr ID',
C.mem_first_name as 'First_Name',
C.mem_last_name as 'Last_Name',
L.lot_pay_amount as 'Inst Amount',
A.tct_paid_amount as 'Paid Amount',
CAST((L.lot_pay_amount -A.tct_paid_amount) as INT) as 'Balance'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
)
as X where x.Balance > 0


update TblChitTrans set tct_paid_amount = 1000 where tct_lot_no IN(1004, 1007)

-- VIEW 
DROP VIEW RPT_VIEW_CHIT_TRANS 
GO
CREATE VIEW RPT_VIEW_CHIT_TRANS 
AS
SELECT
L.lot_number as 'Installment',
A.tct_lot_no as 'Lot_No',
(select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
B.ctmbr_mbr_id as 'Memebr_ID',
C.mem_first_name as 'First_Name',
C.mem_last_name as 'Last_Name',
S.SectorName as 'Sector_Name',
L.lot_inst_amount as 'Inst_Amount',
A.tct_paid_amount as 'Paid_Amount',
CAST((L.lot_inst_amount -A.tct_paid_amount) as INT) as 'Balance'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
GO

/* TODO need to OPTIMIZE */
GO
DROP VIEW RPT_VIEW_CHIT_TRANS_DUE
GO
CREATE VIEW RPT_VIEW_CHIT_TRANS_DUE
AS
    SELECT * FROM 
    (
    SELECT
    L.lot_number as 'Installment',
    A.tct_lot_no as 'Lot_No',
    (select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
    B.ctmbr_mbr_id as 'Memebr_ID',
    C.mem_first_name as 'First_Name',
    C.mem_last_name as 'Last_Name',
    S.SectorName as 'Sector_Name',
    L.lot_inst_amount as 'Inst_Amount',
    A.tct_paid_amount as 'Paid_Amount',
    CAST((L.lot_inst_amount - A.tct_paid_amount) as INT) as 'Balance'
    FROM TblChitTrans A
    LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
    LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
    LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
    LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
    ) as due_list WHERE due_list.Balance > 0;
GO

/* TODO need to OPTIMIZE */
DROP VIEW RPT_VIEW_CHIT_TRANS_NO_DUE
GO
CREATE VIEW RPT_VIEW_CHIT_TRANS_NO_DUE
AS
SELECT * FROM 
(
    SELECT
    L.lot_number as 'Installment',
    A.tct_lot_no as 'Lot_No',
    (select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
    B.ctmbr_mbr_id as 'Memebr_ID',
    C.mem_first_name as 'First_Name',
    C.mem_last_name as 'Last_Name',
    S.SectorName as 'Sector_Name',
    L.lot_inst_amount as 'Inst_Amount',
    A.tct_paid_amount as 'Paid_Amount',
    CAST((L.lot_inst_amount - A.tct_paid_amount) as INT) as 'Balance'
    FROM TblChitTrans A
    LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
    LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
    LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
    LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
) as due_list WHERE due_list.Balance = 0;
GO

select * from RPT_VIEW_CHIT_TRANS_DUE
select * from RPT_VIEW_CHIT_TRANS
select * from RPT_VIEW_CHIT_TRANS_NO_DUE



---with sector.
 SELECT * FROM 
    (
    SELECT
    A.tct_lot_no as 'Lot_No',
    (select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
    B.ctmbr_mbr_id as 'Memebr_ID',
    C.mem_first_name as 'First_Name',
    C.mem_last_name as 'Last_Name',
    S.SectorName as 'Sector_Name',
    L.lot_pay_amount as 'Inst_Amount',
    A.tct_paid_amount as 'Paid_Amount',
    CAST((L.lot_pay_amount - A.tct_paid_amount) as INT) as 'Balance'
    FROM TblChitTrans A
    LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
    LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
    LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
    LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
    ) as due_list WHERE due_list.Balance = 0;



/* GROUP BY */
SELECT First_Name, Last_Name, Sector_Name, COUNT(First_Name) as 'Count', SUM(Balance) as 'Amount' FROM 
    (
    SELECT
    A.tct_lot_no as 'Lot_No',
    (select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
    B.ctmbr_mbr_id as 'Memebr_ID',
    C.mem_first_name as 'First_Name',
    C.mem_last_name as 'Last_Name',
    S.SectorName as 'Sector_Name',
    L.lot_pay_amount as 'Inst_Amount',
    A.tct_paid_amount as 'Paid_Amount',
    CAST((L.lot_pay_amount - A.tct_paid_amount) as INT) as 'Balance'
    FROM TblChitTrans A
    LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
    LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
    LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
    LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
    ) as due_list WHERE due_list.Balance <> 0 GROUP BY  First_Name, Last_Name, Sector_Name order by count ASC; 


select * from TblChitTrans

TRUNCATE TABLE TblChitTrans
delete from TblChitTrans

DECLARE @lotno INT
SET @lotno = 4
INSERT INTO TblChitTrans (tct_lot_id, tct_lot_no) 
SELECT @lotno, ctmbr_lot_no FROM TblChitMemberInfo
where ctmbr_lot_no NOT IN (
SELECT C.ctmbr_lot_no FROM  TblChitMemberInfo C
JOIN TblLotDateInfo L ON C.ctmbr_lot_no = L.lot_winner_no)


SELECT ctmbr_lot_no, ctmbr_lot_no FROM TblChitMemberInfo
WHERE ctmbr_lot_no NOT IN (
SELECT C.ctmbr_lot_no FROM  TblChitMemberInfo C
JOIN TblLotDateInfo L ON C.ctmbr_lot_no = L.lot_winner_no)


---UPDATE TblChitTrans SET tct_paydate = '2023/07/05', tct_paid_amount = 1000, tct_due_status = 1, tct_agent_id = 1 WHERE tct_lot_no = 1003 and tct_lot_id = (SeleCT lot_id_no from TblLotDateInfo where [lot_number] = 1 and  [lot_date] = (select convert(varchar, '2023-08-01' , 1)) )
GO
UPDATE TblChitTrans
SET tct_paydate = '2023/07/05', 
tct_paid_amount = 1000,
tct_due_status = 1,
tct_agent_id = 1
WHERE tct_lot_no = 1003 and tct_lot_id = 
(SeleCT lot_id_no from TblLotDateInfo where [lot_number] = 2 and  [lot_date] = (select convert(varchar, '2023-08-01' , 1)) )


GO
--Try
DROP VIEW RPT_VIEW_CHIT_TRANS_NO_DUE
GO
CREATE VIEW RPT_VIEW_CHIT_TRANS_NO_DUE
AS
SELECT * FROM 
(
    SELECT
    L.lot_number as 'Installment',
    A.tct_lot_no as 'Lot_No',
    (select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
    B.ctmbr_mbr_id as 'Memebr_ID',
    C.mem_first_name as 'First_Name',
    C.mem_last_name as 'Last_Name',
    S.SectorName as 'Sector_Name',    
    L.lot_pay_amount as 'Inst_Amount',
    A.tct_paid_amount as 'Paid_Amount',
    CAST((L.lot_pay_amount - A.tct_paid_amount) as INT) as 'Balance',
    AGC.mem_first_name + ' ' + AGC.mem_last_name as 'Agent_Name'
    FROM TblChitTrans A
    LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
    LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
    LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
    LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
    LEFT JOIN TblAgents AG ON S.sectorId = AG.agt_sectorId
    LEFT JOIN TblMembers AGC ON AG.agt_memb_id = AGC.mem_id_no
    
) as due_list WHERE due_list.Balance = 0;
GO


SELECT tct_lot_id, L.lot_number From TblChitTrans C
LEFT JOIN TblLotDateInfo L ON C.tct_lot_id = L.lot_id_no


SELECT * From TblChitTrans C


select * from RPT_VIEW_CHIT_TRANS
select * from RPT_VIEW_CHIT_TRANS_NO_DUE

