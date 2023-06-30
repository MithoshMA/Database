drop TABLE TblMembers
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

-- Delete rows from table '[TableName]' in schema '[dbo]'
-- Select rows from a Table or View '[TableOrViewName]' in schema '[dbo]'
SELECT * FROM [dbo].[TblMembers]

--DROP VIEW VW_MEMBERS
CREATE VIEW VW_MEMBERS as SELECT 
[mem_id_no]  as 'Memebr ID',
[mem_first_name] as 'First Name',
[mem_last_name]  as 'Last Name',
(select SectorName from TblSector where TblMembers.mem_sector = TblSector.sectorId)  as 'Sector',
[mem_mail]  as 'Mail ID',
[mem_phone]     as 'Contact'
FROM TblMembers where mem_status = 0;

--DROP VIEW RPT_VW_MEMBERS
CREATE VIEW RPT_VW_MEMBERS as 
SELECT 
[mem_id_no]  as 'Memebr_ID',
[mem_first_name] as 'First_Name',
[mem_last_name]  as 'Last_Name',
(select SectorName from TblSector where TblMembers.mem_sector = TblSector.sectorId)  as 'Sector',
(Select LEFT([mem_mail], 18) ) as 'Mail_ID',
[mem_phone]     as 'Contact'
FROM TblMembers where mem_status = 0;



select * from VW_MEMBERS

-- Insert rows into table 'TableName' in schema '[dbo]'
INSERT INTO [dbo].[TblMembers]
( 
 [mem_id_no], [mem_first_name], [mem_last_name],  [mem_sector],  [mem_mail], [mem_phone]
)
VALUES
( 
 1000, 'Mitosh', 'Mele Areekkal', 'AKL_001', 'ma.mithosh@gmail.com', '819037365198'
),
( -- Second row: values for the columns in the list above
 1050, 'Sajeesh', 'Kunnummal', 'AKL_001', ' ', ' '
)

DELETE FROM TblMembers
INSERT INTO [dbo].[TblMembers]([mem_id_no], [mem_first_name], [mem_last_name],  [mem_sector],  [mem_mail], [mem_phone]) 
VALUES 
(1000, 'Mitosh', 'Mele Areekkal', 'AKL_001', 'ma.mithosh@gmail.com', '819037365198'),
(1050, 'Sajeesh', 'Kunnummal', 'AKL_001', ' ', ' '),


INSERT INTO [dbo].[TblMembers]([mem_id_no], [mem_first_name], [mem_last_name],  [mem_sector],  [mem_mail], [mem_phone]) 
VALUES
(1051, 'Navas', 'NK', 'NYK_001', ' ', ' ')

select TblMembers.mem_id_no, (select SectorName from TblSector where TblMembers.mem_sector = TblSector.sectorId) as 'Sector' from TblMembers
-- Add more rows here
GO

update TblMembers set mem_first_name = 'Mithosh' where mem_id_no = 1000
-- Update rows in table '[TableName]' in schema '[dbo]'
UPDATE [dbo].[TableName]
SET
  [ColumnName1] = ColumnValue1,
  [ColumnName2] = ColumnValue2
  -- Add more columns and values here
WHERE /* add search conditions here */
GO


