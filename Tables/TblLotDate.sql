drop TABLE TblLotDateInfo
CREATE TABLE TblLotDateInfo
(
  [lot_id_no]	              INT IDENTITY,
  [lot_chity_id]	          VARCHAR(20) DEFAULT '1',
  [lot_date]                DATETIME,
  [lot_number]              INT,
  [lot_type]                SMALLINT DEFAULT 1, -- 1 normal, 0 muthal
  [lot_taken_status]        SMALLINT DEFAULT 0, -- 1 Taken, 0 Not taken
  [lot_winner_no]           INT,
  [lot_pay_amount]          INT DEFAULT 0,
  [lot_status]            SMALLINT DEFAULT 0,
  CONSTRAINT pk_lotid_no PRIMARY KEY (lot_id_no),
  FOREIGN KEY (lot_winner_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no),  
  FOREIGN KEY (lot_chity_id) REFERENCES TblChitInfo(chit_id),
);

SELECT * FROM [dbo].[TblLotDateInfo]

drop view VIW_LOT_TAKEN_DATE
/*CREATE VIEW VIW_LOT_TAKEN_DATE AS
SELECT 
  [lot_chity_id]	  as 'Chits ID',
  [lot_date]   as 'Date',
  [lot_number]   as 'Installment',
  [lot_type]  as 'Type',
  [lot_taken_status] as 'Status',
  [lot_winner_no]   as 'Winner',
  [lot_pay_amount]  as 'Amount'
  from TblLotDateInfo
where 
[lot_status]  = 0 */

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


---UPDATE [dbo].[TblLotDateInfo]
SET
  [lot_taken_status] = 1,
  [lot_type] = 0
  -- Add more columns and values here
WHERE  lot_id_no = 3

GO
select * from VIW_LOT_TAKEN_DATE where [Chits ID] = 'Chit NO 2023/08-A'

-- Insert rows into table 'TableName' in schema '[dbo]'
INSERT INTO [dbo].[TblLotDateInfo]
( -- Columns to insert data into
 [lot_chity_id], [lot_number], [lot_date], [lot_pay_amount]
)
VALUES
( 'Chit NO 2023/08-A', 01, '2023-08-01', 1000),
( 'Chit NO 2023/08-A', 02, '2023-09-01', 1000),
( 'Chit NO 2023/08-A', 03, '2023-10-01', 1000),
( 'Chit NO 2023/08-A', 04, '2023-11-01', 1000),
( 'Chit NO 2023/08-A', 05, '2023-12-01', 1000),
( 'Chit NO 2023/08-A', 06, '2024-01-01', 1000),
( 'Chit NO 2023/08-A', 07, '2024-02-01', 1000),
( 'Chit NO 2023/08-A', 08, '2024-03-01', 1000),
( 'Chit NO 2023/08-A', 09, '2024-04-01', 1000),
( 'Chit NO 2023/08-A', 10, '2024-05-01', 1000),
( 'Chit NO 2023/08-A', 11, '2024-06-01', 1000),
( 'Chit NO 2023/08-A', 12, '2024-07-01', 1000),
( 'Chit NO 2023/08-A', 13, '2024-08-01', 1000),
( 'Chit NO 2023/08-A', 14, '2024-09-01', 1000),
( 'Chit NO 2023/08-A', 15, '2024-10-01', 1000),
( 'Chit NO 2023/08-A', 16, '2024-11-01', 1000),
( 'Chit NO 2023/08-A', 17, '2024-12-01', 1000),
( 'Chit NO 2023/08-A', 18, '2025-01-01', 1000),
( 'Chit NO 2023/08-A', 19, '2025-02-01', 1000),
( 'Chit NO 2023/08-A', 20, '2024-03-01', 1000),
( 'Chit NO 2023/08-A', 21, '2024-04-01', 1000),
( 'Chit NO 2023/08-A', 22, '2024-05-01', 1000),
( 'Chit NO 2023/08-A', 23, '2024-06-01', 1000),
( 'Chit NO 2023/08-A', 24, '2024-07-01', 1000),
( 'Chit NO 2023/08-A', 25, '2024-08-01', 1000),
( 'Chit NO 2023/08-A', 26, '2024-09-01', 1000),
( 'Chit NO 2023/08-A', 26, '2024-10-01', 1000),
( 'Chit NO 2023/08-A', 28, '2024-11-01', 1000),
( 'Chit NO 2023/08-A', 29, '2025-12-01', 1000),
( 'Chit NO 2023/08-A', 30, '2024-01-01', 1000),
( 'Chit NO 2023/08-A', 31, '2024-02-01', 1000),
( 'Chit NO 2023/08-A', 32, '2024-03-01', 1000),
( 'Chit NO 2023/08-A', 33, '2024-04-01', 1000),
( 'Chit NO 2023/08-A', 34, '2024-05-01', 1000),
( 'Chit NO 2023/08-A', 35, '2024-06-01', 1000),
( 'Chit NO 2023/08-A', 36, '2025-07-01', 1000),
( 'Chit NO 2023/08-A', 37, '2025-08-01', 1000);

Select * from TblLotDateInfo

