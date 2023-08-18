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
[mem_id_no]  as 'Member_ID',
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
  [chit_no]  as 'Chit_No',
  [chit_id]  as 'Chit_ID',
  [chit_name]  as 'Name',
  [chit_amount]  as 'Chit_Amount',
  [chit_month_amt]     as 'Inst_Amount',
  [chit_member_count]  as 'Member_Count',
  [chit_lot_start]    as 'Start_No',
  (select convert(varchar, [chit_start_dt] , 106)) as 'Date',
  [chit_duration]     as 'Inst_Count',
  [chit_auction_date] as 'Lot_Date',
  CASE WHEN [chit_condition] = 1 THEN 'Closed' 
  WHEN [chit_condition] = 2 THEN 'Cancelled'
  ELSE 'Active' END AS 'Condition',
  [chit_agt_comission] as 'Commission'  
  from TblChitInfo
  where chit_status = 0;
GO

/* 5 TblChitMemberInfoDraft */
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

GO
DROP VIEW RPT_VW_CHIT_MEMBER_INFO
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
  A.ctmbr_due_count as 'Due_Count',
  B.mem_phone as 'Contact',
  AG.agt_first_name + ' ' + AG.agt_last_name as 'Agent'
  FROM TblChitMemberInfo A
  LEFT JOIN TblMembers B ON A.ctmbr_mbr_id = B.mem_id_no
  LEFT JOIN TblSector T ON T.sectorId = A.ctmbr_sector
  LEFT JOIN TblAgent AG ON AG.agt_sectorId = A.ctmbr_sector
GO

/* 6 TblLotDateInfo */
GO
DROP VIEW RPT_VIW_LOT_TAKEN_DATE
GO
CREATE VIEW RPT_VIW_LOT_TAKEN_DATE AS
SELECT 
  A.[lot_chity_id]	  as 'Chit_ID',  
  [lot_term_no]   as 'Installment',
  (select convert(varchar, [lot_date] , 34)) as 'Date',  
  A.lot_winner_no as 'Win_Lot_No',
  C.mem_first_name +' ' + C.mem_last_name  as 'Winner',
  [lot_inst_amount]  as 'Amount',
  [lot_prize_money]  as 'Prize_Money',
  CASE WHEN [lot_taken_status] = 1 THEN 'Active' ELSE 'Closed' END as 'Status'
  from TblLotDateInfo A
  LEFT JOIN TblChitMemberInfo B ON A.lot_winner_no = B.ctmbr_lot_no
  LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no
GO
/* 6 TblChitTrans */

-- VIEW 
DROP VIEW RPT_VIEW_CHIT_TRANS 
GO
CREATE VIEW RPT_VIEW_CHIT_TRANS 
AS
SELECT
A.tct_term_no as 'Term_Number' ,
A.tct_lot_no as 'Lot_no',
--(select convert(varchar, [L].[lot_date] , 1)) as 'LOT_Date',
[L].[lot_date]as 'LOT_Date',
C.ctmbr_mbr_id as 'Memebr_ID',
M.mem_first_name as 'First_Name',
M.mem_last_name as 'Last_Name',
S.SectorName as 'Sector_Name',
L.lot_inst_amount as 'Inst_Amount',
A.tct_paid_amount  as 'Paid_Amount',
CAST((L.lot_inst_amount -A.tct_paid_amount) as INT) as 'Balance',
Ag.agt_first_name + ' ' + Ag.agt_last_name as 'Agent_Name'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo C ON A.tct_lot_no = C.ctmbr_lot_no
LEFT JOIN TblMembers M ON C.ctmbr_mbr_id = M.mem_id_no
LEFT JOIN TblLotDateInfo L ON A.lot_chity_id = L.lot_chity_id and A.tct_term_no = L.lot_term_no
LEFT JOIN TblSector S ON C.ctmbr_sector = S.sectorId
LEFT JOIN TblAgent AG ON C.ctmbr_sector = AG.agt_sectorId
--LEFT JOIN TblAgent AG ON A.tct_agent_id = AG.agt_id TODO - Optimize
GO

/* TODO need to OPTIMIZE */
GO
DROP VIEW RPT_VIEW_WAGE_AGENT_INFO
GO
CREATE VIEW RPT_VIEW_WAGE_AGENT_INFO
AS
SELECT S.SectorId, S.SectorName, agt.agt_first_name, agt.agt_last_name, COUNT(C.ctmbr_lot_no) as 'Member_Count' from TblSector S
LEFT JOIN TblAgent agt ON S.SectorId = agt.agt_sectorId
LEFT JOIN TblChitMemberInfo C ON C.ctmbr_sector = S.SectorId group by C.ctmbr_sector, agt.agt_first_name, S.SectorName, S.SectorId, agt.agt_last_name
GO


GO
DROP VIEW VIEW_TERM_WAGE_INFO
GO
CREATE VIEW VIEW_TERM_WAGE_INFO
AS
Select 
T.tct_term_no as 'Term No',
ctmbr_sector as 'Sector',
COUNT(ctmbr_sector) as 'Count', 
COUNT(ctmbr_sector)*1000 as 'Collection', 
SUM(T.tct_paid_amount) as 'Collected_Amount', 
COUNT(ctmbr_sector)*1000  - SUM(T.tct_paid_amount)  as 'Balance',
 SUM(T.tct_paid_amount) * 0.03 as 'Commission' from TblChitMemberInfo 
