-- This SQL script is an exercise in Data Definition/Data Manipulation Language (DDL/DML) 

-- Key Notes: 
-- This script was part of an academic project for undergraduate studies in database design.
-- The schema creation was designed to reflect a rental car company's OLAP or OLTP systems.
-- The data used in this DB was randomly generated using Mockaroo.com and is entirely notional.


-- DATABASE CREATION

DROP DATABASE IF EXISTS ArmandsRentalCars;
CREATE DATABASE ArmandsRentalCars;
USE ArmandsRentalCars;


-- TABLE CREATION & INPUT SECTION

-- The Store table will hold values that identify the location of a specific rental car store in the chain.
-- Armand's Rental Cars currently has five stores across California and Nevada.
DROP TABLE IF EXISTS Store
CREATE TABLE Store
(
store_id CHAR(4) NOT NULL PRIMARY KEY,
city VARCHAR(15),
state VARCHAR(15),
zip CHAR(5),
street VARCHAR(50)
);

INSERT INTO Store (store_id, city, state, zip, street)
VALUES (7495, 'Escondido', 'California' , 92030 , '88986 Raven Hill'),
(4939, 'Los Angeles' , 'California', 90015, '67729 Schiller Way'),
(5036, 'Reno', 'Nevada', 89510, '640 Sycamore Drive'),
(5594, 'Las Vegas', 'Nevada', 89115, '28 Autumn Leaf Avenue'),
(1523, 'Las Vegas', 'Nevada', 89125, '39 Lakewood Gardens Street');


