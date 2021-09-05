insert into addresses (address_id, country, region, city, street, building) 
values ('1', 'Russia', 'Leningradskaya oblast', 'Saint-Petersburg', 'Popova', '31'),
       ('2', 'Russia', 'Moscovskaya oblast', 'Moscow', 'Lenina', '5A');

insert into clubs (club_id, club_name, address_id) 
values ('1', 'Club na Popova', 1),
       ('2', 'Club na Lenina', 2);

insert into working_hours (day, opens_at, closes_at, break_starts, break_ends, club_id) 
values  ('Monday', '08:00:00', '23:00:00', '14:00:00', '15:00:00', 1),
        ('Tuesday', '08:00:00', '23:00:00', '14:00:00', '15:00:00', 1),
        ('Wednesday', '08:00:00', '23:00:00', '14:00:00', '15:00:00', 1),
        ('Thursday', '08:00:00', '23:00:00', '14:00:00', '15:00:00', 1),
        ('Friday', '08:00:00', '23:00:00', '14:00:00', '15:00:00', 1),
        ('Saturday', '09:00:00', '22:00:00', '14:00:00', '15:00:00', 1),
        ('Sunday', '09:00:00', '22:00:00', '14:00:00', '15:00:00', 1),
        ('Monday', '08:00:00', '23:00:00', '13:00:00', '14:00:00', 2),
        ('Tuesday', '08:00:00', '23:00:00', '13:00:00', '14:00:00', 2),
        ('Wednesday', '08:00:00', '23:00:00', '13:00:00', '14:00:00', 2),
        ('Thursday', '08:00:00', '23:00:00', '13:00:00', '14:00:00', 2),
        ('Friday', '08:00:00', '23:00:00', '13:00:00', '14:00:00', 2),
        ('Saturday', '09:00:00', '22:00:00', '13:00:00', '14:00:00', 2),
        ('Sunday', '09:00:00', '22:00:00', '13:00:00', '14:00:00', 2);
    
insert into clients (client_id, client_name, birthday, email) 
values ('1', 'Ivan Ivanov', '1987-06-12', 'ivanivanov@mail.ru'),
       ('2', 'Petr Petrov', '1994-03-05', 'petya123@gmail.com'),
       ('3', 'Fedor Fedorov', '1990-07-02', null);

insert into memberships (membership_id, until, number_of_visits, club_id, client_id) 
values ('1', '2021-03-12', 30, 1, 1),
       ('2', '2019-04-07', 50, 1, 1),
       ('3', '2022-01-02', 5, 2, 2),
       ('4', '2022-01-03', 10, 1, 2),
       ('5', '2022-03-08', 15, 2, 3);

insert into trainers (trainer_id, trainer_name, sports_category, current_price, salary, club_id) 
values ('1', 'Vasily Pupkin', 'Master of sports', 2000, 50000, 1),
       ('2', 'Vladimir Sidorov', null, 1000, 30000, 1),
       ('3', 'Arina Romanova', 'Candidate Master of sports', 2300, 40000, 1),
       ('4', 'Vitaly Rodionov', null, 3000, 40000, 2),
       ('5', 'Anna Pavlova', 'Master of sports', 5000, 60000, 2);

insert into pools (pool_id, lane_count, lane_length, club_id) 
values ('1', 5, 25, 1),
       ('2', 5, 20, 2),
       ('3', 3, 10, 2);

insert into equipment (equipment_id, equipment_name, club_id) 
values ('1', 'Treadmill', 1),
       ('2', 'Treadmill', 2),
       ('3', 'Treadmill', 2),
       ('4', 'Rowing machine', 1),
       ('5', 'Rowing machine', 2),
       ('6', 'Stepper', 1),
       ('7', 'Stepper', 2),
       ('8', 'Stepper', 2);

insert into rooms (room_id, room_name, area, club_id) 
values ('1', 'Small room', 30, 1),
       ('2', 'Big room', 50, 1),
       ('3', 'Super room', 30, 2),
       ('4', 'Mega room', 40, 2);

insert into trainings (training_date, start_time, price, client_id, trainer_id) 
values ('2020-04-03', '15:30:00', 2000, 1, 1),
       ('2020-03-03', '15:30:00', 2000, 1, 1),
       ('2020-03-03', '17:00:00', 2000, 2, 1),
       ('2019-02-05', '19:00:00', 700, 2, 2),
       ('2021-01-01', '19:30:00', 3000, 3, 4);

insert into group_workouts (day, starts, ends, workout_name, room_id, trainer_id) 
values  ('Monday', '16:00:00', '17:00:00', 'Pilates', 1, 2),
        ('Tuesday', '13:00:00', '14:00:00', 'Yoga', 2, 1),
        ('Monday', '15:00:00', '16:00:00', 'Zumba', 3, 4),
        ('Friday', '20:00:00', '21:00:00', 'Stretching', 4, 5);