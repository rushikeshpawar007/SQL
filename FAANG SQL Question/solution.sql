use faang;

select * from warehouse;



WITH WH as
		(select * from warehouse order by event_datetime desc),
	days as
		(select event_datetime, onhandquantity
		 	  , date_sub(event_datetime, interval 90 day) as day90
		 	  , date_sub(event_datetime, interval 180 day) as day180
		 	  , date_sub(event_datetime, interval 270 day) as day270
		 	  , date_sub(event_datetime, interval 365 day) as day365
		 from WH limit 1),
         
	inv_90_days as 
		(select sum(OnHandQuantityDelta) as daysold_90
        from WH cross join days d
        where event_type = 'InBound'
        and WH.event_datetime >= d.day90),
        
	inv_90_days_final as 
		(select case when daysold_90 > d.onhandquantity then d.onhandquantity
        else daysold_90
        end as daysold_90
        from inv_90_days
        cross join days d),
        
    inv_180_days as
		(select sum(OnHandQuantityDelta) as daysold_180
        from WH cross join days d
        where event_type = 'Inbound'
        and WH.event_datetime >= d.day180),
        
	inv_180_days_final as 
		(select 
        case when daysold_180 > d.OnHandQuantity then d.OnHandQuantity
        else daysold_180
        end as daysold_180
        from inv_180_days
        cross join days d),
        
inv_270_days as
		(select sum(OnHandQuantityDelta) as daysold_270
        from WH cross join days d
        where event_type = 'Inbound'
        and WH.event_datetime >= d.day270),
        
inv_270_days_final as
		( select
        case when daysold_270 > d.OnhandQuantity then d.OnhandQuantity
        else daysold_270
        end as daysold_270
        from inv_270_days
        cross join days d),
        
        
inv_365_days as
		(select sum(OnHandQuantityDelta) as daysold_365
        from WH cross join days d
        where event_type = 'Inbound'
        and WH.event_datetime >= d.day365),
        
inv_365_days_final as 
		(select 
        case when daysold_365 > d.OnHandQuantity then OnHandQuantity
        else daysold_365
        end as daysold_365
        from inv_365_days
        cross join days d)


select * from inv_365_days_final;






         
