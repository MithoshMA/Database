drop TABLE Table1
CREATE TABLE Table1
(
  [mem_no]	INT IDENTITY,
  [mem_id_no]          INT           NOT NULL,
  [mem_name]  VARCHAR(50)    NOT NULL,
);

drop TABLE Table2
CREATE TABLE Table2
(
  [mem_no2]	INT IDENTITY,
  [mem_id_no2]          INT           NOT NULL,
  [mem_name]  VARCHAR(50)    NOT NULL,
  [Counrty]  VARCHAR(50)    NOT NULL,
);

delete from Table2
insert into Table2 
(mem_id_no2, mem_name, Counrty)
VALUES
(1, 'John Doe', 'United States'),
(2, 'Jane Smith', 'Canada'),
(3, 'Mohammed Khan', 'India'),
(4, 'Maria Garcia', 'Spain'),
(5, 'Alexandre Dupont', 'France'),
(6, 'Liu Wei', 'China'),
(7, 'Anna Müller', 'Germany'),
(8, 'Ricardo Silva', 'Brazil'),
(9, 'Yuki Tanaka', 'Japan'),
(10, 'Elena Petrova', 'Russia'),
(11, 'Sebastian Gonzalez', 'Argentina'),
(12, 'Amelia Santos', 'Portugal'),
(13, 'Kim Soo-min', 'South Korea'),
(14, 'Marta Lopez', 'Denmark'),
(15, 'Hassan Ali', 'Egypt'),
(16, 'Sophie Martin', 'Australia'),
(17, 'Luca Bianchi', 'Italy'),
(18, 'Sara Andersen', 'Denmark'),
(19, 'Ibrahim Rahman', 'Bangladesh'),
(20, 'Lucas Costa', 'Denmark');

select * from Table2 where [Counrty] = 'Denmark'

INSERT INTO Table1
(mem_id_no, mem_name)
select mem_id_no2, mem_name from Table2 where [mem_id_no2] > 10

select * from Table1
delete from Table1


select A.ctmbr_mbr_id
JOIN 
from TblChitMemberInfo A on VW_MEMBERS B