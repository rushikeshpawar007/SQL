
/* ----------:::  Scripts for PostgreSQL database  :::---------- */

drop table warehouse;
create table warehouse
(
	ID						varchar(10),
	OnHandQuantity			int,
	OnHandQuantityDelta		int,
	event_type				varchar(10),
	event_datetime			timestamp
);

insert into warehouse values
('SH0013', 278,   99 ,   'OutBound', '2020-05-25 0:25'), 
('SH0012', 377,   31 ,   'InBound',  '2020-05-24 22:00'),
('SH0011', 346,   1  ,   'OutBound', '2020-05-24 15:01'),
('SH0010', 346,   1  ,   'OutBound', '2020-05-23 5:00'),
('SH009',  348,   102,   'InBound',  '2020-04-25 18:00'),
('SH008',  246,   43 ,   'InBound',  '2020-04-25 2:00'),
('SH007',  203,   2  ,   'OutBound', '2020-02-25 9:00'),
('SH006',  205,   129,   'OutBound', '2020-02-18 7:00'),
('SH005',  334,   1  ,   'OutBound', '2020-02-18 8:00'),
('SH004',  335,   27 ,   'OutBound', '2020-01-29 5:00'),
('SH003',  362,   120,   'InBound',  '2019-12-31 2:00'),
('SH002',  242,   8  ,   'OutBound', '2019-05-22 0:50'),
('SH001',  250,   250,   'InBound',  '2019-05-20 0:45');
COMMIT;


WITH WH as
		(select * from warehouse order by event_datetime desc),
	days as
		(select event_datetime, onhandquantity
		 	  , (event_datetime - interval '90 DAY') as day90
		 	  , (event_datetime - interval '180 DAY') as day180
		 	  , (event_datetime - interval '270 DAY') as day270
		 	  , (event_datetime - interval '365 DAY') as day365
		 from WH limit 1),
	inv_90_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_90  /* Get the total InBound inventories in the last 90 days */
		 from WH cross join days
		 where WH.event_datetime >= days.day90
		 and event_type = 'InBound'),
	inv_90_days_final as
		(select case when DaysOld_90 > onhandquantity then onhandquantity  /* If InBound inventories is greater than curent total inventories then curent total inventories is the remaining inventories */
					else DaysOld_90
	   		   end as DaysOld_90
		from inv_90_days x
		cross join days),

	inv_180_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_180  /* Get the total InBound inventories between the last 90 and 180 days */
		 from WH cross join days
		 where WH.event_datetime between days.day180 and days.day90
		 and event_type = 'InBound'),
	inv_180_days_final as
		(select case when DaysOld_180 > (onhandquantity - DaysOld_90) then (onhandquantity - DaysOld_90)
					else DaysOld_180
	   		   end as DaysOld_180
		from inv_180_days x
		cross join days
		cross join inv_90_days_final),

	inv_270_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_270  /* Get the total InBound inventories between the last 180 and 270 days */
		 from WH cross join days
		 where WH.event_datetime between days.day270 and days.day180
 		 and event_type = 'InBound'),
	inv_270_days_final as
		(select case when DaysOld_270 > (onhandquantity - (DaysOld_90 + DaysOld_180)) then (onhandquantity - (DaysOld_90 + DaysOld_180)) 
					else DaysOld_270
	   		   end as DaysOld_270
		from inv_270_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final),

	inv_365_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_365  /* Get the total InBound inventories between the last 270 and 365 days */
		 from WH cross join days
		 where WH.event_datetime between days.day365 and days.day270
		 and event_type = 'InBound'),
	inv_365_days_final as
		(select case when DaysOld_365 > (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) then (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) 
					else DaysOld_365
	   		   end as DaysOld_365
		from inv_365_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final
		cross join inv_270_days_final)

select DaysOld_90 as "0-90 days old"
	 , DaysOld_180 as "91-180 days old"
	 , DaysOld_270 as "181-270 days old"
	 , DaysOld_365 as "271-365 days old"
from inv_90_days_final
cross join inv_180_days_final
cross join inv_270_days_final
cross join inv_365_days_final
cross join days;