DELETE FROM TblMembers
INSERT INTO [dbo].[TblMembers]([mem_id_no], [mem_first_name], [mem_last_name],  [mem_sector],  [mem_mail], [mem_phone]) 
VALUES 
(1000, 'Gopinath', 'Mohanlal', 'TPR_001', 'gopinathmohanlal@example.com', '1234567890'),
(1001, 'Mammootty', 'Dulquer', 'AKL_001', 'mammoottydulquer@example.com', '9876543210'),
(1002, 'Prithviraj', 'Fahadh', 'KAK_001', 'prithvirajfahadh@example.com', '4567890123'),
(1003, 'Dileep', 'Nivin', 'NYK_001', 'dileepnivin@example.com', '8901234567'),
(1004, 'Jayasurya', 'Tovino', 'TPR_001', 'jayasuryatovino@example.com', '2345678901'),
(1005, 'Nazriya', 'Manju', 'AKL_001', 'nazriyamanju@example.com', '7654321098'),
(1006, 'Shobana', 'Parvathy', 'KAK_001', 'shobanaparvathy@example.com', '9012345678'),
(1007, 'Kavya', 'Meera', 'NYK_001', 'kavyameera@example.com', '3456789012'),
(1008, 'Keerthy', 'Rima', 'TPR_001', 'keerthyrima@example.com', '6789012345'),
(1009, 'Asha', 'Sobhana', 'AKL_001', 'ashasobhana@example.com', '8901234567'),
(1010, 'Shobha', 'Rekha', 'KAK_001', 'shobharekha@example.com', '1234567890'),
(1011, 'Jayaram', 'Indrajith', 'NYK_001', 'jayaramindrajith@example.com', '9876543210'),
(1012, 'Nayanthara', 'Bhavana', 'TPR_001', 'nayantharabhavana@example.com', '4567890123'),
(1013, 'Aishwarya', 'Unni', 'AKL_001', 'aishwaryaunni@example.com', '8901234567'),
(1014, 'Vineeth', 'Nedumudi', 'KAK_001', 'vineethnedumudi@example.com', '2345678901'),
(1015, 'Mukesh', 'Sreenivasan', 'NYK_001', 'mukeshsreenivasan@example.com', '7654321098'),
(1016, 'Nandini', 'Iniya', 'TPR_001', 'nandiniiniya@example.com', '9012345678'),
(1017, 'Anu', 'Srinda', 'AKL_001', 'anusrinda@example.com', '3456789012'),
(1018, 'Surabhi', 'Saranya', 'KAK_001', 'surabhisaranya@example.com', '6789012345'),
(1019, 'Sangeetha', 'KPAC', 'NYK_001', 'sangeethakpac@example.com', '8901234567'),
(1020, 'Kalaranjini', 'Remya', 'TPR_001', 'kalaranjiniremya@example.com', '1234567890'),
(1021, 'Sreenithi', 'Ramya', 'AKL_001', 'sreenithiramya@example.com', '9876543210'),
(1022, 'Anupama', 'Aparna', 'KAK_001', 'anupamaaparna@example.com', '4567890123'),
(1023, 'Namitha', 'Rajisha', 'NYK_001', 'namitharajisha@example.com', '8901234567'),
(1024, 'Malavika', 'Manjima', 'TPR_001', 'malavikamanjima@example.com', '2345678901'),
(1025, 'Anusree', 'Miya', 'AKL_001', 'anusreemiya@example.com', '7654321098'),
(1026, 'Nyla', 'Gayathri', 'KAK_001', 'nylagayathri@example.com', '9012345678'),
(1027, 'Pearle', 'Sruthi', 'NYK_001', 'pearlesruthi@example.com', '3456789012'),
(1028, 'Saniya', 'Hima', 'TPR_001', 'saniyahima@example.com', '6789012345'),
(1029, 'Thomas', 'Nivin', 'AKL_001', 'thomasnivin@example.com', '8901234567'),
(1030, 'Vinayakan', 'Soubin', 'KAK_001', 'vinayakansoubin@example.com', '1234567890'),
(1031, 'Fahadh', 'Shane', 'NYK_001', 'fahadhsane@example.com', '9876543210'),
(1032, 'Dileesh', 'Suraj', 'TPR_001', 'dileeshsuraj@example.com', '4567890123'),
(1033, 'Biju', 'Roshan', 'AKL_001', 'bijuroshan@example.com', '8901234567'),
(1034, 'Asif', 'Sreenath', 'KAK_001', 'asifsreenath@example.com', '2345678901'),
(1035, 'Aju', 'Chemban', 'NYK_001', 'ajuchemban@example.com', '7654321098'),
(1036, 'Indrans', 'Sudheer', 'TPR_001', 'indranssudheer@example.com', '9012345678'),
(1037, 'Siju', 'Kalabhavan', 'AKL_001', 'sijukalabhavan@example.com', '3456789012'),
(1038, 'Saiju', 'Salim', 'KAK_001', 'saijusalim@example.com', '6789012345'),
(1039, 'Basil', 'Hareesh', 'NYK_001', 'basilhareesh@example.com', '8901234567'),
(1040, 'Rahman', 'Dharmajan', 'TPR_001', 'rahmandharmajan@example.com', '1234567890'),
(1041, 'Mamukoya', 'Harisree', 'AKL_001', 'mamukoyaharisree@example.com', '9876543210'),
(1042, 'Guinness', 'Bineesh', 'KAK_001', 'guinnessbineesh@example.com', '4567890123'),
(1043, 'Mukundan', 'Vinod', 'NYK_001', 'mukundanvinod@example.com', '8901234567'),
(1044, 'Ramesh', 'Aju', 'TPR_001', 'rameshaju@example.com', '2345678901'),
(1045, 'Sreejith', 'Tini', 'AKL_001', 'sreejithtini@example.com', '7654321098')


