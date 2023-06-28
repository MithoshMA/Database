/*

Transaction ID	
Participant ID	
Contribution	
Amount Paid	Balance


*/

select * from TblChitTrans
--update TblChitTrans set tct_amount_paid = 1000, tct_due_status = 1 where tct_transId = 4
DROP TABLE TblChitTrans
CREATE TABLE TblChitTrans
(
tct_transId INT IDENTITY,
tct_mem_id INT,
tct_lot_id INT NOT NULL,
tct_lot_no INT,
tct_amount_paid INT DEFAULT 0,
tct_due_status SMALLINT DEFAULT 0,
FOREIGN KEY (tct_lot_id) REFERENCES TblLotDateInfo(lot_id_no),
FOREIGN KEY (tct_mem_id) REFERENCES TblMembers(mem_id_no),
FOREIGN KEY (tct_lot_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no)
)

INSERT INTO TblChitTrans (tct_lot_id, tct_lot_no, tct_mem_id)
Select 1, ctmbr_lot_no, ctmbr_mbr_id from TblChitMemberInfo where ctmbr_win_sts = 0;

Declare @VAL INT;
SET @VAL = 0

SELECT
A.tct_lot_no as 'Lot No',
B.lot_date as 'LOT Date',
B.lot_number as 'Installment No',
C.mem_first_name as 'First Name',
C.mem_last_name as 'Last Name',
A.tct_amount_paid as 'AmountPaid'
FROM TblChitTrans A
LEFT JOIN  TblLotDateInfo B ON A.tct_lot_id = B.lot_id_no
LEFt JOIN TblMembers C
ON A.tct_mem_id = C.mem_id_no
WHERE A.tct_due_status = @VAL and tct_lot_id = 1 order by 'First Name';