/* ----------:::  Scripts for MySQL database  :::---------- */

drop table demo.warehouse; /* Replace demo with your database name */
create table demo.warehouse
(
	ID						varchar(10),
	OnHandQuantity			int,
	OnHandQuantityDelta		int,
	event_type				varchar(10),
	event_datetime			timestamp
);

insert into demo.warehouse values
('SH0013', 278,   99 ,   'OutBound', '2020-05-25 0:25'), 
('SH0012', 377,   31 ,   'InBound',  '2020-05-24 22:00'),
('SH0011', 346,   1  ,   'OutBound', '2020-05-24 15:01'),
('SH0010', 346,   1  ,   'OutBound', '2020-05-23 5:00'),
('SH009',  348,   102,   'InBound',  '2020-04-25 18:00'),
('SH008',  246,   43 ,   'InBound',  '2020-04-25 2:00'),
('SH007',  203,   2  ,   'OutBound', '2020-02-25 9:00'),
('SH006',  205,   129,   'OutBound', '2020-02-18 7:00'),
('SH005',  334,   1  ,   'OutBound', '2020-02-18 8:00'),
('SH004',  335,   27 ,   'OutBound', '2020-01-29 5:00'),
('SH003',  362,   120,   'InBound',  '2019-12-31 2:00'),
('SH002',  242,   8  ,   'OutBound', '2019-05-22 0:50'),
('SH001',  250,   250,   'InBound',  '2019-05-20 0:45');
COMMIT;


WITH WH as
		(select * from demo.warehouse order by event_datetime desc),
	days as
		(select event_datetime, onhandquantity
		 	  , date_sub(event_datetime, interval 90 day) as day90
		 	  , date_sub(event_datetime, interval 180 day) as day180
		 	  , date_sub(event_datetime, interval 270 day) as day270
		 	  , date_sub(event_datetime, interval 365 day) as day365
		 from WH limit 1),
	inv_90_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_90
		 from WH cross join days
		 where WH.event_datetime >= days.day90
		 and event_type = 'InBound'),
	inv_90_days_final as
		(select case when DaysOld_90 > onhandquantity then onhandquantity 
					else DaysOld_90
	   		   end as DaysOld_90
		from inv_90_days x
		cross join days),

	inv_180_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_180
		 from WH cross join days
		 where WH.event_datetime between days.day180 and days.day90
		 and event_type = 'InBound'),
	inv_180_days_final as
		(select case when DaysOld_180 > (onhandquantity - DaysOld_90) then (onhandquantity - DaysOld_90) 
					else DaysOld_180
	   		   end as DaysOld_180
		from inv_180_days x
		cross join days
		cross join inv_90_days_final),

	inv_270_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_270
		 from WH cross join days
		 where WH.event_datetime between days.day270 and days.day180
 		 and event_type = 'InBound'),
	inv_270_days_final as
		(select case when DaysOld_270 > (onhandquantity - (DaysOld_90 + DaysOld_180)) then (onhandquantity - (DaysOld_90 + DaysOld_180)) 
					else DaysOld_270
	   		   end as DaysOld_270
		from inv_270_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final),

	inv_365_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_365
		 from WH cross join days
		 where WH.event_datetime between days.day365 and days.day270
		 and event_type = 'InBound'),
	inv_365_days_final as
		(select case when DaysOld_365 > (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) then (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) 
					else DaysOld_365
	   		   end as DaysOld_365
		from inv_365_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final
		cross join inv_270_days_final)

select DaysOld_90 as '0-90 days old'
	 , DaysOld_180 as '91-180 days old'
	 , DaysOld_270 as '181-270 days old'
	 , DaysOld_365 as '271-365 days old'
from inv_90_days_final
cross join inv_180_days_final
cross join inv_270_days_final
cross join inv_365_days_final
cross join days;





/* ----------:::  Scripts for Oracle database  :::---------- */

drop table warehouse;  
create table warehouse
(
	ID						varchar2(10),
	OnHandQuantity			int,
	OnHandQuantityDelta		int,
	event_type				varchar2(10),
	event_datetime			timestamp
);

