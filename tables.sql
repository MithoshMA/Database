CREATE DATABASE testDb on (name = 'testDb', filename = 'C:\mit\C#\TestDb\TestDb.mdf')

-- Table: userdetail
drop table TransactionDetails;
drop table ChittyGLDetails;
DROP TABLE Chittytermmaster;
drop table ChittyType;
DROP TABLE userdetail;
DROP TABLE customermaster;




CREATE TABLE userdetail
(
  userid integer NOT NULL,
  useraname character varying(50),
  userpassword character varying(50),
  userright integer,
  userrightname character varying(50),
  status integer,
  CONSTRAINT pk_userid PRIMARY KEY (userid),
  CONSTRAINT "Uc_Username" UNIQUE (useraname)
);




CREATE TABLE customermaster
(
  customerid integer NOT NULL,
  customername character varying(50),
  address character varying(100),
  phonenumber integer,
  adharnumber integer,
  gender character varying(5),
  status integer,
  CONSTRAINT customermaster_pkey PRIMARY KEY (customerid),
  CONSTRAINT customermaster_adharnumber_key UNIQUE (adharnumber)
);


Create table ChittyType(
ChittyTermID int	,
Name	varchar(50),
status int default 0
);




-- Table: Chittytermmaster



CREATE TABLE Chittytermmaster
(
  Chittytermid integer NOT NULL,
  Chittytermname character varying(50) NOT NULL,
  Chittybegindate date,
  lotday character varying(50),
  lottime time,
  installamount integer,
  noofinstallement integer,
  Chittyamount integer,
  livestatus integer,
  status integer,
  CONSTRAINT Chittytermmaster_pkey PRIMARY KEY (Chittytermid),
  CONSTRAINT Chittytermmaster_Chittytermname_key UNIQUE (Chittytermname)
);



Create table ChittyGLDetails(
ChittyGLId serial PRIMARY KEY,	
Customerid  integer references customermaster(Customerid), 
Groupid int, 
ChittyTermID  integer references Chittytermmaster(ChittyTermID) ,   
Chittynumber int ,	
TotalPaid int,	
Balance	int,
LastTransDate date,	
Lotstatus int default 0	,
LotDate	date,
suretyCustomerid1 integer references customermaster(Customerid)	,
Suretycustomerid2 integer references customermaster(Customerid)	,
Remarks	varchar(50),
status	int default 0
);																												---

--table transactiondetails




Create table TransactionDetails(
transactionid serial PRIMARY KEY,
transactiondate date,
transactionAmount int,	
ChittyGLId  integer references ChittyGLDetails(ChittyGLId)	,
Ontimeflag time,	
Remarks	varchar(50),
status	int default 0,
userid int  references userdetail(userid)
);					
