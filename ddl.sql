create type day_of_week as enum('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
create type sports_category as enum('Master of sports', 'Candidate Master of sports');

create table addresses
(
    address_id  int primary key,
    country     varchar(100) not null,
    region      varchar(100) not null,
    city        varchar(100) not null,
    street      varchar(100) not null,
    building    varchar(20) not null
);

create table clubs
(
    club_id     int not null primary key,
    club_name   varchar(100) not null unique,
    address_id  int not null references addresses (address_id)
);

create table working_hours
(
    day             day_of_week not null,
    opens_at        time not null,
    closes_at       time not null,
    break_starts    time not null,
    break_ends      time not null,
    club_id         int references clubs (club_id),
    primary key (day, club_id)
);

create table clients
(
    client_id       int not null primary key,
    client_name     varchar(100) not null,
    birthday        date not null,
    email           varchar(254)
);

create table memberships
(
    membership_id       int not null primary key,
    until               date not null,
    number_of_visits    int not null,
    club_id             int references clubs (club_id),
    client_id           int references clients (client_id)
);

create table trainers
(
    trainer_id       int not null primary key,
    trainer_name     varchar(100) not null,
    sports_category  sports_category,
    current_price    int not null,
    salary           int not null,
    club_id          int references clubs (club_id)
);

create table trainings
(
    training_date    date not null,
    start_time       time not null,
    price            int not null,
    trainer_id       int references trainers (trainer_id),
    client_id        int references clients (client_id),
    primary key (training_date, start_time, trainer_id)
);

create table equipment
(
    equipment_id     int not null primary key,
    equipment_name   varchar(100) not null,
    club_id       int references clubs (club_id)
);

create table pools
(
    pool_id       int not null primary key,
    lane_count    int not null,
    lane_length   int not null,
    club_id       int references clubs (club_id)
);

create table rooms
(
    room_id     int not null primary key,
    room_name   varchar(100) not null,
    area        int not null,
    club_id     int references clubs (club_id)
);

create table group_workouts
(
    day             day_of_week not null,
    starts          time not null,
    ends            time not null,
    workout_name    varchar(100) not null,
    room_id         int not null references rooms (room_id),
    trainer_id      int not null references trainers (trainer_id),
    primary key (day, starts, room_id)
);

-- NOTE: Индексые не на все FK

--Запросы связанные с поиском по имени
create index clientNames on clients (client_name);
create index trainerNames on trainers (trainer_name);
create index clubNames on clubs (club_name);

--Запросы связанные с поиском по дате и времени
create index timeTrainings on trainings(training_date, start_time);
create index sheduleWorkout on group_workouts(day, starts);
create index untilMembership on memberships(until);

--Получение club_id по абонементу и по тренеру
create index clubMemberships on memberships(club_id);
create index clubTrainers on trainers(club_id);