insert into warehouse values ('SH0013', 278,   99 ,   'OutBound', to_timestamp('2020-05-25 0:25' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH0012', 377,   31 ,   'InBound',  to_timestamp('2020-05-24 22:00','YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH0011', 346,   1  ,   'OutBound', to_timestamp('2020-05-24 15:01','YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH0010', 346,   1  ,   'OutBound', to_timestamp('2020-05-23 5:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH009',  348,   102,   'InBound',  to_timestamp('2020-04-25 18:00','YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH008',  246,   43 ,   'InBound',  to_timestamp('2020-04-25 2:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH007',  203,   2  ,   'OutBound', to_timestamp('2020-02-25 9:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH006',  205,   129,   'OutBound', to_timestamp('2020-02-18 7:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH005',  334,   1  ,   'OutBound', to_timestamp('2020-02-18 8:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH004',  335,   27 ,   'OutBound', to_timestamp('2020-01-29 5:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH003',  362,   120,   'InBound',  to_timestamp('2019-12-31 2:00' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH002',  242,   8  ,   'OutBound', to_timestamp('2019-05-22 0:50' ,'YYYY-MM-DD HH24:MI:SS'));
insert into warehouse values ('SH001',  250,   250,   'InBound',  to_timestamp('2019-05-20 0:45' ,'YYYY-MM-DD HH24:MI:SS'));
COMMIT;


WITH WH as
		(select * from warehouse order by event_datetime desc),
	days as
		(select event_datetime, onhandquantity
		 	  , (event_datetime - interval '90' DAY) as day90
		 	  , (event_datetime - interval '180' DAY(3)) as day180
		 	  , (event_datetime - interval '270' DAY(3)) as day270
		 	  , (event_datetime - interval '365' DAY(3)) as day365
		 from WH where rownum = 1),
	inv_90_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_90
		 from WH cross join days
		 where WH.event_datetime >= days.day90
		 and event_type = 'InBound'),
	inv_90_days_final as
		(select case when DaysOld_90 > onhandquantity then onhandquantity 
					else DaysOld_90
	   		   end as DaysOld_90
		from inv_90_days x
		cross join days),

	inv_180_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_180
		 from WH cross join days
		 where WH.event_datetime between days.day180 and days.day90
		 and event_type = 'InBound'),
	inv_180_days_final as
		(select case when DaysOld_180 > (onhandquantity - DaysOld_90) then (onhandquantity - DaysOld_90) 
					else DaysOld_180
	   		   end as DaysOld_180
		from inv_180_days x
		cross join days
		cross join inv_90_days_final),

	inv_270_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_270
		 from WH cross join days
		 where WH.event_datetime between days.day270 and days.day180
 		 and event_type = 'InBound'),
	inv_270_days_final as
		(select case when DaysOld_270 > (onhandquantity - (DaysOld_90 + DaysOld_180)) then (onhandquantity - (DaysOld_90 + DaysOld_180)) 
					else DaysOld_270
	   		   end as DaysOld_270
		from inv_270_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final),

	inv_365_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_365
		 from WH cross join days
		 where WH.event_datetime between days.day365 and days.day270
		 and event_type = 'InBound'),
	inv_365_days_final as
		(select case when DaysOld_365 > (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) then (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) 
					else DaysOld_365
	   		   end as DaysOld_365
		from inv_365_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final
		cross join inv_270_days_final)

select DaysOld_90 as "0-90 days old"
	 , DaysOld_180 as "91-180 days old"
	 , DaysOld_270 as "181-270 days old"
	 , DaysOld_365 as "271-365 days old"
from inv_90_days_final
cross join inv_180_days_final
cross join inv_270_days_final
cross join inv_365_days_final
cross join days;





/* ----------:::  Scripts for MSSQL database  :::---------- */

drop table warehouse;
create table warehouse
(
	ID						varchar(10),
	OnHandQuantity			int,
	OnHandQuantityDelta		int,
	event_type				varchar(10),
	event_datetime			datetime
);

