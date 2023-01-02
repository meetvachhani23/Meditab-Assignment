--create sequence if not exists SEQ_CHART
--INCREMENT 1
--START 1;
--
--create sequence if not exists SEQ_PRIMARY
--INCREMENT 1
--START 1;

--1
create table if not exists Sex_table(
	SEX_ID SERIAL primary key,
--	PATIENT_ID SERIAL
	SEX_TYPE VARCHAR(80) not null
);

insert into sex_table (SEX_TYPE) VALUES ('MALE');
insert into sex_table (SEX_TYPE) VALUES ('FEMALE');
insert into sex_table (SEX_TYPE) VALUES ('UNKNOWN');

select * from sex_table;

--2
create table if not exists Patient_table(
  PATIENT_ID SERIAL /*CHAR(20)*/ primary key not null, /*default to_char(nextval('SEQ_PRIMARY'),'EMMP0000FM'),*/
  CHART_NUMBER VARCHAR(20) not null generated always as ('CHART'||PATIENT_ID::text) stored /*default to_char(nextval('SEQ_CHART'),'EMP0000FM'),*/,
  FIRST_NAME VARCHAR(20) not null ,
  LAST_NAME VARCHAR(20) not null,
  MIDDLE_NAME VARCHAR(20),
  SEX INT not null references Sex_table(SEX_ID),
  DOB DATE,
  created_on timestamp default CURRENT_TIMESTAMP not null
);
--
SET timezone = 'Asia/Calcutta';
insert into Patient_table (FIRST_NAME,LAST_NAME,MIDDLE_NAME,SEX,DOB) VALUES ('Meet','Vachhani','Mehulbhai','1','2000-01-23');
insert into Patient_table (FIRST_NAME,LAST_NAME,MIDDLE_NAME,SEX,DOB) VALUES ('Ruchit','Shah','Jitendrabhai','1','2001-09-19');
insert into Patient_table (FIRST_NAME,LAST_NAME,MIDDLE_NAME,SEX,DOB) VALUES ('Raj','Patel','Gordhanbhai','1','2001-02-13');
insert into Patient_table (FIRST_NAME,LAST_NAME,MIDDLE_NAME,SEX,DOB) VALUES ('Nikita','Mukchandani','Manojbhai','2','2002-01-10');
insert into Patient_table (FIRST_NAME,LAST_NAME,MIDDLE_NAME,SEX,DOB) VALUES ('Hemit','Vachhani','Sanjaybhai','1','2001-09-14');

select * from Patient_table;

--3
create table if not exists Address_type_table(
	ADDRESS_TYPE_ID SERIAL primary key,
--	ADDRESS_ID SERIAL
	ADDRESS_TYPE VARCHAR(80) default 'HOME'
);

insert into address_type_table (ADDRESS_TYPE) values ('HOME');
insert into address_type_table (ADDRESS_TYPE) values ('OFFICE');
insert into address_type_table (ADDRESS_TYPE) values ('WORK');

select * from address_type_table;

--4
create table if not exists Address_table(
    ADDRESS_ID SERIAL primary key,  
    PATIENT_ID SERIAL references Patient_table(PATIENT_ID),
    ADDRESS_TYPE INT references Address_type_table(ADDRESS_TYPE_ID),
    STREET VARCHAR(80) not null,
    CITY VARCHAR(80) not null,
    ZIP VARCHAR(80) not null,
    STATE VARCHAR(80) not null, 
    COUNTRY VARCHAR(80) not null, 
    PRIM_ADDRESS BOOLEAN  default 'FALSE'
);

