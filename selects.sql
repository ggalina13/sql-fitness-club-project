--SelectActive1
--select all clients who has an active membership in club 1
select distinct club_id, client_name, email 
    from clients natural join memberships
    where club_id = 1 and until > now();

--SelectMasters2
--select all trainers who has a 'Master of sports' sports category and their prices in club 2   
select trainer_name, current_price 
    from trainers
    where club_id = 2 and sports_category = 'Master of sports';

--Shedule1
--show the workout shedule in club 1
select day, starts, ends, workout_name, trainer_name, room_name 
    from group_workouts natural join rooms natural join trainers
    where club_id = 1;

--ClubsWithPools
--select clubs with pools and pools info
select club_name, lane_count, lane_length
    from clubs natural join pools;

--Trainings1
--select all the trainings in club 1
select training_date as date, start_time as time, trainer_name, client_name, price
from trainers natural join clients natural join trainings
order by date, time;

--WorkingHours1
--select working hours of the club 1
select day, concat(opens_at, ' - ', closes_at) as working_hours, concat(break_starts, ' - ', break_ends) as break
from working_hours
where club_id = 1
order by day;

--TrainingShedule1
--show trainingShedule of trainer 1 in 2020-03-03
select start_time, client_name
from clients natural join trainings
where trainer_id = 1 and training_date = '2020-03-03'
order by start_time;

--Equipment2
--select all kinds of equipment from club 2
select distinct equipment_name
from equipment
where club_id = 2;

create view equipmentCount as
select distinct club_id, (select count(equipment_id) from equipment where equipment.club_id = clubs.club_id) as count_equipment
from clubs;

create view hasPool as
select club_id, exists(select pool_id from pools where pools.club_id = clubs.club_id) as has_pool
from clubs;

create view clubAddress as
select club_name, city, (concat(city, ', ', street, ', ', building)) as club_address
from clubs natural join addresses;

--Characteristics
--show clubs with characteristics
select club_name, club_address, count_equipment, has_pool 
from clubs natural join clubAddress natural join equipmentCount natural join hasPool;

-- NOTE: Только простые запросы