-- The purpose of the Employee table is to hold employee data that can be used to reference who made a particular sale.
CREATE TABLE Employee
(
employee_id CHAR(4) NOT NULL PRIMARY KEY,
store_id CHAR(4),
name VARCHAR(50),
CONSTRAINT FK_Employee_Data FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

INSERT INTO Employee (employee_id, store_id, name)
VALUES (1100, 7495, 'Cosimo Shapira'), (1000, 7495, 'Shanda De Filippi'), (1098, 7495, 'Delmer Capehorn'), (1091, 7495, 'Louise Wittier'),
(1058, 7495, 'Perle Soper'), (1033, 7495, 'Jdavie Schubbert'), (1050, 7495, 'Giordano Arrighini'), (1004, 7495, 'Boot Longcake'),
(1060, 7495, 'Cooper Krahl'), (1048, 7495, 'Britni Heavy'), (1028, 4939, 'Fay MacIlurick'), (1013, 4939, 'Salvador Gilvary'), (1097, 4939, 'Kimbra Gheraldi'),
(1059, 4939, 'Sarette Arons'), (1099, 4939, 'Dennie Dilon'), (1030, 4939, 'Stanleigh Brosius'), (1077, 5036, 'Claudell Rikel'), (1066, 5036, 'Fey Meric'),
(1049, 5036, 'Tony Whistlecraft'), (1082, 5036, 'Gallagher Evason'), (1014, 5036, 'Maury Kennefick'), (1051, 5036, 'Rand Easton'), (1083, 5036, 'Kasey Zanettini'),
(1029, 5036, 'Case Ewins'), (1073, 5594, 'Rip Avrahamy'), (1079, 5594, 'Allina McGuggy'), (1012, 5594, 'Stephenie Doniso'), (1086, 5594, 'Elvira Roelofsen'),
(1068, 5594, 'Karon De Ferraris'), (1096, 5594, 'Robbie Waldram'), (1070, 5594, 'Jeno Fossord'), (1010, 5594, 'Ives Lamb-shine'), (1078, 5594, 'Alix Casacchia'),
(1071, 5594, 'Terence Soldner'), (1081, 1523, 'Olive Waszczykowski'), (1065, 1523, 'Dexter OCalleran'), (1025, 1523, 'Madella Blunsden'), (1024, 1523, 'Ari Hector'),
(1072, 1523, 'Tiphani Croydon'), (1009, 1523, 'Clerc Coase'), (1046, 1523, 'Renate Sheach'), (1035, 1523, 'Allie Beig'), (1027, 1523, 'Bing Antonoyev'),
(1074, 1523, 'Marcy Huncote'), (1093, 1523, 'Marthena Batram'), (1067, 1523, 'Clark Auchterlonie'), (1094, 1523, 'Zola Wegner'), (1061, 1523, 'Miguel Reuble'),
(1075, 1523, 'Berni Wisdom'), (1069, 1523, 'Bogart Meates');


-- The Vehicle table stores identifying information about a particular rental car in the inventory.
-- Column 'passenger_cap' references the passenger capacity of the vehicle.
CREATE TABLE Vehicle
(
VIN CHAR(17) NOT NULL PRIMARY KEY,
store_id CHAR(4),
make VARCHAR(15),
model VARCHAR(15),
year CHAR(4),
rate DECIMAL(5,2),
passenger_cap CHAR(2),
CONSTRAINT FK_Store_Info FOREIGN KEY (store_id) REFERENCES Store(store_id)
);

INSERT INTO Vehicle (VIN, store_id, make, model, year, rate, passenger_cap)
VALUES ('WAUJT68E52A554644', 5594, 'Chevrolet','Corvette', 2020, 44.99, 2),
('91FTEX1CM3BF34831', 5594, 'GMC', 'Savana 1500', 2019, 79.99, 6),
('GKS1EEF5CR7178547', 5594, 'Buick', 'Skylark', 2020, 79.99, 4),
('WAUGU54D71N576411', 5594, 'Land Rover', 'Range Rover', 2021, 109.99, 8),
('YV1940AS1B1045628', 5594, 'Infiniti', 'M', 2019, 79.99, 4),
('1FTMF1EW5AK312675', 5594, 'GMC', 'Yukon XL 2500', 2018, 109.99, 6),
('2HNYD28407H287642', 5594, 'Spyker', 'C8', 2020, 169.99, 2),
('1G6AC5S33D0539317', 5594, 'Mercury', 'Mariner', 2020, 44.99, 4),
('1N6AF0LX6FN568676', 5594, 'Chevrolet', 'Suburban 2500', 2018, 44.99, 6),
('JTDKDTB39E1485763', 5594, 'Dodge', 'Ram 3500', 2019, 79.99, 4),
('2V4RW3D17AR522518', 4939, 'Jaguar', 'XJ', 2021, 109.99, 6),
('1G6DS5ED6B0334172', 4939, 'Buick', 'Century', 2019, 79.99, 4),
('WBAUN7C5XCV911900', 4939, 'Mercedes-Benz', 'C-Class', 2018, 109.99, 4),
('WAUML44EX4N524896', 4939, 'Pontiac', 'Vibe', 2016, 44.99, 4),
('5N1AN0NU6AC832861', 4939, 'BMW', 'Z8', 2018, 109.99, 2),
('5GALRAED8AJ071187', 4939, 'Audi', '200', 2020, 109.99, 4),
('JN1AJ0HP3AM723616', 4939, 'Oldsmobile', 'Silhouette', 2017, 44.99, 4),
('19UYA42592A483728', 4939, 'Cadillac', 'DeVille', 2019, 79.99, 4),
('1NXBU4EE6AZ913344', 4939, 'Toyota', 'Solara', 2020, 79.99, 4),
('JN8AE2KP8C9953328', 4939, 'Ford', 'F250', 2021, 169.99, 6),
('WAUPFBFM4BA831658', 5036, 'Ford', 'Ranger', 2022, 169.99, 6),
('JN8AF5MR9DT553506', 5036, 'Plymouth', 'Neon', 2019, 44.99, 4),
('1G6DS5EV5A0550330', 5036, 'BMW', 'M6', 2022, 169.99, 2),
('KMHFG4JG6EA159580', 5036, 'Infiniti', 'IPL G', 2020, 169.99, 6),
('WAUEKAFB4BN305504', 5036, 'Pontiac', 'Tempest', 2017, 44.99, 4),
('WAUWGAFB7BN196073', 5036, 'Buick', 'Regal', 2018, 44.99, 4),
('WAUDK78T78A347704', 5036, 'Chevrolet', 'Malibu Maxx', 2019, 79.99, 4),
('1GYUCDEF7AR656569', 5036, 'Buick', 'Century', 2018, 79.99, 4),
('SAJWA0HPXEM570050', 5036, 'Plymouth', 'Horizon', 2017, 44.99, 4),
('KNAFT4A27B5177690', 5036, 'Lexus', 'LS', 2020, 169.99, 4),
('KMHCM3AC3BU863474', 7495, 'Mazda', 'Tribute', 2016, 79.99, 4),
('19XFB2F59EE058500', 7495, 'BMW', '3 Series', 2016, 169.99, 4),
('1G6DU6ED0B0040833', 7495, 'Ford', 'Aerostar', 2018, 79.99, 4),
('WBA3K5C52EK537375', 7495, 'Pontiac', 'Grand Prix', 2016, 44.99, 4),
('5LMJJ3H56BE652736', 7495, 'Maserati', 'Spyder', 2019, 109.99, 2),
('3CZRE3H39AG979856', 7495, 'GMC', 'Sierra 3500', 2016, 79.99, 6),
('3VW4A7AT3CM735487', 7495, 'Honda', 'S2000', 2021, 44.99, 2),
('SAJWA4FC8EM329059', 7495, 'Chevrolet', 'Astro', 2017, 79.99, 4),
('SCFFBCCDXBG910223', 7495, 'Chevrolet', 'Classic', 2018, 79.99, 4),
('3GYEK62827G990557', 7495, 'Lexus', 'LX', 2019, 109.99, 6),
('1FMCU0C78BK225616', 1523, 'Volkswagen', 'Touareg', 2019, 79.99, 6),
('JH4DC54836S778911', 1523, 'Mercury', 'Mountaineer', 2017, 44.99, 6),
('WBAVB13546K196208', 1523, 'Chevrolet', 'Avalanche 2500', 2016, 109.99, 6),
('WAUDV94F87N564463', 1523, 'Jeep', 'Wrangler', 2019, 79.99, 4),
('JH4DB75661S159921', 1523, 'Bugatti', 'Veyron', 2022, 169.99, 2),
('WDDHF0EB7EA893321', 1523, 'Chevrolet', 'Cobalt', 2019, 79.99, 4),
('1N4AA5AP7BC494598', 1523, 'Mazda', 'Mazdaspeed 3', 2020, 79.99, 4),
('YV1672MC3AJ249131', 1523, 'Dodge', 'Dakota Club', 2016, 79.99, 4),
('KNAFX6A87F5941029', 1523, 'Cadillac', 'Escalade EXT', 2018, 109.99, 8),
('19UUA65594A991884', 1523, 'Saturn', 'S-Series', 2017, 44.99, 4),
('WVWED7AJXBW845674', 1523, 'Mitsubishi', 'Montero', 2018, 44.99, 4),
('2C3CA4CD8AH541511', 1523, 'Plymouth', 'Neon', 2020, 44.99, 4);


-- This table allows for the categorization of a particular vehicle by their class or type. (Sedan, Compact, etc.)
CREATE TABLE Vehicle_type
(
VIN CHAR(17) NOT NULL PRIMARY KEY,
category VARCHAR(10)
);

INSERT INTO Vehicle_type
VALUES ('WAUJT68E52A554644', 'Sports Car'), ('91FTEX1CM3BF34831', 'Van'), ('GKS1EEF5CR7178547', 'Sports Car'),
('WAUGU54D71N576411', 'SUV'), ('YV1940AS1B1045628', 'Sedan'), ('1FTMF1EW5AK312675', 'SUV'), ('2HNYD28407H287642', 'Sports Car'),
('1G6AC5S33D0539317', 'SUV'), ('1N6AF0LX6FN568676', 'SUV'), ('JTDKDTB39E1485763', 'Truck'), ('2V4RW3D17AR522518', 'Sedan'),
('1G6DS5ED6B0334172', 'Sedan'), ('WBAUN7C5XCV911900', 'Sedan'), ('WAUML44EX4N524896', 'Compact'), ('5N1AN0NU6AC832861', 'Sports Car'),
('5GALRAED8AJ071187', 'Compact'), ('JN1AJ0HP3AM723616', 'Van'), ('19UYA42592A483728', 'Sedan'), ('1NXBU4EE6AZ913344', 'Sedan'),
('JN8AE2KP8C9953328', 'Truck'), ('WAUPFBFM4BA831658', 'Truck'), ('JN8AF5MR9DT553506', 'Compact'), ('1G6DS5EV5A0550330', 'Sports Car'),
('KMHFG4JG6EA159580', 'Compact'), ('WAUEKAFB4BN305504', 'Sedan'), ('WAUWGAFB7BN196073', 'Sedan'), ('WAUDK78T78A347704', 'Sedan'),
('1GYUCDEF7AR656569', 'Sedan'), ('SAJWA0HPXEM570050', 'Compact'), ('KNAFT4A27B5177690', 'Sedan'), ('KMHCM3AC3BU863474', 'SUV'),
('19XFB2F59EE058500', 'Sedan'), ('1G6DU6ED0B0040833', 'Van'), ('WBA3K5C52EK537375', 'Coupe'), ('5LMJJ3H56BE652736', 'Sports Car'),
('3CZRE3H39AG979856', 'Truck'), ('3VW4A7AT3CM735487', 'Sports Car'), ('SAJWA4FC8EM329059', 'Van'), ('SCFFBCCDXBG910223', 'Sedan'),
('3GYEK62827G990557', 'SUV'), ('1FMCU0C78BK225616', 'SUV'), ('JH4DC54836S778911', 'SUV'), ('WBAVB13546K196208', 'Truck'),
('WAUDV94F87N564463', 'SUV'), ('JH4DB75661S159921', 'Sports Car'), ('WDDHF0EB7EA893321', 'Compact'), ('1N4AA5AP7BC494598', 'Compact'),
('YV1672MC3AJ249131', 'Truck'), ('KNAFX6A87F5941029', 'SUV'), ('19UUA65594A991884', 'Sedan'),('WVWED7AJXBW845674', 'Sedan'),
('2C3CA4CD8AH541511', 'Compact');


-- The purpose of this table is to identify specific services/maintenance performed on a vehicle.
CREATE TABLE Service
(
service_id CHAR(4) NOT NULL PRIMARY KEY,
VIN CHAR(17) NOT NULL,
service_type VARCHAR(30),
CONSTRAINT FK_VIN_Data FOREIGN KEY (VIN) REFERENCES Vehicle(VIN)
);

INSERT INTO SERVICE
VALUES (2018, '2C3CA4CD8AH541511', 'Brakes'), (3299, 'WVWED7AJXBW845674', 'Oil Change'), (1617, '19UUA65594A991884', 'Oil Change'), (1252, 'KNAFX6A87F5941029', 'Battery'), 
(2900, 'JH4DB75661S159921', 'Timing Belt'), (1455, 'KNAFT4A27B5177690', 'Oil Change'), (1499, 'WAUEKAFB4BN305504', 'Tires'), (2176, '1N6AF0LX6FN568676', 'Engine'), 
(2110, 'JN1AJ0HP3AM723616', 'Air Filter'), (3813, 'GKS1EEF5CR7178547', 'Air Filter'), (3868, '91FTEX1CM3BF34831', 'Alignment'),(2513, 'WAUDK78T78A347704', 'Oil Change'), 
(2041, '5GALRAED8AJ071187', 'Tires'), (2263, '1G6DS5EV5A0550330', 'Engine'), (1035, 'WAUPFBFM4BA831658', 'Air Filter'), (2415, 'WAUDV94F87N564463', 'Wiper Blade'), 
(1542, '1FMCU0C78BK225616', 'Tires'), (1918, '2HNYD28407H287642', 'Brakes'), (1832, 'WAUWGAFB7BN196073', 'Engine'), (2340, 'WAUGU54D71N576411', 'Air Filter'), 
(3538, 'KMHFG4JG6EA159580', 'Alignment'), (3681, '5N1AN0NU6AC832861', 'Alignment'), (2683, 'WAUDK78T78A347704', 'Oil Change'), (3578, '1GYUCDEF7AR656569', 'Oil Change'), 
(3061, 'JN8AE2KP8C9953328', 'Brakes'), (3777, 'SAJWA0HPXEM570050', 'Air Filter'), (2557, '1NXBU4EE6AZ913344', 'Alignment'), (2890, '1N4AA5AP7BC494598', 'Timing Belt'), 
(3730, 'GKS1EEF5CR7178547', 'Oil Change'), (2253, 'WAUDV94F87N564463', 'Battery'), (2181, 'JTDKDTB39E1485763', 'Engine'), (2981, '2V4RW3D17AR522518', 'Oil Change'), 
(2964, '3GYEK62827G990557', 'Alignment'), (1947, '1G6AC5S33D0539317', 'Alignment'), (3140, 'WAUEKAFB4BN305504', 'Tires'), (3269, '1GYUCDEF7AR656569', 'Engine'), 
(2901, 'JTDKDTB39E1485763', 'Brakes'), (3511, '1G6DS5EV5A0550330', 'Oil Change'), (2932, '19XFB2F59EE058500', 'Air Filter'), (2008, 'WAUEKAFB4BN305504', 'Timing Belt'), 
(3621, 'JN1AJ0HP3AM723616', 'Brakes'), (3364, 'SAJWA0HPXEM570050', 'Battery'), (1480, '1NXBU4EE6AZ913344', 'Oil Change'), (3676, '1N6AF0LX6FN568676', 'Oil Change'), 
(3223, 'KMHFG4JG6EA159580', 'Coolant'), (3037, '3GYEK62827G990557', 'Exhaust'), (3921, 'WAUML44EX4N524896', 'Oil Change'), (2131, 'KNAFT4A27B5177690', 'Oil Change'), 
(2757, '1G6DS5EV5A0550330', 'Tires'), (1989, 'SAJWA4FC8EM329059', 'Wiper Blade'), (2933, '1FMCU0C78BK225616', 'Spark Plugs'), (3775, '1G6DU6ED0B0040833', 'Alternator'), 
(1444, '5LMJJ3H56BE652736', 'Brakes');


-- The Service_Record table will hold a vehicle's service history with the intent of making scheduled maintenance easier to track.
CREATE TABLE Service_Record
(
service_id CHAR(4) NOT NULL,
VIN CHAR(17) NOT NULL,
service_date DATE,
CONSTRAINT FK_Service FOREIGN KEY (service_id) REFERENCES Service(service_id),
CONSTRAINT FK_VIN_Info FOREIGN KEY (VIN) REFERENCES Vehicle(VIN)
);

INSERT INTO Service_Record 
VALUES (2018, '2C3CA4CD8AH541511', '2021-11-14'), (3299, 'WVWED7AJXBW845674', '2021-09-23'), (1617, '19UUA65594A991884', '2021-09-16'), 
(1252, 'KNAFX6A87F5941029', '2021-09-16'), (2900, 'JH4DB75661S159921', '2021-11-17'), (2513, 'WAUDK78T78A347704', '2021-09-16'), 
(2041, '5GALRAED8AJ071187', '2021-10-08'), (2263, '1G6DS5EV5A0550330', '2021-10-01'), (1035, 'WAUPFBFM4BA831658', '2021-10-12'), 
(2415, 'WAUDV94F87N564463', '2021-10-18'), (1542, '1FMCU0C78BK225616', '2021-11-14'), (1918, '2HNYD28407H287642', '2021-10-08'), 
(1832, 'WAUWGAFB7BN196073', '2021-10-12'), (2340, 'WAUGU54D71N576411', '2021-11-02'), (3538, 'KMHFG4JG6EA159580', '2021-10-18'), 
(3681, '5N1AN0NU6AC832861', '2021-10-29'), (2018, '2C3CA4CD8AH541511', '2021-11-23'), (3299, 'WVWED7AJXBW845674', '2021-10-08'), 
(1617, '19UUA65594A991884', '2021-10-01'), (1252, 'KNAFX6A87F5941029', '2021-11-10'), (2900, 'JH4DB75661S159921', '2021-10-18'), 
(1455, 'KNAFT4A27B5177690', '2021-09-16'), (1499, 'WAUEKAFB4BN305504', '2021-09-15'), (2176, '1N6AF0LX6FN568676', '2021-11-17'),
(2110, 'JN1AJ0HP3AM723616', '2021-11-23'), (3813, 'GKS1EEF5CR7178547', '2021-10-25'), (3868, '91FTEX1CM3BF34831', '2021-10-29'),
(2513, 'WAUDK78T78A347704', '2021-09-23'), (2041, '5GALRAED8AJ071187', '2021-10-08'), (2263, '1G6DS5EV5A0550330', '2021-10-12'), 
(1035, 'WAUPFBFM4BA831658', '2021-11-10'), (2415, 'WAUDV94F87N564463', '2021-10-25'), (2683, 'WAUDK78T78A347704', '2021-09-16'), 
(3578, '1GYUCDEF7AR656569', '2021-09-15'), (3061, 'JN8AE2KP8C9953328', '2021-11-17'), (3777, 'SAJWA0HPXEM570050', '2021-11-01'), 
(2557, '1NXBU4EE6AZ913344', '2021-10-25'), (2890, '1N4AA5AP7BC494598', '2021-10-25'), (3730, 'GKS1EEF5CR7178547', '2021-10-12'), 
(2253, 'WAUDV94F87N564463', '2021-09-15'), (2181, 'JTDKDTB39E1485763', '2021-10-01'), (2981, '2V4RW3D17AR522518', '2021-10-18'), 
(2964, '3GYEK62827G990557', '2021-11-02'), (1947, '1G6AC5S33D0539317', '2021-10-25'), (2757, '1G6DS5EV5A0550330', '2021-10-18'), 
(1989, 'SAJWA4FC8EM329059', '2021-09-23'), (2933, '1FMCU0C78BK225616', '2021-10-01'), (3775, '1G6DU6ED0B0040833', '2021-11-17'), 
(1444, '5LMJJ3H56BE652736', '2021-09-23'), (1455, 'KNAFT4A27B5177690', '2021-09-18');


-- This table keeps track of each rental that has been made, and includes start/return dates and mileage for calculating costs.
CREATE TABLE Rental_Record
(
rental_no CHAR(6) NOT NULL PRIMARY KEY,
VIN CHAR(17),
customer_id CHAR(4),
pickup_date DATE,
return_date DATE,
start_mileage CHAR(6),
return_mileage CHAR(6),
CONSTRAINT FK_Vehicle_Record FOREIGN KEY (VIN) REFERENCES Vehicle(VIN)
);

INSERT INTO Rental_Record 
VALUES (243868, '2C3CA4CD8AH541511', 9568, '2021-10-20', '2021-10-21', 30326, 31519),
(295978, 'WVWED7AJXBW845674', 4289, '2021-10-14', '2021-10-19', 26848, 27854),
(543915, '19UUA65594A991884', 7243, '2021-11-01', '2021-11-12', 11467, 13546),
(674933, 'KNAFX6A87F5941029', 7907, '2021-10-09', '2021-10-12', 33767, 34868),
(839100, 'YV1672MC3AJ249131', 6471, '2021-11-04', '2021-11-11', 47392, 48396),
(801854, '1N4AA5AP7BC494598', 4845, '2021-11-08', '2021-11-22', 45323, 47449),
(450319, 'WAUDV94F87N564463', 6836, '2021-08-12', '2021-09-01', 13579, 15047),
(148064, 'WBAVB13546K196208', 6780, '2021-09-23', '2021-10-05', 41166, 47331),
(471820, 'JH4DC54836S778911', 3593, '2021-11-12', '2021-11-27', 15146, 19370),
(282131, '1FMCU0C78BK225616', 4589, '2021-10-09', '2021-10-24', 20332, 21591),
(881472, 'SCFFBCCDXBG910223', 2111, '2021-10-25', '2021-01-24', 30462, 6344),
(851021, '1G6DU6ED0B0040833', 9665, '2021-11-04', '2021-11-17', 42973, 43535),
(557992, 'WBA3K5C52EK537375', 4234, '2021-09-07', '2021-09-10', 40139, 40857),
(709173, '19XFB2F59EE058500', 5373, '2021-10-05', '2021-10-15', 23444, 24768),
(823402, '19XFB2F59EE058500', 5659, '2021-10-05', '2021-10-27', 33583, 34183),
(745611, '1N6AF0LX6FN568676', 8980, '2021-11-26', '2021-11-28', 43450, 44425),
(838021, '91FTEX1CM3BF34831', 1299, '2021-09-20', '2021-09-21', 34632, 34844),
(359353, 'WAUWGAFB7BN196073', 8773, '2021-07-22', '2021-08-09', 32642, 33947),
(509895, 'WAUGU54D71N576411', 5266, '2021-11-16', '2021-12-02', 22336, 8347),
(155518, '1FTMF1EW5AK312675', 9940, '2021-09-30', '2021-10-04', 35505, 36755),
(104680, '2V4RW3D17AR522518', 3266, '2021-09-06', '2021-09-12', 7775, 8816),
(730302, '1G6AC5S33D0539317', 7736, '2021-11-07', '2021-11-16', 11832, 13103),
(347284, 'WAUDK78T78A347704', 5671, '2021-10-10', '2021-10-13', 41636, 42254),
(945851, 'JN8AF5MR9DT553506', 7882, '2021-09-04', '2021-09-14', 40797, 43100),
(612272, '3GYEK62827G990557', 8096, '2021-10-23', '2021-11-15', 41104, 44489),
(826927, 'KMHFG4JG6EA159580', 9482, '2021-11-09', '2021-11-19', 20641, 22083),
(228168, 'KMHCM3AC3BU863474', 7185, '2021-11-08', '2021-11-13', 47297, 47753),
(254349, 'JH4DB75661S159921', 3284, '2021-09-02', '2021-09-04', 17286, 18905),
(312088, '1G6DU6ED0B0040833', 5181, '2021-09-21', '2021-10-01', 29991, 32525),
(254984, '1GYUCDEF7AR656569', 4046, '2021-09-14', '2021-09-17', 23866, 24750),
(493469, '19XFB2F59EE058500', 1728, '2021-09-04', '2021-09-13', 30655, 32001),
(181499, '3VW4A7AT3CM735487', 8874, '2021-08-20', '2021-08-26', 36239, 38061),
(249573, '5LMJJ3H56BE652736', 2355, '2021-10-01', '2021-10-12', 48756, 49946),
(978313, '1G6DS5EV5A0550330', 2909, '2021-10-20', '2021-10-24', 38836, 39912),
(679665, 'WAUDV94F87N564463', 8529, '2021-10-25', '2021-10-27', 34833, 35973),
(464715, '5GALRAED8AJ071187', 4950, '2021-10-09', '2021-10-11', 11810, 12064),
(938638, '2HNYD28407H287642', 3798, '2021-08-24', '2021-08-30', 32449, 33443),
(422159, 'WAUJT68E52A554644', 8771, '2021-11-09', '2021-11-15', 38109, 39734),
(139656, 'YV1940AS1B1045628', 1259, '2021-08-11', '2021-08-13', 39524, 39654),
(472309, '1N6AF0LX6FN568676', 9744, '2020-10-23', '2021-10-29', 42834, 43152),
(457932, '1FMCU0C78BK225616', 8716, '2021-09-26', '2021-10-12', 36031, 38567),
(594509, 'WBA3K5C52EK537375', 4949, '2021-09-06', '2021-09-10', 29123, 30903),
(278372, 'KNAFT4A27B5177690', 1077, '2021-08-23', '2021-08-27', 16873, 18405),
(183971, 'JN8AF5MR9DT553506', 9986, '2021-09-07', '2021-09-08', 39078, 39294),
(209972, 'JTDKDTB39E1485763', 7218, '2021-08-08', '2021-08-26', 21912, 23110),
(782231, 'GKS1EEF5CR7178547', 6952, '2021-10-25', '2021-10-28', 13994, 14464),
(492666, 'SCFFBCCDXBG910223', 4414, '2021-09-01', '2021-09-14', 41392, 42023),
(750007, 'SAJWA4FC8EM329059', 4697, '2021-11-20', '2021-11-23', 48012, 49494),
(340771, '1G6DU6ED0B0040833', 6802, '2021-10-24', '2021-10-29', 26391, 28995),
(895350, 'KMHCM3AC3BU863474', 4397, '2021-08-10', '2021-08-14', 28637, 29420),
(895352, 'KMHCM3AC3BU863474', 4907, '2021-08-15', '2021-08-18', 29421, 30020);


-- The Customer table holds key customer information that can be used in account creation and subsequent analysis.
CREATE TABLE Customer
(
customer_id CHAR(4) NOT NULL PRIMARY KEY,
rental_no CHAR(6),
svc_employee CHAR(4),
name VARCHAR(50),
phone_no VARCHAR(15),
email VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code CHAR(5)
);

INSERT INTO Customer 
VALUES (9568, 243868, 1100, 'Tybie Whittle','915-889-9014', 'twhittle0@seattletimes.com', '83995 Morning Road', 'El Paso', 'Texas', 88525),
(4907, 895352, 1073, 'Anthea Skatcher', '912-830-7801', 'askatcher0@liveinternet.ru', '82	Bluejay Street', 'Savannah', 'Georgia', 31405),
(4397, 895350, 1000, 'Cate Whelband', '317-536-5073', 'cwhelband1@sohu.com', '6 Fieldstone Avenue', 'Indianapolis', 'Indiana', 46231),
(6802, 340771, 1098, 'Ora Rudram', '281-345-1028', 'orudram2@usatoday.com', '792 Vidon Circle', 'Spring', 'Texas', 77388),
(4697, 750007, 1091, 'Tessie Axleby', '205-591-8449', 'taxleby3@arizona.edu', '009 Arapahoe Junction', 'Birmingham', 'Alabama' ,35231),
(4414, 492666, 1058, 'Brnaby Rentenbeck', '650-169-8569', 'brentenbeck4@etsy.com', '354 Hoffman Terrace', 'Redwood City' ,'California',94064),
(6952, 782231, 1048, 'Guendolen Hawsby', '602-851-6231', 'ghawsby5@istockphoto.com', '2 Leroy Place', 'Scottsdale', 'Arizona', 85260),
(7218, 209972, 1059, 'Constantine Stanett', '585-721-0404', 'cstanett6@ow.ly', '06 Shasta Street', 'Rochester', 'New York', 14604),
(9986, 183971, 1073, 'Lynn Counihan', '209-594-9937', 'lcounihan7@comcast.net', '46801 Bowman Street', 'Stockton', 'California', 95210),
(1077, 278372, 1074, 'Layton Saintpierre', '916-130-1796', 'lsaintpierre8@bizjournals.com', '9 Pine View Drive', 'Sacramento', 'California', 94207),
(4949, 594509, 1075, 'Novelia Chisolm', '619-363-7251', 'nchisolm9@shop-pro.jp', '2589 Scofield Avenue', 'San Diego', 'California', 92110),
(8716, 457932, 1071, 'Denney Riehm', '843-128-3053', 'driehma@imgur.com', '92 Kropf Circle', 'Beaufort', 'South Carolina', 29905),
(9744, 472309, 1009, 'Cordula Keay', '410-129-9433', 'ckeayb@freewebs.com', '8152 Lotheville Street', 'Baltimore', 'Maryland', 21290),
(1259, 139656, 1009, 'Rahal Carette', '765-622-4701', 'rcarettec@sciencedaily.com', '4 Mendota Drive', 'Crawfordsville', 'Indiana', 47937),
(8771, 422159, 1009, 'Kylila Sivyour', '914-883-2774', 'ksivyourd@answers.com', '3654 Stuart Avenue', 'Mount Vernon', 'New York', 10557),
(3798, 938638, 1100, 'Peria Hacquard', '765-313-0718', 'phacquarde@irs.gov', '2356 Melody Circle', 'Anderson', 'Indiana', 46015),
(4950, 464715, 1046, 'Elsi Showalter', '407-712-4669', 'eshowalterf@umn.edu', '43 Oxford Street', 'Orlando', 'Florida', 32808),
(8529, 679665, 1065, 'Bret Bentham', '719-515-6397', 'bbenthamg@yelp.com', '796 Harbort Drive', 'Colorado Springs', 'Colorado', 80910),
(2909, 978313, 1061, 'Gerick Dawltrey', '503-153-9266', 'gdawltreyh@altervista.org', '4768 Lyons Plaza', 'Beaverton', 'Oregon', 97075),
(2355, 249573, 1014, 'Fredi Conibeer', '215-421-2884', 'fconibeeri@dailymail.co.uk', '98 Calypso Lane', 'Philadelphia', 'Pennsylvania', 19178),
(8874, 181499, 1010, 'Maud Weston', '443-766-4143', 'mwestonj@webmd.com', '254 John Wall Terrace', 'Baltimore', 'Maryland', 21229),
(1728, 493469, 1046, 'Dulce Shoesmith', '630-893-6850', 'dshoesmithk@goo.gl', '123 Myrtle Street', 'Chicago', 'Illinois', 60641),
(4046, 254984, 1010, 'Filmore Bolf', '505-115-8513', 'fbolfl@hostgator.com', '522 Corben Drive', 'Albuquerque', 'New Mexico', 87195),
(5181, 312088, 1100, 'Micaela Shobbrook', '786-360-3949', 'mshobbrookm@cbc.ca', '5788 Mccormick Center', 'Miami', 'Florida', 33111),
(3284, 254349, 1061, 'Verine Saunier', '904-515-7453', 'vsauniern@cdbaby.com', '9995 Village Park', 'Jacksonville', 'Florida', 32204),
(7185, 228168, 1082, 'Alida Goodsal', '720-362-8938', 'agoodsalo@google.cn', '246 Springs Road', 'Arvada', 'Colorado', 80005),
(9482, 826927, 1096, 'Chev Ambage', '808-146-9187', 'cambagep@dyndns.org', '8645 Doe Crossing Road', 'Honolulu', 'Hawaii', 96840),
(8096, 612272, 1049, 'Demetra OClovan', '805-764-4547', 'doq@epa.gov', '457 Eagan Avenue', 'San Luis Obispo', 'California', 93407),
(7882, 945851, 1060, 'Maye Dundon', '206-732-3321', 'mdundonr@epa.gov', '887 Vermont Street', 'Seattle', 'Washington', 98185),
(5671, 347284, 1000,  'Laurena MacShirie', '727-966-6369', 'lmacshiries@japanpost.jp', '126 Hoard Drive', 'Clearwater', 'Florida', 34629),
(7736, 730302, 1033, 'Bambie Hazlewood', '336-309-8357', 'bhazlewoodt@cafepress.com', '3423 Thackeray Lane', 'Greensboro', 'North Carolina', 27455),
(3266, 104680, 1004, 'Eben Hairesnape', '610-409-3812', 'ehairesnapeu@dagondesign.com', '841 Hudson Pass', 'Philadelphia', 'Pennsylvania', 19104),
(9940, 155518, 1004, 'Licha Brickdale', '937-900-9235', 'lbrickdalev@dot.gov', '222 Helena Alley', 'Dayton', 'Ohio', 45426),
(5266, 509895, 1083, 'Petrina Watts', '716-670-0909', 'pwattsw@gnu.org', '5348 Continental Court', 'Buffalo', 'New York', 14263),
(8773, 359353, 1069, 'Oates Clews', '323-706-6516', 'oclewsx@stumbleupon.com', '90 Eagan Drive', 'Los Angeles', 'California', 90094),
(1299, 838021, 1093, 'Juliette Ewers', '513-301-3035', 'jewersy@washingtonpost.com', '15 Melvin Street', 'Cincinnati', 'Ohio', 45228),
(8980, 745611, 1067, 'Norina Hylden', '757-408-2653', 'nhyldenz@multiply.com', '655 Cambridge Street', 'Portsmouth', 'Virginia', 23705),
(5659, 823402, 1094, 'Anetta McRannell', '916-675-0008', 'amcrannell10@google.ru', '901 Crownhardt Crossing', 'Sacramento', 'California', 94257),
(5373, 709173, 1061, 'Thadeus Sainer', '301-856-4065', 'tsainer11@alexa.com', '150 Reinke Cricle', 'Bethesda', 'Maryland', 20892),
(4234, 557992, 1029, 'Jorrie Hooban', '805-932-5168', 'jhooban12@sbwire.com', '2212 Dorton Point', 'Santa Barbara', 'California', 93150),
(9665, 851021, 1072, 'Lesli Allnutt', '269-366-1564', 'lallnutt13@unblog.fr', '9955 Pankratz Drive', 'Battle Creek', 'Michigan', 49018),
(2111, 881472, 1079, 'Asher Brideaux', '402-704-1903', 'abrideaux14@bloomberg.com', '288 East Street', 'Omaha', 'Nebraska', 68124),
(4589, 282131, 1079, 'Reiko Ludy', '614-268-9256', 'rludy15@sohu.com', 'Paget', '5441 Columbus Avenue', 'Ohio', 43210),
(3593, 471820, 1077, 'Chloette Crickmoor', '213-105-3579', 'ccrickmoor16@upenn.edu', '8711 Ludington Cricle', 'Los Angeles', 'California', 90087),
(6780, 148064, 1077, 'Melicent Derby', '609-861-0995', 'mderby17@exblog.jp', '1290 Ridge Oak Crossing', 'Trenton', 'New Jersey', 08650),
(6836, 450319, 1048, 'Lurlene Coston', '314-958-3507', 'lcoston18@dailymail.co.uk', '6676 Hauk Lane', 'Saint Louis', 'Missouri', 63104),
(4845, 801854, 1009, 'Shurlock Cogger', '310-136-5962', 'scogger19@weather.com', '5235 Rieder Alley', 'Torrance', 'California', 90505),
(6471, 839100, 1030, 'Vivia Samett', '202-429-5259', 'vsamett1a@sfgate.com', '9993 Rusk Avenue', 'Washington', 'District of Columbia', 20268),
(7907, 674933, 1060, 'Gayle Kynoch', '512-152-1560', 'gkynoch1b@bbc.co.uk', '23 Dahle Drive', 'Austin', 'Texas', 78764),
(7243, 543915, 1035, 'Carl Berwick', '240-971-1056', 'cberwick1c@patch.com', '706 Porter Street', 'agerstown', 'Maryland', 21747),
(4289, 295978, 1065, 'Hugh Haime', '908-341-6254', 'hhaime1d@networkadvertising.org', '809 Grayhawk Circle', 'Elizabeth', 'New Jersey', 07208);



-- ALTERATIONS SECTION


-- Adding another foreign key to the Rental_Record table for JOINs
ALTER TABLE Rental_Record
ADD CONSTRAINT FK_Customer_Vehicle FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);