JOIN TblChitTrans T ON T.tct_lot_no = TblChitMemberInfo.ctmbr_lot_no  GROUP BY ctmbr_sector, T.tct_term_no


GO
DROP VIEW RPT_VIEW_GET_PAYMENT_INFO
GO
CREATE VIEW RPT_VIEW_GET_PAYMENT_INFO
AS
select V.*, CASE WHEN w.wge_paid_amount IS NULL THEN 0 ELSE w.wge_paid_amount END as 'Received',
V.Commission - (CASE WHEN w.wge_paid_amount IS NULL THEN 0 ELSE w.wge_paid_amount END) as 'Wage Balance',
w.wge_paydate as 'Payment Date' from VIEW_TERM_WAGE_INFO V
LEFT JOIN tblAgent A ON A.agt_sectorId = V.Sector
LEFT JOIn TblWageInfo W on W.wge_agent_id = A.agt_id and V.[Term No] = W.wge_term_no
GO



GO
DROP VIEW RPT_VIEW_AGENT_TRANS_SUM 
GO
CREATE VIEW RPT_VIEW_AGENT_TRANS_SUM 
AS
SELECT * FROM 
(
SELECT
S.SectorName as 'Sector', 
AG.agt_first_name + ' ' + AG.agt_last_name as 'Agent',
--(select convert(varchar, A.agt_trans_date , 106)) as 'Date',
A.agt_trans_date as 'Date',
---A.agt_trans_remarks as 'Remarks', /* TODO */
'Payment for term XXX' as Remarks,
NULL as 'Term', 
CASE
    WHEN agt_trans_type = 1 THEN agt_amount
    ELSE NULL
END as 'Debit',

CASE
    WHEN agt_trans_type = 0 THEN agt_amount
    ELSE NULL
END as 'Credit'
FROM TblAgentTrans A
JOIN TblAgent AG ON A.agt_id = AG.agt_id 
LEFT JOIN TblSector S ON S.SectorId = AG.agt_sectorId

UNION ALL
Select Ts.SectorName as 'Sector', 
A.agt_first_name + ' ' + A.agt_last_name as 'Agent',
--(select convert(varchar, L.lot_date , 106)) as 'Date',
 L.lot_date as 'Date',
--'Commission for Term : ' + CAST(C.tct_term_no AS varchar) as 'Remarks', 
'Commission for Term : ' as 'Remarks', 
C.tct_term_no as 'Term', 
NULL as 'Debit', 
-- COUNT(*), 
 SUM([c].[tct_paid_amount]) * CT.chit_agt_comission*.01 as 'Credit' 
 from TblChitTrans C 
LEFT JOIN TblChitMemberInfo CM ON  CM.ctmbr_lot_no = C.tct_lot_no 
LEFT JOIN TblSector TS ON TS.SectorId = CM.ctmbr_sector
LEFT JOIN TblAgent A ON A.agt_sectorId = TS.SectorId
LEFT JOIN TblChitInfo CT ON CT.chit_id = C.lot_chity_id
LEFT JOIN TblLotDateInfo L ON L.lot_chity_id = C.lot_chity_id and L.lot_term_no = C.tct_term_no
GROUP BY CM.ctmbr_sector, Ts.SectorName, CT.chit_agt_comission,C.tct_term_no,L.lot_date, A.agt_first_name,A.agt_last_name 
) as Agent_trasn_sum

GO
DROP VIEW RPT_VIEW_TRANS_SUMMARY
GO
CREATE VIEW RPT_VIEW_TRANS_SUMMARY 
AS
SELECT 
CT.Inst, 
CT.[Count], 
Count *CH.chit_month_amt*1.00 as 'Collection',
CT.Collected * 1.00 as 'Collected', 
1.00*Count *CH.chit_month_amt - CT.Collected as 'Due',
CH.chit_agt_comission * Collected*.01 as 'Commission',
L.lot_prize_money*1.00 as 'Prize_Money',
--Count *CH.chit_month_amt - (CH.chit_agt_comission * Collected*.01 + L.lot_prize_money) as 'Balance',
CASE 
    WHEN L.lot_prize_money IS NULL THEN
        CT.Collected - (CH.chit_agt_comission * Collected*.01) 
  ELSE 
    CT.Collected - (CH.chit_agt_comission * Collected*.01 + L.lot_prize_money) 
  END as 'Revenue'
from 
    (
        Select 
    C.tct_term_no, C.lot_chity_id,
    C.tct_term_no as 'Inst', 
    COUNT(C.tct_term_no) as 'Count',
    SUM(C.tct_paid_amount) as 'Collected'
    from TblChitTrans C
    GROUP BY C.tct_term_no, c.lot_chity_id
    ) as CT
LEFT JOIN TblChitInfo CH ON CH.chit_id = CT.lot_chity_id 
LEFT JOIN TblLotDateInfo L ON CH.chit_id = L.lot_chity_id AND CT.tct_term_no = L.lot_term_no
GO

GO
DROP VIEW RPT_VIEW_TRANS_SUMMARY_SUM
GO
CREATE VIEW RPT_VIEW_TRANS_SUMMARY_SUM 
AS
SELECT SUM(Collection) as Collection, SUM(Collected)  as Collected, SUM(Due)  as Due, SUM(Commission) as Commission, SUM(Prize_Money)  as Prize_Money, SUM(Revenue) as Revenue FROM RPT_VIEW_TRANS_SUMMARY
GO
