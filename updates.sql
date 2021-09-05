--updatePrices1
update trainers
set current_price = current_price + current_price/10
where club_id = 1;

--Достаточно уровня read commited, т.к. добавление клиента не мешает другим операциям, уровня read uncommited не хватит, потому что 
--в его рамках нельзя вносить изменения.
create or replace function addClient(cur_name varchar(50), cur_birthday date, cur_email varchar(50))
    returns void as $$
declare
    max_id int;
begin
-- NOTE: Для этого есть последовательности

    select (max(client_id))
    into max_id
    from clients;
    insert into clients (client_id, client_name, birthday, email)
    values (max_id + 1, cur_name, cur_birthday, cur_email);
    return;
end;
$$
LANGUAGE plpgsql;

select addClient('Galina Grigorieva', '13-09-1999', 'galina@mail.ru');

--Аналогично addClient достаточно уровня read commited.
create or replace function 
    addTrainer(cur_name varchar(50), cur_sports_category sports_category, cur_price int, cur_salary int, cur_club_id int)
    returns void as $$
declare
    max_id int;
begin
    select (max(trainer_id))
    into max_id
    from trainers;
    insert into trainers (trainer_id, trainer_name, sports_category, current_price, salary, club_id) 
    values (max_id + 1, cur_name, cur_sports_category, cur_price, cur_salary, cur_club_id);
    return;
end;
$$
LANGUAGE plpgsql;

select addTrainer('Ivan Petrov', 'Candidate Master of sports', 2000, 40000, 1);

--Аналогично addClient достаточно уровня read commited.
create or replace function addMembership(count_of_days int, club_id int, client_id int)
    returns void as $$
declare
    max_id int;
begin
    select (max(membership_id))
    into max_id
    from memberships;
    insert into memberships (membership_id, until, number_of_visits, club_id, client_id)
    values (max_id + 1, current_date + count_of_days, 0, club_id, client_id);
    return;
end;
$$
LANGUAGE plpgsql;

select addMembership(10, 1, 3);

--Serializable, т.к. при read commited в течение добавления тренировки может появиться "фантомная" тренировка, проходящая в то же время у
--того же тренера.
create or replace function addTraining(train_date date, train_time time, cur_client_id int, cur_trainer_id int)
    returns boolean as $$
declare
    trainer_club_id int;
    trainer_price int;
begin
    select club_id 
    into trainer_club_id
    from trainers 
    where trainers.trainer_id = cur_trainer_id;
    
    select current_price 
    into trainer_price
    from trainers 
    where trainers.trainer_id = cur_trainer_id;
    

    if (not exists(select membership_id 
               from memberships 
               where until > train_date and 
                    (train_date > current_date or 
                        (train_date = current_date and current_time < train_time)) and
                    client_id = cur_client_id and club_id = trainer_club_id))
    then return false;
    end if;
    insert into trainings (training_date, start_time, price, client_id, trainer_id)
    values ( train_date, train_time, trainer_price, cur_client_id, cur_trainer_id);
    return true;
end;
$$
LANGUAGE plpgsql;

select addTraining('2021-02-02', '15:30:00', 3, 2);
select addTraining('2021-02-02', '15:30:00', 1, 1);

--Serializable аналогично addTraining
create or replace function 
    addGroupWorkout(workout_day day_of_week, workout_name varchar(50), workout_starts time, workout_ends time, cur_room_id int, cur_trainer_id int)
    returns boolean as $$
declare
    trainer_club_id int;
    room_club_id int;
begin
    select club_id 
    into trainer_club_id
    from trainers 
    where trainers.trainer_id = cur_trainer_id;
    
    select club_id 
    into room_club_id
    from rooms 
    where rooms.room_id = cur_room_id;

    if (exists(select * 
               from group_workouts 
               where (((starts >= workout_starts and starts <= workout_ends) or
                     (ends > workout_starts and ends <= workout_ends)) and
                     (room_id = cur_room_id or trainer_id = cur_trainer_id) and workout_day = day) or 
                     room_club_id != trainer_club_id))
    then return false;
    end if;
    
    insert into group_workouts (day, starts, ends, workout_name, room_id, trainer_id) 
    values (workout_day, workout_starts, workout_ends, workout_name, cur_room_id, cur_trainer_id);
    return true;
end;
$$
LANGUAGE plpgsql;

select addGroupWorkout('Monday', 'Yoga', '16:30:00', '17:30:00', 2, 2);
select addGroupWorkout('Monday', 'Yoga', '16:30:00', '17:30:00', 1, 1);
select addGroupWorkout('Monday', 'Yoga', '17:30:00', '18:30:00', 2, 1);