insert into address_table (ADDRESS_TYPE,STREET,CITY,ZIP,STATE,COUNTRY,PRIM_ADDRESS) values (3,'STREET1','Rajkot',360005,'GUJARAT','INDIA',TRUE);
insert into address_table (ADDRESS_TYPE,STREET,CITY,ZIP,STATE,COUNTRY,PRIM_ADDRESS) values (1,'STREET2','Ahmedabad',360005,'GUJARAT','INDIA',TRUE);
insert into address_table (ADDRESS_TYPE,STREET,CITY,ZIP,STATE,COUNTRY,PRIM_ADDRESS) values (3,'STREET3','Meshana',360005,'GUJARAT','INDIA',FALSE);
insert into address_table (ADDRESS_TYPE,STREET,CITY,ZIP,STATE,COUNTRY,PRIM_ADDRESS) values (3,'STREET4','Meshana',360005,'GUJARAT','INDIA',FALSE);
insert into address_table (ADDRESS_TYPE,STREET,CITY,ZIP,STATE,COUNTRY,PRIM_ADDRESS) values (2,'STREET5','Surat',360005,'GUJARAT','INDIA',TRUE);

select * from Address_table;

--5
create table if not exists Phone_type_table(
	PHONE_TYPE_ID SERIAL primary key,
--	PHONE_ID SERIAL
	PHONE_TYPE VARCHAR(80) not null
);

INSERT INTO Phone_type_table(PHONE_TYPE) VALUES('CELL');
INSERT INTO Phone_type_table(PHONE_TYPE) VALUES('LANDLINE');

SELECT * FROM Phone_type_table;

--6
create table if not exists Phone_table(
	PHONE_ID SERIAL primary key,
	ADDRESS_ID SERIAL references Address_table(ADDRESS_ID),
	PHONE_NUM BIGINT,
	PHONE_TYPE INT references Phone_type_table(PHONE_TYPE_ID),
	PRIM_PHONE BOOLEAN default 'FALSE'
);

INSERT into  Phone_table(ADDRESS_ID,PHONE_NUM,PHONE_TYPE,PRIM_PHONE) VALUES (1,9491261581,1,TRUE);
INSERT into  Phone_table(ADDRESS_ID,PHONE_NUM,PHONE_TYPE,PRIM_PHONE) VALUES (2,9856982563,1,TRUE);
INSERT into  Phone_table(ADDRESS_ID,PHONE_NUM,PHONE_TYPE,PRIM_PHONE) VALUES (3,4889541585,1,FALSE);
INSERT into  Phone_table(ADDRESS_ID,PHONE_NUM,PHONE_TYPE,PRIM_PHONE) VALUES (4,9554144455,1,FALSE);
INSERT into  Phone_table(ADDRESS_ID,PHONE_NUM,PHONE_TYPE,PRIM_PHONE) VALUES (5,7552266699,1,TRUE);

SELECT * from Phone_table;

--7
create table if not exists Fax_table(
	FAX_ID SERIAL primary key,
	ADDRESS_ID SERIAL references Address_table(ADDRESS_ID),
	FAX_NUM INT,
	PRIM_FAX BOOLEAN default 'FALSE'
);

INSERT into Fax_table(ADDRESS_ID,FAX_NUM,PRIM_FAX) VALUES (1,6393,TRUE);
INSERT into Fax_table(ADDRESS_ID,FAX_NUM,PRIM_FAX) VALUES (2,4513,TRUE);
INSERT into Fax_table(ADDRESS_ID,FAX_NUM,PRIM_FAX) VALUES (3,7343,FALSE);
INSERT into Fax_table(ADDRESS_ID,FAX_NUM,PRIM_FAX) VALUES (4,4453,FALSE);
INSERT into Fax_table(ADDRESS_ID,FAX_NUM,PRIM_FAX) VALUES (5,7567,TRUE);

SELECT * from Fax_table;

--8
create table if not exists Race_type_table(
	RACE_TYPE_ID SERIAL primary key,
--	RACE_ID SERIAL
	RACE_TYPE VARCHAR(80) not null
);

INSERT INTO Race_type_table(RACE_TYPE) VALUES('ASIAN');
INSERT INTO Race_type_table(RACE_TYPE) VALUES('AMERICAN');
INSERT INTO Race_type_table(RACE_TYPE) VALUES('AFRICAN');
INSERT INTO Race_type_table(RACE_TYPE) VALUES('EUROPEAN');

