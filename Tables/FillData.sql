/* TblSector */

SELECT * FROm TblSector
insert into TblSector (sectorId, SectorName, SectorInfo)
values 
('TPR_001', 'Tholpara North', 'North side of Tholpara'),
('AKL_001', 'Areekkal', 'Areekkal side from Narayanakkunnu'),
('NYK_001', 'Narayanakunnu', 'Narayanakkunnu from Areekkal side to Kalathingal'),
('KAK_001', 'Kallaramkettil', 'Kallaramkettu from Areekkal side to Kalathingal')

SELECT * FROM TblMembers


  --delete from TblChitInfo
INSERT INTO TblChitInfo 
(
    [chit_id], [chit_name], [chit_amount], [chit_month_amt], [chit_member_count], [chit_lot_start], [chit_start_dt], [chit_duration], [chit_auction_date], [chit_condition]
)
VALUES
('Chit NO 2023/08-A', 'Sahaya', 1000*36, 1000, 46, 1000, '2023/08/01 00:00:00', 36, 1, 1)
SELECT *from VIW_CHIT_INFO
