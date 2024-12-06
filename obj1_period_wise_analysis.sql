-- Objective 1: Identify when vehicles are likely to be stolen --

-- Our first objective is to explore the vehicle and date fields in the stolen_vehicles table to identify when vehicles tend to be stolen.

select * from stolen_vehicles;
select * from make_details;
select * from locations;

-- Find the number of vehicles stolen each year:
select year(date_stolen) 'year', count(vehicle_id) stolen_vehicles_count
from stolen_vehicles
group by year(date_stolen);

-- Find the number of vehicles stolen each month
select month(date_stolen) 'month', count(vehicle_id) stolen_vehicles_count
from stolen_vehicles
group by month(date_stolen)
order by 1;

select substr(date_stolen, 1, 7) 'month', count(vehicle_id) stolen_vehicles_count
from stolen_vehicles
group by substr(date_stolen, 1, 7)
order by 1;

-- Find the number of vehicles stolen each day of the week:
select 
dayofweek(date_stolen) day_of_week,
case dayofweek(date_stolen)
	when 1 then 'Sunday'
    when 2 then 'Monday'
    when 3 then 'Tuesday'
    when 4 then 'Wednesday'
    when 5 then 'Thursay'
    when 6 then 'Friday'
    else 'Saturday'
end as day_name,
count(vehicle_id) stolen_vehicles_count
from stolen_vehicles
group by dayofweek(date_stolen), day_name
order by 1;

select monthname(date_stolen) from stolen_vehicles;