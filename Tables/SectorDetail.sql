

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
insert into TblSector (sectorId, SectorName, SectorInfo) values ('TPR_001', 'Tholpara North', 'North side of Tholpara');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('AKL_001', 'Areekkal', 'Areekkal side from Narayanakkunnu');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('NYK_001', 'Narayanakunnu', 'Narayanakkunnu from Areekkal side to Kalathingal');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('KAK_001', 'Kallaramkettil', 'Kallaramkettu from Areekkal side to Kalathingal');

update TblSector set SectorInfo = 'qqq' where sectorId = ''

Delete from  TblSector where sectorId = ''
