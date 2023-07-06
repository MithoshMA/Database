CREATE TABLE TblAgents
(
    agt_id INT IDENTITY,
    agt_sectorId   VARCHAR(50),
    agt_memb_id   INT,
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
LEFT JOIN TblMembers M ON T.agt_memb_id = M.mem_id_no
LEFT JOIN TblSector S ON T.agt_sectorId = S.sectorId