SELECT * FROM Race_type_table;

--9
create table if not exists Race_table(
	RACE_ID SERIAL primary key,
	PATIENT_ID SERIAL references Patient_table(PATIENT_ID),
	RACE_TYPE INT references Race_type_table(RACE_TYPE_ID) 
);

INSERT INTO Race_table(PATIENT_ID,RACE_TYPE) VALUES('0001',1);
INSERT INTO Race_table(PATIENT_ID,RACE_TYPE) VALUES('0002',2);
INSERT INTO Race_table(PATIENT_ID,RACE_TYPE) VALUES('0003',3);
INSERT INTO Race_table(PATIENT_ID,RACE_TYPE) VALUES('0004',1);
INSERT INTO Race_table(PATIENT_ID,RACE_TYPE) VALUES('0005',4);

SELECT * FROM Race_table;

--10
create table if not exists Preference_type_table(
	PREFERENCE_TYPE_ID SERIAL primary key,
--	PREFERENCE_ID SERIAL
	PREFERENCE_TYPE VARCHAR(80) not null
);

INSERT INTO Preference_type_table(PREFERENCE_TYPE) VALUES('Appointment Reminder');
INSERT INTO Preference_type_table(PREFERENCE_TYPE) VALUES('Mailing');
INSERT INTO Preference_type_table(PREFERENCE_TYPE) VALUES('Primary');
INSERT INTO Preference_type_table(PREFERENCE_TYPE) VALUES('Statement');

SELECT * FROM Preference_type_table;

--11
create table if not exists Preference_table(
	PREFERENCE_ID SERIAL primary key,
	ADDRESS_ID SERIAL references Address_table(ADDRESS_ID),
	PATIENT_ID SERIAL references Patient_table(PATIENT_ID),
	PHONE_ID SERIAL references Phone_table(PHONE_ID),
	PREFERENCE_TYPE_ID INT references Preference_type_table(PREFERENCE_TYPE_ID),
	FAX_ID INT references Fax_table(FAX_ID)
);

INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(1,'0001',1,4,1);
INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(2,'0002',2,2,2);
INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(3,'0003',3,3,3);
INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(4,'0004',4,1,4);
INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(5,'0005',5,2,5);
INSERT INTO Preference_table(ADDRESS_ID,PATIENT_ID,PHONE_ID,PREFERENCE_TYPE_ID,FAX_ID) VALUES(1,'0001',1,1,1);

SELECT * FROM Preference_table;

--Assignment 2
--21
CREATE or REPLACE VIEW Patient_view AS
    SELECT pt.FIRST_NAME, pt.LAST_NAME, pt.MIDDLE_NAME, pt.DOB, pt.CHART_NUMBER, pt.SEX, rt.RACE_ID, adt.ADDRESS_TYPE, adt.STREET, adt.CITY, adt.ZIP, adt.STATE, adt.COUNTRY, pht.PHONE_NUM, pht.PHONE_TYPE, ft.FAX_NUM
    FROM Patient_table as pt LEFT JOIN Sex_table as st on pt.sex = st.SEX_ID
    		LEFT JOIN race_table as rt on pt.patient_id = rt.patient_id 
    		LEFT JOIN race_type_table as rtt on rt.race_type = rtt.race_type_id and pt.patient_id = rt.patient_id 
    		LEFT JOIN preference_table as prt on pt.patient_id = prt.patient_id and prt.preference_type_id = 1
    		LEFT JOIN address_table as adt on adt.address_id = prt.address_id and pt.patient_id = adt.patient_id 
    		LEFT JOIN phone_table as pht on pht.phone_id = prt.phone_id 
    		LEFT JOIN fax_table as ft on ft.fax_id = prt.fax_id; 
    		
--    	Patient_table NATURAL FULL OUTER JOIN Address_table on 
--    		NATURAL FULL OUTER JOIN Fax_table
--    		NATURAL FULL OUTER JOIN Phone_table
--    		NATURAL FULL OUTER JOIN Race_table);
--   	ON Address_table.PRIM_ADDRESS = true and Phone_table.PRIM_PHONE = true and Fax_table.PRIM_FAX = true;

