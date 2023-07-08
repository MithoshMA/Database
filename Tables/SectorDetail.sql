

--Sector details

drop table TblSector
CREATE TABLE TblSector
(
  sectorId   VARCHAR(50)    NOT NULL PRIMARY KEY ,
  SectorName VARCHAR(50)    UNIQUE,
  SectorInfo VARCHAR(50),  
);

GO
DROP VIEW RPT_VIEW_SECTOR_INFO
GO
CREATE VIEW RPT_VIEW_SECTOR_INFO
AS
SELECT sectorId as 'SectorID',
SectorName as 'Sector_Name',
SectorInfo as 'Sector_Info' FROM TblSector
GO

SELECT * FROM RPT_VIEW_SECTOR_INFO

select * from TblSector

select * from TblSector
insert into TblSector (sectorId, SectorName, SectorInfo) values ('TPR_001', 'Tholpara North', 'North side of Tholpara');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('AKL_001', 'Areekkal', 'Areekkal side from Narayanakkunnu');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('NYK_001', 'Narayanakunnu', 'Narayanakkunnu from Areekkal side to Kalathingal');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('KAK_001', 'Kallaramkettil', 'Kallaramkettu from Areekkal side to Kalathingal');

update TblSectorMl set SectorInfo = N'മേലെ അരീക്കൽ' where sectorId = 'AKL_002'

--Delete from  TblSector where sectorId = 'AKL_002'

SELECT sectorId as 'SectorID',
SectorName as 'Sector_Name',
SectorInfo as 'Sector_Info' FROM TblSector
GO

CREATE TABLE TblSectorMl
(
  sectorId   NVARCHAR(50)    NOT NULL PRIMARY KEY ,
  SectorName NVARCHAR(50)    UNIQUE,
  SectorInfo NVARCHAR(50),  
);

insert into TblSectorMl (sectorId, SectorName, SectorInfo)
SELECT * fROM TblSector


SELECT * fROM TblSectorMl
