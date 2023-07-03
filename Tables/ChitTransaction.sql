/*

Transaction ID	
Participant ID	
Contribution	
Amount Paid	Balance
*/

select * from VW_DUE_DETAILS


DROP table TblChitTrans
CREATE TABLE TblChitTrans
(
tct_transId INT IDENTITY,
tct_lot_id INT NOT NULL,
tct_lot_no INT,
tct_paid_amount INT DEFAULT 0,
tct_due_status SMALLINT DEFAULT 0,
FOREIGN KEY (tct_lot_id) REFERENCES TblLotDateInfo(lot_id_no),
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
A.tct_lot_no as 'Lot_No',
(select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
B.ctmbr_mbr_id as 'Memebr_ID',
C.mem_first_name as 'First_Name',
C.mem_last_name as 'Last_Name',
S.SectorName as 'Sector_Name',
L.lot_pay_amount as 'Inst_Amount',
A.tct_paid_amount as 'Paid_Amount',
CAST((L.lot_pay_amount -A.tct_paid_amount) as INT) as 'Balance'
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