select * from patient_view;
    
--22
SELECT FIRST_NAME,LAST_NAME,DOB,SEX,COUNT(*) 
FROM Patient_table 
GROUP BY FIRST_NAME,LAST_NAME,DOB,SEX;

--23
Create function generate_primary_key(FIRST_NAME VARCHAR(20),LAST_NAME VARCHAR(20),MIDDLE_NAME VARCHAR(20),DOB DATE, Sex INT)  
returns int  
language plpgsql  
as  
$$  
Declare 

Begin  
  INSERT INTO Patient_table(FIRST_NAME,LAST_NAME,MIDDLE_NAME,DOB,SEX) values(FIRST_NAME,LAST_NAME,MIDDLE_NAME,DOB,Sex);
  return (SELECT PATIENT_ID FROM Patient_table ORDER BY created_on DESC LIMIT 1);  
End;  
$$;  

SELECT generate_primary_key('meet','vachhani','M','2000-01-23',1);

--24
CREATE OR REPLACE FUNCTION paging(search_val varchar default '',
--search_valu int default null,search_value date default null ,
	LAST_N varchar default null, FIRST_N varchar default null, sexx int default null, dobb date default null,	
 	PageNumber INTEGER = NULL,
 	PageSize INTEGER = NULL
 )
 RETURNS TABLE (
  LAST_NAME varchar, FIRST_NAME varchar, SEX INT, DOB date
) AS
 $BODY$
 declare
 begin
	 if search_val ='' or search_val = null THEN
	 	RETURN QUERY
  		SELECT pt.LAST_NAME, pt.FIRST_NAME, pt.SEX, pt.DOB FROM patient_table pt
  		ORDER BY pt.LAST_NAME ASC ,pt.FIRST_NAME ASC, pt.SEX ASC, DOB ASC
  		LIMIT PageSize
  		OFFSET ((PageNumber-1) * PageSize);
 	 ELSE
  		RETURN QUERY
  		SELECT pt.LAST_NAME, pt.FIRST_NAME, pt.SEX, pt.DOB FROM Patient_table pt
  		where
--  		begin 
--	  		if 
	  		search_val = pt.LAST_NAME or search_val = pt.FIRST_NAME
	  			ORDER BY pt.LAST_NAME ASC ,pt.FIRST_NAME ASC, pt.SEX ASC, pt.DOB ASC
  				LIMIT PageSize
  				OFFSET ((PageNumber-1) * PageSize);
--  			else if search_valu = pt.SEX then
--  				ORDER BY pt.LAST_NAME ASC ,pt.FIRST_NAME ASC, pt.SEX ASC, pt.DOB ASC
--  				LIMIT PageSize
--  				OFFSET ((PageNumber-1) * PageSize);
--	  		else if search_value = pt.DOB then
--  				ORDER BY pt.LAST_NAME ASC ,pt.FIRST_NAME ASC, pt.SEX ASC, pt.DOB ASC
--  				LIMIT PageSize
--  				OFFSET ((PageNumber-1) * PageSize);
--  		end;		
 	 end if;
END;
$BODY$
LANGUAGE plpgsql;

Select * from paging();
Select * from paging('');
Select * from paging('Vachhani');
--Select * from paging(sexx=>1);
--Select * from paging(dobb=>'2000-01-23');
Select * from paging(PageNumber=>1,PageSize=>4);
Select * from paging(PageNumber=>2,PageSize=>4);



--25
SELECT
	pt.FIRST_NAME,Pht.PHONE_NUM,add.ADDRESS_ID
FROM
	Patient_table pt
	INNER JOIN address_table add ON add.PATIENT_ID = pt.PATIENT_ID
	INNER JOIN phone_table Pht ON pht.ADDRESS_ID = add.ADDRESS_ID
WHERE Pht.PHONE_NUM = '9491261581';



