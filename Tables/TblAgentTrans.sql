SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TblAgent'

select * from TblAgent
select * from TblSector
select * from TblChitInfo
select * from TblAgentTrans
select * from TblLotDateInfo
select * from VIEW_TERM_WAGE_INFO where Sector = 'KKU_002'



select * from RPT_VIEW_GET_PAYMENT_INFO
select * from RPT_VIEW_GET_PAYMENT_INFO

INSERT INTO TblAgentTrans (agt_id, agt_trans_chit_id, agt_amount,agt_trans_date)
VALUES 
(1, 'Chit NO 2023/08-A', 300, '2023-08-08')

INSERT INTO TblAgentTrans (agt_id, agt_trans_chit_id, agt_amount,agt_trans_date)
VALUES
(1, 'Chit NO 2023/08-A', 300, '2023-09-09'), 
(2, 'Chit NO 2023/08-A', 300, '2023-09-09'),
(3, 'Chit NO 2023/08-A', 300, '2023-09-09')

Select * FROM RPT_VIEW_AGENT_TRANS_SUM ORDER BY 'Date'
select * from RPT_VIEW_GET_PAYMENT_INFO ORDER BY 'Sector', 'Term No'

Select  * FROM RPT_VIEW_AGENT_TRANS_SUM ORDER BY 'Date'
Select * FROM RPT_VIEW_AGENT_TRANS_SUM ORDER BY 'Date'
Select Sector FROM RPT_VIEW_AGENT_TRANS_SUM ORDER BY Sector

Select  * FROM RPT_VIEW_AGENT_TRANS_SUM ORDER BY 'Date'
GO
 WHERE Sector = 'Mele Areekkal' order by 'Date'


select * from  RPT_VIEW_CHIT_TRANS


select * from TblMembers
select  ROW_NUMBER() OVER(ORDER BY mem_id_no), mem_id_no, mem_first_name from TblMembers