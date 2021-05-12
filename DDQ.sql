DROP TABLE IF EXISTS `Tickets`;
DROP TABLE IF EXISTS `Movies_Auditoriums`;
DROP TABLE IF EXISTS `Auditoriums`;
DROP TABLE IF EXISTS `Projector_Equipments`;
DROP TABLE IF EXISTS `Customers`;
DROP TABLE IF EXISTS `Theaters`;
DROP TABLE IF EXISTS `Movies`;

CREATE TABLE `Movies` (
	`movie_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(50) NOT NULL UNIQUE,
    `release_date` date NOT NULL,
    `out_of_theater_date` date NOT NULL,
    `rating` varchar(50) NOT NULL
);

INSERT INTO `Movies` (`name`, `release_date`, `out_of_theater_date`, `rating`) VALUES 
	('Star Wars', '1977-06-06', '1977-11-11', 'G'),
    ('Jurassic Park', '1993-07-07', '1993-12-01', 'PG'),
    ('The Godfather',	'1972-05-01',	'1972-10-01',	'PG-13');

CREATE TABLE `Theaters` (
	`theater_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `address` varchar(255) NOT NULL,
    `phone` varchar(50) NOT NULL
);

INSERT INTO `Theaters` (`name`, `address`, `phone`) VALUES
	('Amazing Century', '10250 Santa Monica Blvd #2000, Los Angeles, CA 90067', '310-777-2222'),
    ('Amazing Empire', '234 W 42nd St, New York, NY 10036', '212-333-2555'),
    ('Amazing Pacific', '600 Pine St #400, Seattle, WA 98101', '206-655-8999');

CREATE TABLE `Customers` (
	`customer_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `email` varchar(50) NOT NULL,
    `phone` varchar(50) NOT NULL
);

INSERT INTO `Customers` (`name`, `email`, `phone`) VALUES 
	('Batman', 'batman@batmail.com', '111-555-8888'),
    ('Superman', 'superman@supermail.com', '222-333-4444'),
    ('Spiderman',	'spiderman@spidermail.com',	'777-888-9999');

CREATE TABLE `Projector_Equipments` (
	`projector_equipment_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type` varchar(50) NOT NULL
);

INSERT INTO `Projector_Equipments` (`type`) VALUES 
	('Digital'),
    ('IMAX'),
    ('3D');

CREATE TABLE  `Auditoriums` (
	`auditorium_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(50) NOT NULL,
    `number_of_seats` int NOT NULL,
    `theater_id` int NOT NULL,
    `projector_equipment_id` int NOT NULL,
    FOREIGN KEY (theater_id)
    REFERENCES `Theaters` (theater_id),
	FOREIGN KEY (projector_equipment_id)
    REFERENCES `Projector_Equipments` (projector_equipment_id)
);

INSERT INTO `Auditoriums` (`name`, `number_of_seats`, `theater_id`, `projector_equipment_id`) VALUES 
	('Blue', 200, 1, 1),
    ('Green', 400, 1, 2),
    ('Red', 300, 1, 3),
	('Diamond', 200, 2, 1),
    ('Ruby', 400, 2, 2),
    ('Sapphire', 300, 2, 3),
    ('51', 200, 2, 1),
    ('41', 400, 2, 2),
    ('31', 300, 2, 3);

CREATE TABLE `Movies_Auditoriums` (
	`movie_auditorium_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `time_slot` time NOT NULL,
	`movie_id` int NOT NULL,
    `auditorium_id` int NOT NULL,
	FOREIGN KEY (movie_id)
    REFERENCES `Movies` (movie_id),
	FOREIGN KEY (auditorium_id)
    REFERENCES `Auditoriums` (auditorium_id)
);

INSERT INTO `Movies_Auditoriums` (`time_slot`, `movie_id`, `auditorium_id`) VALUES 
	('14:00:00', 1, 1), ('16:30:00', 1, 1), ('19:00:00', 1, 1),
	('21:30:00', 2, 2), ('10:00:00', 2, 2), ('12:20:00', 2, 2),
    ('14:30:00', 3, 3), ('17:00:00', 3, 3), ('19:30:00', 3, 3),
	('14:00:00', 1, 4), ('16:30:00', 1, 4), ('19:00:00', 1, 4),
	('21:30:00', 2, 5), ('10:00:00', 2, 5), ('12:20:00', 2, 5),
    ('14:30:00', 3, 6), ('17:00:00', 3, 6), ('19:30:00', 3, 6),
	('14:00:00', 1, 7), ('16:30:00', 1, 7), ('19:00:00', 1, 7),
	('21:30:00', 2, 8), ('10:00:00', 2, 8), ('12:20:00', 2, 8),
    ('14:30:00', 3, 9), ('17:00:00', 3, 9), ('19:30:00', 3, 9);

CREATE TABLE `Tickets` (
	`ticket_id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `seat` varchar(50) NOT NULL,
    `time` datetime NOT NULL,
    `price` decimal NOT NULL,
    `movie_auditorium_id` int NOT NULL,
    `customer_id` int,
	FOREIGN KEY (movie_auditorium_id)
    REFERENCES `Movies_Auditoriums` (movie_auditorium_id),
    FOREIGN KEY (customer_id)
    REFERENCES `Customers` (customer_id)
);

INSERT INTO `Tickets` (`seat`, `time`, `price`, `movie_auditorium_id`, `customer_id`) VALUES 
	('E11', '1977-06-08-14:00:00', 200, 1, 1), ('E12', '1977-08-13-14:00:00', 200, 1, 1), ('G10', '1977-10-11-19:00:00', 250, 1, null),
	('F15', '1993-07-07-21:30:00', 200, 2, 2), ('K18', '1993-08-01-10:00:00', 200, 2, 3), ('J21', '1993-09-15-12:20:00', 250, 2, 3),
    ('H15', '1972-05-05-14:30:00', 200, 3, 3), ('I20', '1972-06-10-17:00:00', 200, 3, 3), ('F22', '1972-09-18-19:30:00', 250, 3, null),
	('E11', '1977-06-08-14:00:00', 400, 4, 1), ('E12', '1977-08-13-14:00:00', 400, 4, 1), ('G10', '1977-10-11-19:00:00', 500, 4, null),
	('F15', '1993-07-07-21:30:00', 400, 5, 2), ('K18', '1993-08-01-10:00:00', 400, 5, 3), ('J21', '1993-09-15-12:20:00', 400, 5, 3),
    ('H15', '1972-05-05-14:30:00', 400, 6, 3), ('I20', '1972-06-10-17:00:00', 400, 6, 3), ('F22', '1972-09-18-19:30:00', 500, 6, null),
	('E11', '1977-06-08-14:00:00', 300, 7, 1), ('E12', '1977-08-13-14:00:00', 300, 7, 1), ('G10', '1977-10-11-19:00:00', 375, 7, null),
	('F15', '1993-07-07-21:30:00', 300, 8, 2), ('K18', '1993-08-01-10:00:00', 300, 8, 3), ('J21', '1993-09-15-12:20:00', 300, 8, 3),
    ('H15', '1972-05-05-14:30:00', 300, 9, 3), ('I20', '1972-06-10-17:00:00', 300, 9, 3), ('F22', '1972-09-18-19:30:00', 375, 9, null);




