-- Table TblUserGroup

-- Drop table TblUserGroup
--CREATE TABLE TblUserGroup
(
ug_id INT IDENTITY PRIMARY KEY,
ug_name varchar(30) UNIQUE NOT NULL,
ug_flag smallint default 0)

SELECT
  *
FROM
  INFORMATION_SCHEMA.TABLES;
GO

 sp_columns   TblUserGroup
select * from TblUserGroup

insert into TblUserGroup (ug_name) VALUES ('Mithosh MA')
insert into TblUserGroup (ug_name) VALUES ('Sachin T') 

select ug_id as 'ID', ug_name as 'Name',  ug_flag as 'Active' from TblUserGroup

drop view UserName
create view UserName as select ug_id as 'ID', ug_name as 'Name' from TblUserGroup where ug_flag = 0;

select * from  UserName


SELECT * FROM TblChitTrans 

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
AGC.agt_status as 'Agent_Name'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
LEFT JOIN TblAgents AGC ON A.tct_agent_id = AGC.agt_id

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
A.tct_agent_id as 'Agent',
AGC.mem_first_name as 'Agent_Name'
FROM TblChitTrans A
LEFT JOIN TblChitMemberInfo B ON A.tct_lot_no = B.ctmbr_lot_no
LEFT JOIN TblMembers C ON B.ctmbr_mbr_id = C.mem_id_no 
LEFT JOIN TblLotDateInfo L ON A.tct_lot_id = L.lot_id_no
LEFT JOIN TblSector S ON B.ctmbr_sector = S.sectorId
LEFT JOIN TblMembers AGC ON tct_agent_id = AGC.mem_id_no

Select tct_agent_id, COUNT(tct_agent_id) from TblChitTrans group by tct_agent_id