insert into warehouse values ('SH0013', 278,   99 ,   'OutBound', convert(DATETIME,'2020-05-25 0:25'));
insert into warehouse values ('SH0012', 377,   31 ,   'InBound',  convert(DATETIME,'2020-05-24 22:00'));
insert into warehouse values ('SH0011', 346,   1  ,   'OutBound', convert(DATETIME,'2020-05-24 15:01'));
insert into warehouse values ('SH0010', 346,   1  ,   'OutBound', convert(DATETIME,'2020-05-23 5:00'));
insert into warehouse values ('SH009',  348,   102,   'InBound',  convert(DATETIME,'2020-04-25 18:00'));
insert into warehouse values ('SH008',  246,   43 ,   'InBound',  convert(DATETIME,'2020-04-25 2:00'));
insert into warehouse values ('SH007',  203,   2  ,   'OutBound', convert(DATETIME,'2020-02-25 9:00'));
insert into warehouse values ('SH006',  205,   129,   'OutBound', convert(DATETIME,'2020-02-18 7:00'));
insert into warehouse values ('SH005',  334,   1  ,   'OutBound', convert(DATETIME,'2020-02-18 8:00'));
insert into warehouse values ('SH004',  335,   27 ,   'OutBound', convert(DATETIME,'2020-01-29 5:00'));
insert into warehouse values ('SH003',  362,   120,   'InBound',  convert(DATETIME,'2019-12-31 2:00'));
insert into warehouse values ('SH002',  242,   8  ,   'OutBound', convert(DATETIME,'2019-05-22 0:50'));
insert into warehouse values ('SH001',  250,   250,   'InBound',  convert(DATETIME,'2019-05-20 0:45'));



WITH WH as
		(select * from warehouse),
	days as
		(select top 1 event_datetime, onhandquantity
		 	  , dateadd(DAY, -90, event_datetime) as day90
		 	  , dateadd(DAY, -180, event_datetime) as day180
		 	  , dateadd(DAY, -270, event_datetime) as day270
		 	  , dateadd(DAY, -365, event_datetime) as day365
		 from WH order by event_datetime desc),
	inv_90_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_90
		 from WH cross join days
		 where WH.event_datetime >= days.day90
		 and event_type = 'InBound'),
	inv_90_days_final as
		(select case when DaysOld_90 > onhandquantity then onhandquantity 
					else DaysOld_90
	   		   end as DaysOld_90
		from inv_90_days x
		cross join days),

	inv_180_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_180
		 from WH cross join days
		 where WH.event_datetime between days.day180 and days.day90
		 and event_type = 'InBound'),
	inv_180_days_final as
		(select case when DaysOld_180 > (onhandquantity - DaysOld_90) then (onhandquantity - DaysOld_90) 
					else DaysOld_180
	   		   end as DaysOld_180
		from inv_180_days x
		cross join days
		cross join inv_90_days_final),

	inv_270_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_270
		 from WH cross join days
		 where WH.event_datetime between days.day270 and days.day180
 		 and event_type = 'InBound'),
	inv_270_days_final as
		(select case when DaysOld_270 > (onhandquantity - (DaysOld_90 + DaysOld_180)) then (onhandquantity - (DaysOld_90 + DaysOld_180)) 
					else DaysOld_270
	   		   end as DaysOld_270
		from inv_270_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final),

	inv_365_days as
		(select coalesce(sum(WH.OnHandQuantityDelta), 0) as DaysOld_365
		 from WH cross join days
		 where WH.event_datetime between days.day365 and days.day270
		 and event_type = 'InBound'),
	inv_365_days_final as
		(select case when DaysOld_365 > (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) then (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) 
					else DaysOld_365
	   		   end as DaysOld_365
		from inv_365_days x
		cross join days
		cross join inv_90_days_final
		cross join inv_180_days_final
		cross join inv_270_days_final)

select DaysOld_90 as "0-90 days old"
	 , DaysOld_180 as "91-180 days old"
	 , DaysOld_270 as "181-270 days old"
	 , DaysOld_365 as "271-365 days old"
from inv_90_days_final
cross join inv_180_days_final
cross join inv_270_days_final
cross join inv_365_days_final
cross join days;