-- Added new records with pickup_date to simulate current rentals that have yet to be returned.
INSERT INTO Rental_Record (rental_no, VIN, customer_id, pickup_date, start_mileage)
VALUES (801855, '1N4AA5AP7BC494598', 5266, '2021-11-30', 47449),
(450320, 'WAUDV94F87N564463', 4845, '2021-11-30', 15047),
(148065, 'WBAVB13546K196208', 6836, '2021-11-30', 47331),
(471821, 'JH4DC54836S778911', 6780, '2021-11-30', 19370),
(282132, '1FMCU0C78BK225616', 3593, '2021-11-30', 21591),
(881473, 'SCFFBCCDXBG910223', 4589, '2021-11-30', 36344),
(851022, '1G6DU6ED0B0040833', 2111, '2021-11-30', 43535),
(557993, 'WBA3K5C52EK537375', 9665, '2021-11-30', 40857),
(709174, '19XFB2F59EE058500', 4234, '2021-11-30', 24768),
(823403, '19XFB2F59EE058500', 5373, '2021-11-30', 34183),
(745612, '1N6AF0LX6FN568676', 5659, '2021-11-30', 44425),
(838022, '91FTEX1CM3BF34831', 8980, '2021-11-30', 34844),
(359354, 'WAUWGAFB7BN196073', 1299, '2021-11-30', 33947),
(509896, 'WAUGU54D71N576411', 8773, '2021-11-30', 8347);


-- Adding the column "status" to the vehicle table to show availability of specific cars.
-- These will take effect for any new rentals made after the ALTER.
ALTER TABLE Vehicle
ADD status CHAR(15) DEFAULT 'Available';

-- Using a CTE to update the Vehicle status to 'Unavailable' where there is no return date in the Rental_Record table.
WITH RentedOut AS
(
SELECT vin, return_date
FROM Rental_Record
WHERE return_date IS NOT NULL
)

UPDATE Vehicle 
SET status = 'Available'
FROM Vehicle 
JOIN RentedOut
ON Vehicle.vin = RentedOut.vin;

-- Using a CTE to update the vehicle status to 'Available' for records that were in system prior to creating the 'status' column.
-- These values need to be changed because the new DEFAULT statement did not effect them.
WITH RentReady AS
(
SELECT vin, return_date
FROM Rental_Record
WHERE return_date IS NULL
)

UPDATE Vehicle
SET status = 'Unavailable'
FROM Vehicle
JOIN RentReady
ON Vehicle.vin = RentReady.vin;

-- Some vehicles still have NULL values for 'status' which means that they have no rental_record history and have not been rented before.
-- This necessitates another manual update.
UPDATE Vehicle
SET status = 'Available'
WHERE status IS NULL;















