

GO
DROP table TblWageInfo
GO
CREATE TABLE TblWageInfo
(
wge_id INT IDENTITY,
wge_agent_id INT NOT NULL,
wge_chit_id VARCHAR(20) NOT NULL,
wge_term_no INT NOT NULL,
wge_paid_amount INT DEFAULT 0,
wge_paydate DATETIME,
FOREIGN KEY (wge_chit_id, wge_term_no) REFERENCES TblLotDateInfo(lot_chity_id, lot_term_no),
FOREIGN KEY (cms_agent_id) REFERENCES TblAgent(agt_id)
)



select DISTINCT ctmbr_sector from TblChitMemberInfo

Select ctmbr_sector as 'Sector',  COUNT(ctmbr_lot_no)  from TblChitMemberInfo  group by ctmbr_sector


Select S.SectorName as 'Sector', A.agt_first_name, COUNT(ctmbr_lot_no) from TblChitMemberInfo 
LEFT JOIN TblSector S ON ctmbr_sector =  S.SectorId
LEFT JOIN TblAgent A ON ctmbr_sector = A.agt_sectorId group by ctmbr_sector, A.agt_first_name, S.SectorName


select S.SectorId from TblSector S
select agt_sectorId from TblAgent

Select S.SectorName, agt.agt_sectorId, agt_first_name  from TblSector S
LEFT JOIN TblAgent agt ON S.SectorId = agt.agt_sectorId

Select ctmbr_sector as 'Sector',  COUNT(ctmbr_lot_no)  from TblChitMemberInfo  group by ctmbr_sector


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
DROP VIEW VIEW_WAGE_AGENT_INFO
GO
CREATE VIEW VIEW_WAGE_AGENT_INFO
AS
SELECT S.SectorId as 'Sector ID', S.SectorName as 'Sector', agt.agt_first_name 'Agent First Name', agt.agt_last_name 'Last Name', COUNT(C.ctmbr_lot_no) as 'Member Count' from TblSector S
LEFT JOIN TblAgent agt ON S.SectorId = agt.agt_sectorId
LEFT JOIN TblChitMemberInfo C ON C.ctmbr_sector = S.SectorId group by C.ctmbr_sector, agt.agt_first_name, S.SectorName, S.SectorId, agt.agt_last_name
GO

select * from TblChitTrans
select * from TblChitMemberInfo

select ctmbr_sector, COUNT(ctmbr_sector) ctmbr_sector from TblChitMemberInfo group by ctmbr_sector
select COUNT(ctmbr_sector) ctmbr_sector from TblChitMemberInfo group by ctmbr_sector
select COUNT(tct_lot_no) from TblChitTrans GROUP by tct_term_no



Select TblChitTrans.tct_term_no as 'Term_No', ctmbr_sector as 'Sector', COUNT(ctmbr_sector) as 'Count', COUNT(ctmbr_sector)*1000 as 'Collection' from TblChitMemberInfo 
JOIN TblChitTrans ON TblChitTrans.tct_lot_no = TblChitMemberInfo.ctmbr_lot_no GROUP BY ctmbr_sector,TblChitTrans.tct_term_no 


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

GO
DROP VIEW RPT_VIEW_GET_PAYMENT_INFO
GO
CREATE VIEW RPT_VIEW_GET_PAYMENT_INFO
AS
select V.*, w.wge_paid_amount as 'Received' , V.Commission - w.wge_paid_amount as 'Payable Balance' from VIEW_TERM_WAGE_INFO V
LEFT JOIN tblAgent A ON A.agt_sectorId = V.Sector
LEFT JOIn TblWageInfo W on W.wge_agent_id = A.agt_id and V.[Term No] = W.wge_term_no
GO
select * from TblWageInfo

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


select * from RPT_VIEW_GET_PAYMENT_INFO ORDER BY 'Sector', 'Term No'

select * from RPT_VIEW_GET_PAYMENT_INFO


select Sector, SUM(Count), SUM(Collection), SUM(Collected_Amount), SUM(Balance), SUM(Commission) from VIEW_TERM_WAGE_INFO group by Sector
select Sector, SUM(Count) as 'Collection Count', SUM(Collection) as 'Collection', SUM(Collected_Amount) as 'Collected_Amount', SUM(Balance) as 'Balance', SUM(Commission) as 'Commission' from VIEW_TERM_WAGE_INFO group by Sector



select * from TblAgent
select * from TblSector

select * from TblChitTrans
select * from TblChitMemberInfo
select * from TblWageInfo
SELECT * FROM RPT_VW_AGENTS

INSERT INTO TblWageInfo (wge_agent_id, wge_chit_id, wge_term_no, wge_paid_amount,wge_paydate)
VALUES 
(
    1, 'Chit NO 2023/08-A', 2, 150, '2023-07-27'
)


select V.*, CASE WHEN w.wge_paid_amount IS NULL THEN 0 ELSE w.wge_paid_amount END as 'Received',
V.Commission - (CASE WHEN w.wge_paid_amount IS NULL THEN 0 ELSE w.wge_paid_amount END) as 'Wage Balance',
w.wge_paydate as 'Payment Date' from VIEW_TERM_WAGE_INFO V
LEFT JOIN tblAgent A ON A.agt_sectorId = V.Sector
LEFT JOIn TblWageInfo W on W.wge_agent_id = A.agt_id and V.[Term No] = W.wge_term_no

Select *, null, null FROM VIEW_TERM_WAGE_INFO where Sector = 'AKL_001'
UNION ALL select NULL, NULL, NULL, NULL, NULL, NULL, NULL, wge_paydate, wge_paid_amount from TblWageInfo WHERE wge_agent_id = 1

select * FROM TblWageInfo

Select * from RPT_VIEW_CHIT_TRANS