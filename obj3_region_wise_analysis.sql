-- Objective 3 - Identify where vehicles are likely to be stolen

select * from stolen_vehicles;
select * from locations;

-- Find the number of vehicles that were stolen in each region:
select l.region, count(s.vehicle_id) vehicle_count
from stolen_vehicles s left join locations l
on s.location_id = l.location_id
group by l.region;

-- Combine the previous output with the population and density statistics for each region
select l.region, l.population, l.density, count(s.vehicle_id) vehicle_count
from stolen_vehicles s left join locations l
on s.location_id = l.location_id
group by l.region, l.population, l.density;