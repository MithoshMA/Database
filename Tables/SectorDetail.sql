

--Sector details

drop table TblSector
CREATE TABLE TblSector
(
  sectorId   VARCHAR(50)    NOT NULL PRIMARY KEY ,
  SectorName VARCHAR(50)    UNIQUE,
  SectorInfo VARCHAR(50),  
);

select * from TblSector
insert into TblSector (sectorId, SectorName, SectorInfo) values ('TPR_001', 'Tholpara North', 'North side of Tholpara');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('AKL_001', 'Areekkal', 'Areekkal side from Narayanakkunnu');
insert into TblSector (sectorId, SectorName, SectorInfo) values ('NYK_001', 'Narayanakunnu', 'Narayanakkunnu frrom Areekkal side to Kalathingal');