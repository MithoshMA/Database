/* 1 TblSector */

GO
DROP VIEW RPT_VIEW_SECTOR_INFO
GO
CREATE VIEW RPT_VIEW_SECTOR_INFO
AS
SELECT SectorId as 'SectorID',
SectorName as 'Sector_Name',
SectorInfo as 'Sector_Info' FROM TblSector
GO

/* 2 TblAgent */

GO
DROP VIEW RPT_VW_AGENTS
GO
CREATE VIEW RPT_VW_AGENTS as
SELECT 
A.agt_id,
A.agt_no as 'Agent No',
A.agt_first_name as 'First_Name',
A.agt_last_name as 'Last_Name',
S.SectorName as 'Sector',
A.agt_phone_no as 'Phone'
FROM TblAgent A
LEFT JOIN TblSector S ON A.agt_sectorId = S.SectorId
GO

/* 3 TblMembers */
DROP VIEW RPT_VW_MEMBERS
GO
CREATE VIEW RPT_VW_MEMBERS as 
SELECT 
[mem_id_no]  as 'Memebr_ID',
[mem_first_name] as 'First_Name',
[mem_last_name]  as 'Last_Name',
(select SectorName from TblSector where TblMembers.mem_sector = TblSector.SectorId)  as 'Sector',
(Select LEFT([mem_mail], 18) ) as 'Mail_ID',
[mem_phone]     as 'Contact'
FROM TblMembers where mem_status = 0;
GO

/* 4 TblChitInfo */
GO
DROP VIEW VIW_CHIT_INFO;
GO
CREATE VIEW VIW_CHIT_INFO
AS
SELECT 
  [chit_id]  as 'Chit_ID',
  [chit_name]  as 'Name',
  [chit_amount]  as 'Chits_Amount',
  [chit_month_amt]     as 'Inst_Amount',
  [chit_member_count]  as 'Memeber_Count',
  [chit_lot_start]    as 'Start_No',
  (select convert(varchar, [chit_start_dt] , 1)) as 'Date',
  [chit_duration]     as 'Inst_Count',
  [chit_auction_date] as 'Lot_Date',
  CASE WHEN [chit_condition] = 1 THEN 'Running' ELSE 'Closed' END AS 'Condition'
  from TblChitInfo
  where chit_status = 0;
GO

/* 5 TblChitMemberInfo */
DROP VIEW VW_CHIT_MEMBER_INFO
GO
CREATE VIEW VW_CHIT_MEMBER_INFO
AS
SELECT 
  A.ctmbr_lot_no    as 'Lot No',
  B.mem_first_name as 'First Name',
  B.mem_last_name as 'Second Name',
  B.mem_id_no as 'Member ID',
  (SELECT SectorName from TblSector where TblSector.SectorId = A.ctmbr_sector) as 'Sector',
  A.ctmbr_win_sts   as 'Win staus',
  A.ctmbr_due_count as 'Due Count'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
GO

/* 6 TblLotDateInfo */
DROP VIEW VIW_LOT_TAKEN_DATE
GO
CREATE VIEW VIW_LOT_TAKEN_DATE AS
SELECT 
  A.[lot_chity_id]	  as 'Chits ID',  
  [lot_number]   as 'Installment',
  (select convert(varchar, [lot_date] , 1)) as 'Date',
  CASE WHEN [lot_type] = 1 THEN 'Normal' ELSE 'Muthal' END AS 'Chit Type',
  [lot_taken_status] as 'Status',
  C.mem_first_name +' ' + C.mem_last_name  as 'Winner',
  [lot_pay_amount]  as 'Amount'
  from TblLotDateInfo A
  LEFT JOIN TblChitMemberInfo B ON A.lot_winner_no = B.ctmbr_lot_no
  LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no
where 
[lot_status]  = 0 
GO

/* 6 TblChitTrans */

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
L.lot_pay_amount as 'Inst_Amount',
A.tct_paid_amount as 'Paid_Amount',
CAST((L.lot_pay_amount -A.tct_paid_amount) as INT) as 'Balance',
AG.agt_first_name as 'Agent Name'
--AGC.mem_first_name + ' ' + AGC.mem_last_name as 'Agent_Name'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
LEFT JOIN TblSector S ON B.ctmbr_sector = S.SectorId
LEFT JOIN TblAgent AG ON A.tct_agent_id = AG.agt_no
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
        L.lot_pay_amount as 'Inst_Amount',
        A.tct_paid_amount as 'Paid_Amount',
        CAST((L.lot_pay_amount -A.tct_paid_amount) as INT) as 'Balance',
        AG.agt_first_name as 'Agent Name'
        --AGC.mem_first_name + ' ' + AGC.mem_last_name as 'Agent_Name'
        FROM TblChitTrans A
        LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
        LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
        LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
        LEFT JOIN TblSector S ON B.ctmbr_sector = S.SectorId
        LEFT JOIN TblAgent AG ON A.tct_agent_id = AG.agt_no
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
        L.lot_pay_amount as 'Inst_Amount',
        A.tct_paid_amount as 'Paid_Amount',
        CAST((L.lot_pay_amount -A.tct_paid_amount) as INT) as 'Balance',
        AG.agt_first_name as 'Agent Name'
        --AGC.mem_first_name + ' ' + AGC.mem_last_name as 'Agent_Name'
        FROM TblChitTrans A
        LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
        LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
        LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
        LEFT JOIN TblSector S ON B.ctmbr_sector = S.SectorId
        LEFT JOIN TblAgent AG ON A.tct_agent_id = AG.agt_no
) as due_list WHERE due_list.Balance = 0;
GO