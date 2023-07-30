SELECT name as Foreign_Key
,schema_name(schema_id) as Schema_Name
,object_name(parent_object_id) as Table_Name
FROM sys.foreign_keys
WHERE Referenced_object_id = object_id('dbo.TblSector','U');

drop TABLE TblWageInfo
DROP TABLE TblChitTrans
drop TABLE TblChitMemberDraft
drop TABLE TblLotDateInfo
drop TABLE TblChitMemberInfo
drop TABLE TblMembers
DROP table TblAgent
drop TABLE TblChitInfo
drop table TblSector

GO
CREATE TABLE TblSector
(
  SectorId   VARCHAR(50)    NOT NULL PRIMARY KEY ,
  SectorName VARCHAR(50)    UNIQUE,
  SectorInfo VARCHAR(50),  
);
GO
CREATE TABLE TblMembers
(
  [mem_no]	INT IDENTITY,
  [mem_id_no]          INT           NOT NULL,
  [mem_first_name]  VARCHAR(50)    NOT NULL,
  [mem_last_name]   VARCHAR(50)    DEFAULT '',
  [mem_sector]      VARCHAR(50),
  [mem_mail]        VARCHAR(50)     DEFAULT '',
  [mem_phone]       VARCHAR(32)     DEFAULT '',
  [mem_status] SMALLINT DEFAULT 0,
  CONSTRAINT pk_mem_id PRIMARY KEY (mem_no),
  CONSTRAINT pk_mem_id_no UNIQUE(mem_id_no),
  FOREIGN KEY (mem_sector) REFERENCES  TblSector(sectorId),
);
GO
CREATE TABLE TblAgent
(
    agt_id INT IDENTITY,
    agt_no INT,
    agt_sectorId   VARCHAR(50),
    agt_first_name   NVARCHAR(50),
    agt_last_name   NVARCHAR(50),
    agt_phone_no   NVARCHAR(20),
    agt_status INT DEFAULT 0,
    CONSTRAINT PK_AGENT_ID PRIMARY KEY (agt_id),
    FOREIGN KEY (agt_sectorId) REFERENCES  TblSector(sectorId),
);

GO

GO
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

GO
CREATE TABLE TblChitMemberDraft
(
  [ctmbr_no]	            INT IDENTITY PRIMARY KEY,
  [ctmbr_chit_no]           INT UNIQUE,
  [ctmbr_mbr_id]            INT,
  FOREIGN KEY (ctmbr_mbr_id) REFERENCES TblMembers(mem_id_no),  
);

GO
DROP PROCEDURE UpdateTblChitMemberDraft
GO
CREATE PROCEDURE UpdateTblChitMemberDraft
@row_count int,
@start_no int
AS
DECLARE @i INT
TRUNCATE TABLE TblChitMemberDraft
SET @i = 0
WHILE @i<@row_count
BEGIN
    INSERT TblChitMemberDraft(ctmbr_chit_no) SELECT @start_no+@i
    SET @i=@i+1
END

GO
CREATE TABLE TblChitMemberInfo
(
  [ctmbr_no]	              INT IDENTITY,
  [ctmbr_lot_no]            INT,
  [ctmbr_mbr_id]            INT,
  [ctmbr_sector]            VARCHAR(50),
  [ctmbr_win_sts]           INT DEFAULT 0,
  [ctmbr_due_count]         INT DEFAULT 0,
  [ctmbr_status]            SMALLINT DEFAULT 0,
  CONSTRAINT pk_ctmbr_no PRIMARY KEY (ctmbr_no),
  CONSTRAINT pk_ctmbr_id UNIQUE(ctmbr_lot_no),
  FOREIGN KEY (ctmbr_mbr_id) REFERENCES TblMembers(mem_id_no),  
  FOREIGN KEY (ctmbr_sector) REFERENCES TblSector(sectorId),  
);


GO
CREATE TABLE TblLotDateInfo
(
  [lot_id_no]	              INT IDENTITY,
  [lot_chity_id]	          VARCHAR(20) DEFAULT '1',
  [lot_date]                DATETIME,
  [lot_term_no]             INT,
  [lot_type]                SMALLINT DEFAULT 1, -- 1 normal, 0 muthal
  [lot_taken_status]        SMALLINT DEFAULT 1, -- 1 Active, 0 Closed
  [lot_winner_no]           INT  DEFAULT NULL,
  [lot_inst_amount]         INT DEFAULT 0,
  [lot_prize_money]          INT DEFAULT NULL,
  [lot_status]            SMALLINT DEFAULT 0,
  --CONSTRAINT pk_lotid_no PRIMARY KEY (lot_id_no),
  CONSTRAINT un_chit_term PRIMARY KEY (lot_chity_id, lot_term_no),
  FOREIGN KEY (lot_winner_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no),  
  FOREIGN KEY (lot_chity_id) REFERENCES TblChitInfo(chit_id),
);
GO


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


GO
DROP PROCEDURE UpdateChitTransInfo
GO
CREATE PROCEDURE UpdateChitTransInfo
@chit_id VARCHAR(50),
@lot_term_no int
AS
INSERT INTO TblChitTrans (lot_chity_id, tct_term_no, tct_lot_no) 
SELECT @chit_id, @lot_term_no, ctmbr_lot_no FROM TblChitMemberInfo
where ctmbr_lot_no NOT IN (
SELECT C.ctmbr_lot_no FROM  TblChitMemberInfo C
JOIN TblLotDateInfo L ON C.ctmbr_lot_no = L.lot_winner_no)
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
FOREIGN KEY (wge_agent_id) REFERENCES TblAgent(agt_id)
)







EXECUTE UpdateChitTransInfo 'Chit NO 2023/08-A',1
--

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'TblChitTrans'

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'TblLotDateInfo'

SELECT A.TABLE_NAME, COLUMN_NAME, DATA_TYPE, B.CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.COLUMNS A
LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS B ON A.TABLE_NAME = B.TABLE_NAME
WHERE A.TABLE_NAME = 'TblLotDateInfo'

SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS WHERE TABLE_NAME = 'TblLotDateInfo' AND CONSTRAINT_TYPE = 'constraint_type';