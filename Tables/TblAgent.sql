
CREATE TABLE TblAgents
(
    agt_id INT IDENTITY,
    agt_sectorId   VARCHAR(50),
    agt_first_name   VARCHAR(50),
    agt_last_name   VARCHAR(50),
    agt_status INT DEFAULT 0
    FOREIGN KEY (agt_sectorId) REFERENCES  TblSector(sectorId),
    FOREIGN KEY (agt_memb_id) REFERENCES  TblMembers(mem_id_no),
);

SELECT * FROM TblAgents

truncate table TblAgents
INSERT INTO TblAgents  (agt_sectorId, agt_memb_id)
VALUES
('TPR_001', 10404),
('AKL_001', 10405),
('NYK_001', 10406),
('KAK_001', 10407)


SELECT M.mem_first_name + ' ' + mem_last_name,
S.SectorName FROM
TblAgents T 
JOIN TblMembers M ON T.agt_memb_id = M.mem_id_no
JOIN TblSector S ON T.agt_sectorId = S.sectorId

GO
DROP TABLE TblAgent
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
DROP VIEW RPT_VW_AGENTS
GO
CREATE VIEW RPT_VW_AGENTS as
SELECT 
A.agt_id,
A.agt_no as 'Agent No',
A.agt_first_name as 'First_Name',
A.agt_last_name as 'Last_Name',
S.SectorName as 'Sector',
A.agt_phone_no as 'Phone'
FROM TblAgent A
LEFT JOIN TblSector S ON A.agt_sectorId = S.sectorId
GO

SELECT * FROM TblAgent

TRUNCATE TABLE TblAgent
INSERT INTO TblAgent
(agt_no, agt_sectorId, agt_first_name, agt_last_name)
VALUES (1, 'TPR_001', 'Shimnesh', 'TP'),
 (2, 'AKL_002', 'Sunil Kumar', 'A'),
(3,  'AKL_001', 'Sajeesh', 'K'),
 (4, 'NYK_001', 'Abas', 'NK'),
 (5, 'KAK_001', 'Gireesh', 'KK'),
 (6, 'KAK_001', 'Suresh', 'KK')

SELECT * FROM RPT_VW_AGENTS

SELECT COUNT(agt_no) FROM TblAgent where agt_no = 1
TRUNCATE TABLE TblAgent

INSERT INTO TblAgent
(agt_no, agt_sectorId, agt_first_name, agt_last_name)
VALUES (10, null, 'Shimnesh', 'TP')
