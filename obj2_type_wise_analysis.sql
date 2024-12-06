-- Objective 2: Identify which vehicles are likely to be stolen --

-- Our second objective is to explore the vehicle type, age, luxury vs standard and color fields in the stolen_vehicles table
-- to identify which vehicles are most likely to be stolen.

select * from stolen_vehicles;
select * from make_details;

-- Find the vehicle types that are most often and least often stolen:
select vehicle_type, count(vehicle_type) count 
from stolen_vehicles
group by vehicle_type
order by 2 desc;

-- For each vehicle type, find the average age of the cars that are stolen:
select vehicle_type, avg(year(date_stolen) - model_year) vehicle_age
from stolen_vehicles
group by vehicle_type;

-- For each vehicle type, find the percent of vehicles stolen that are luxury versus standard:

-- Step 1 - Perform a LEFT JOIN on stolen_vehicles and make_details. From the joined table, select vehicle_type and make_type from stolen_vehicles and  make_details respectively:
select s.vehicle_type, m.make_type
from stolen_vehicles s left join make_details m
on s.make_id = m.make_id;

-- Step 2 - Convert every instance of "Luxury" in the make_type field into number 1 and that of "Standard" to 0.
select s.vehicle_type, 
case(m.make_type)
	when "Luxury" then 1
    else 0
    end as luxury
from 
stolen_vehicles s left join make_details m
on s.make_id = m.make_id;

-- OR
select s.vehicle_type, 
case when make_type = 'Luxury' then 1 else 0 end as luxury
from stolen_vehicles s left join make_details m
on s.make_id = m.make_id;

-- We now have a table with two fields, vehicle_type and luxury. In the field luxury, 1 represents make_type Luxury and 0 represents make_type Standard. If we sum up the values in luxury field, which are 1s and 0s, we get the total number of luxury vehicles, because this result will be the sum of all the 1s in this field. Which also means the count of all luxury type. 

-- To find the percentage of luxury vehicles stolen we need to divide count of luxury vehicles by the total vehicles. From the above result, by summing up luxury field, we get the total count of luxury vehicles. To find the total number of vehicles, let's add one more column(let's name it 'total') to the above table and enter 1 in every row. Summing up this field gives us the total vehicle count:

select s.vehicle_type, 
case(m.make_type)
	when "Luxury" then 1
    else 0
    end as luxury,
1 as total
from 
stolen_vehicles s left join make_details m
on s.make_id = m.make_id;

-- Now we need to find the percentage of luxury:
select (sum(luxury) / sum(total)) * 100 as luxury_percentage
from 
(
select s.vehicle_type, 
case(m.make_type)
	when "Luxury" then 1
    else 0
    end as luxury,
1 as total
from 
stolen_vehicles s left join make_details m
on s.make_id = m.make_id
) as luxury_count;

-- But this is the percentage of all luxury vehicles. We need the percentage of luxury vehicles stolen from each vehicle_type:
select 
vehicle_type, 
round(sum(luxury) * 100 / sum(total), 2) as luxury_percentage
from
(
select s.vehicle_type, 
case(m.make_type)
	when "Luxury" then 1
    else 0
    end as luxury,
1 as total
from 
stolen_vehicles s left join make_details m
on s.make_id = m.make_id
) as luxury_count
group by vehicle_type
order by 2 desc;

-- And you will see that 50% of all convertibles stolen were luxury. Similarly, 22.5% of all stolen sports cars were luxury. 


-- Create a table where the rows represent the top 10 vehicle types, the columns represent the top 7 vehicle colors (plus 1 column for all other colors) and the values are the number of vehicles stolen:

-- Top 7 colors:
select color, count(color) from stolen_vehicles
group by color
order by 2 desc
limit 7;

-- Result:
-- 'Silver', '1272'
-- 'White', '934'
-- 'Black', '589'
-- 'Blue', '512'
-- 'Red', '390'
-- 'Grey', '378'
-- 'Green', '224'

-- You now have top colors in the table. If you want to create a table with these colors as the column headers, you can use the case statement:

select vehicle_type, 
	case when color = 'Silver' then 1 else 0 end as 'Silver',
    case when color = 'White' then 1 else 0 end as 'White',
    case when color = 'Black' then 1 else 0 end as 'Black',
    case when color = 'Blue' then 1 else 0 end as 'Blue',
    case when color = 'Red' then 1 else 0 end as 'Red',
    case when color = 'Grey' then 1 else 0 end as 'Grey',
    case when color = 'Green' then 1 else 0 end as 'Green',
    case when color not in ('Silver','White','Black','Blue','Red','Grey','Green') then 1 else 0 end as 'Others'
from stolen_vehicles;

-- But we need the count of vehicles from each color. So let's add the 1s in each color column and group by vehicle_type:

select vehicle_type, 
	sum(case when color = 'Silver' then 1 else 0 end) as 'Silver',
    sum(case when color = 'White' then 1 else 0 end) as 'White',
    sum(case when color = 'Black' then 1 else 0 end) as 'Black',
    sum(case when color = 'Blue' then 1 else 0 end) as 'Blue',
    sum(case when color = 'Red' then 1 else 0 end) as 'Red',
    sum(case when color = 'Grey' then 1 else 0 end) as 'Grey',
    sum(case when color = 'Green' then 1 else 0 end) as 'Green',
    sum(case when color not in ('Silver','White','Black','Blue','Red','Grey','Green') then 1 else 0 end) as 'Others'
from stolen_vehicles
group by vehicle_type;

-- But we only need the top 10 stolen vehicle types. To find the top 10 stolent vehicle types we need to add one more column to the above table, which nothing but the count of vehicle_types.

select vehicle_type, count(vehicle_type),
	sum(case when color = 'Silver' then 1 else 0 end) as 'Silver',
    sum(case when color = 'White' then 1 else 0 end) as 'White',
    sum(case when color = 'Black' then 1 else 0 end) as 'Black',
    sum(case when color = 'Blue' then 1 else 0 end) as 'Blue',
    sum(case when color = 'Red' then 1 else 0 end) as 'Red',
    sum(case when color = 'Grey' then 1 else 0 end) as 'Grey',
    sum(case when color = 'Green' then 1 else 0 end) as 'Green',
    sum(case when color not in ('Silver','White','Black','Blue','Red','Grey','Green') then 1 else 0 end) as 'Others'
from stolen_vehicles
group by vehicle_type
order by 2 desc
limit 10;
