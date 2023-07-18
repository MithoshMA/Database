SELECT name as Foreign_Key
,schema_name(schema_id) as Schema_Name
,object_name(parent_object_id) as Table_Name
FROM sys.foreign_keys
WHERE Referenced_object_id = object_id('dbo.TblChitTrans','U');

drop TABLE TblChitInfo
drop TABLE TblChitMemberInfo
DROP TABLE TblChitTrans
drop TABLE TblLotDateInfo
drop TABLE TblMembers
DROP table TblAgent
drop table TblSector


CREATE TABLE TblSector
(
  SectorId   VARCHAR(50)    NOT NULL PRIMARY KEY ,
  SectorName VARCHAR(50)    UNIQUE,
  SectorInfo VARCHAR(50),  
);

CREATE TABLE TblMembers
(
  [mem_no]	INT IDENTITY,
  [mem_id_no]          INT           NOT NULL,
  [mem_first_name]  VARCHAR(50)    NOT NULL,
  [mem_last_name]   VARCHAR(50)    DEFAULT '',
  [mem_sector]      VARCHAR(50),
  [mem_mail]        VARCHAR(50)     DEFAULT '',
  [mem_phone]       VARCHAR(16)     DEFAULT '',
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
    agt_status INT DEFAULT 0
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
  [lot_number]              INT,
  [lot_type]                SMALLINT DEFAULT 1, -- 1 normal, 0 muthal
  [lot_taken_status]        SMALLINT DEFAULT 2, -- 1 Closed, 0 Not taken, 2 running
  [lot_winner_no]           INT  DEFAULT NULL,
  [lot_inst_amount]         INT DEFAULT 0,
  [lot_prize_money]          INT DEFAULT NULL,
  [lot_status]            SMALLINT DEFAULT 0,
  CONSTRAINT pk_lotid_no PRIMARY KEY (lot_id_no),
  FOREIGN KEY (lot_winner_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no),  
  FOREIGN KEY (lot_chity_id) REFERENCES TblChitInfo(chit_id),
);
GO

CREATE TABLE TblChitTrans
(
tct_transId INT IDENTITY,
tct_lot_id INT NOT NULL,
tct_lot_no INT,
tct_agent_id INT,
tct_paid_amount INT DEFAULT 0,
tct_due_status SMALLINT DEFAULT 0,
tct_paydate DATETIME,
FOREIGN KEY (tct_lot_id) REFERENCES TblLotDateInfo(lot_id_no),
FOREIGN KEY (tct_lot_no) REFERENCES TblChitMemberInfo(ctmbr_lot_no)
)
