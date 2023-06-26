drop TABLE TblChitInfo
CREATE TABLE TblChitInfo
(
  [chit_no]	                INT IDENTITY,
  [chit_id]                 VARCHAR(20)    NOT NULL,
  [chit_name]               VARCHAR(50)    DEFAULT '',
  [chit_amount]             INT,
  [chit_month_amt]          INT,
  [chit_member_count]       INT,
  [chit_lot_start]          INT,
  [chit_start_dt]           DATETIME,
  [chit_duration]           SMALLINT DEFAULT 1,
  [chit_auction_date]       SMALLINT DEFAULT 1,
  [chit_condition]          SMALLINT DEFAULT 0,
  [chit_status]             SMALLINT DEFAULT 0,
  CONSTRAINT pk_chit_no PRIMARY KEY (chit_no),
  CONSTRAINT pk_chit_id UNIQUE(chit_id),  
);

-- Delete rows from table '[TableName]' in schema '[dbo]'
-- Select rows from a Table or View '[TableOrViewName]' in schema '[dbo]'
SELECT * FROM [dbo].[TblChitInfo]


CREATE VIEW VIW_CHIT_INFO as SELECT 
  [chit_id]  as 'Chits ID',
  [chit_name]  as 'Chits Name',
  [chit_amount]  as 'Chits Amount',
  [chit_month_amt]     as 'Montly Amount',
  [chit_member_count]  as 'Memeber Count',
  [chit_lot_start]    as 'Start No',
  [chit_start_dt]     as 'Start Date',
  [chit_duration]     as 'Duration',
  [chit_auction_date] as 'Lot Date',
  [chit_condition]    as 'Condition'
  from TblChitInfo
  where chit_status = 0;

  select *from VIW_CHIT_INFO
  --delete from TblChitInfo
  insert into TblChitInfo 
  (
    [chit_id], [chit_name], [chit_amount], [chit_month_amt], [chit_member_count], [chit_lot_start], [chit_start_dt], [chit_duration], [chit_auction_date], [chit_condition]
  )
  VALUES
  ('Chit NO 2023/08-A', 'Sahaya', 1000*36, 1000, 46, 1000, '2023/08/01 00:00:00', 36, 1, 1)
