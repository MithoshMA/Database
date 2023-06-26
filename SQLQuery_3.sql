-- Table TblUserGroup

-- Drop table TblUserGroup
--CREATE TABLE TblUserGroup
(
ug_id INT IDENTITY PRIMARY KEY,
ug_name varchar(30) UNIQUE NOT NULL,
ug_flag smallint default 0)

SELECT
  *
FROM
  INFORMATION_SCHEMA.TABLES;
GO

 sp_columns   TblUserGroup
select * from TblUserGroup

insert into TblUserGroup (ug_name) VALUES ('Mithosh MA')
insert into TblUserGroup (ug_name) VALUES ('Sachin T') 

select ug_id as 'ID', ug_name as 'Name',  ug_flag as 'Active' from TblUserGroup

drop view UserName
create view UserName as select ug_id as 'ID', ug_name as 'Name' from TblUserGroup where ug_flag = 0;

select * from  UserName