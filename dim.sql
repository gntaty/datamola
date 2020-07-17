
CREATE TABLE CHILD(		
children_id int NOT NULL,
first_name NCHAR (20) NOT NULL,
last_name nchar (20) NOT NULL,
gender char(1),
parent_name_1 nchar (20) NOT NULL,
parent_name_2 nchar (20) null,
date_of_bith date,
phone_number nchar (15) null,
CONSTRAINT children_pkey PRIMARY KEY (children_id)) tablespace ts_dims;

CREATE TABLE GROUPS(   
group_id int NOT NULL ,
group_name NCHAR (20) NOT NULL,
capacity int,
kindergarten_id int NOT NULL ,
kindergarten_name nchar (20) null,
address nchar (20),
city_id int NOT NULL,
city_name nchar (20),
country_id int NOT NULL,
country_name nchar (20),
 CONSTRAINT group_pk PRIMARY KEY (group_id)
 );
 
CREATE TABLE EMPLOYEES(   
employee_id int NOT NULL ,
first_name NCHAR (20) NOT NULL,
last_name nchar (20) NOT NULL,
phone_number nchar (15) null,
email nchar (15) null,
 CONSTRAINT employee_pk PRIMARY KEY (employee_id)
 );

CREATE TABLE SERVICES(   
service_id int NOT NULL ,
service_natural_key NCHAR (50) NOT NULL,
service_desc nchar (100) NOT NULL,
service_type_id int NOT NULL,
type_desc NCHAR (100),
cost_per_service float NOT NULL,
effective_from date NOT NULL,
effective_to date NOT NULL,
CONSTRAINT service_pk PRIMARY KEY (service_id)
 )
  PARTITION BY HASH(service_type_id) PARTITIONS 8;

CREATE TABLE DATES as 
SELECT 
  CAST((TO_CHAR(sd+rn , 'YYYY')||TO_CHAR(sd+rn , 'MM')||TO_CHAR(sd+rn , 'DD') ) AS INTEGER) date_id, 
  TO_CHAR( sd + rn, 'fmDay' ) day_name,
  TO_CHAR( sd + rn, 'D' ) day_number_in_week,
  TO_CHAR( sd + rn, 'DD' ) day_number_in_month,
  TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,
  TO_CHAR( sd + rn, 'W' ) calendar_week_number,
  ( CASE
      WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
        NEXT_DAY( sd + rn, 'ÑÓÁÁÎÒÀ' )
      ELSE
        ( sd + rn )
    END ) week_ending_date,
  TO_CHAR( sd + rn, 'MM' ) calendar_month_number,
  TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_cal_month,
  LAST_DAY( sd + rn ) end_of_cal_month,
  TO_CHAR( sd + rn, 'FMMonth' ) calendar_month_name,
  ( ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) - TRUNC( sd + rn, 'Q' ) + 1 ) days_in_cal_quarter,
  TRUNC( sd + rn, 'Q' ) beg_of_cal_quarter,
  ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) end_of_cal_quarter,
  TO_CHAR( sd + rn, 'Q' ) calendar_quarter_number,
  TO_CHAR( sd + rn, 'YYYY' ) calendar_year,
  ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year,
  TRUNC( sd + rn, 'YEAR' ) beg_of_cal_year,
  TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' ) end_of_cal_year
FROM
  ( 
    SELECT 
      TO_DATE( '12/31/2002', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 4000
  );



CREATE SEQUENCE children_id_seq; 
CREATE SEQUENCE group_id_seq ;
CREATE SEQUENCE employee_id_seq ;
CREATE SEQUENCE service_id_seq  ;

CREATE TABLE fact_attendance( -- create facts table 
 record_id      int,
 children_id 	int,
 group_id 		int,
 employee_id	int,
 service_id     int,
 date_id 	    int,
count_services 		int, 
sum_service_amount 	int, 
visit_ratio 		int,  
CONSTRAINT record_pk PRIMARY KEY (record_id) ); 

-- add foreing key references
ALTER TABLE fact_attendance ADD CONSTRAINT children_id_fkey FOREIGN KEY (children_id) REFERENCES CHILD(children_id) ON DELETE CASCADE ;
ALTER TABLE fact_attendance ADD CONSTRAINT group_id_fkey FOREIGN KEY (group_id) REFERENCES GROUPS(group_id) ON DELETE CASCADE;
ALTER TABLE fact_attendance ADD CONSTRAINT employee_id_fkey FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id) ON DELETE CASCADE;
ALTER TABLE fact_attendance ADD CONSTRAINT service_id_fkey FOREIGN KEY ( service_id) REFERENCES services(service_id) ON DELETE CASCADE;
ALTER TABLE fact_attendance ADD CONSTRAINT date_id_fkey FOREIGN KEY (date_id) REFERENCES dates(date_id) ON DELETE CASCADE;


