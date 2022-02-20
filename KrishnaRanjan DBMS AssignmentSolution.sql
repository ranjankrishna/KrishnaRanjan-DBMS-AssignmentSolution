use TravelOnTheGo;
drop table passenger;

-- 1) You are required to create two tables PASSENGER and PRICE with the following attributes and properties

create table if not exists passenger (
    Passenger_id int NOT NULL AUTO_INCREMENT,
    Passenger_name varchar(50), 
    Category varchar(20), 
    Gender varchar(5), 
    Boarding_City varchar(50),
    Destination_City varchar(50),
    Distance int,
    Bus_Type varchar(20) NOT NULL,
    PRIMARY KEY(`Passenger_id` )
);

 create table if not exists price ( 
    price_id BIGINT NOT NULL AUTO_INCREMENT,
    Bus_Type varchar(20) NOT NULL,
    Distance int NOT NULL, 
    Price int,
    PRIMARY KEY(`price_id`,`Bus_Type`));
    
    
-- 2) Insert the following data in the tables    
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Udit", "Non-AC", "M", "Trivandrum", "panaji", 1000, "Sleeper");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Hemant", "Non-AC", "M", "panaji", "Mumbai", 700, "Sleeper");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting");
insert into `passenger`(Passenger_name, Category,Gender, Boarding_City, Destination_City, Distance, Bus_Type) values( "Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting");


insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 350, 770);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 500, 1100);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 600, 1320);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 700, 1540);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 1000, 2200);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 1200, 2640);
insert into `price`(Bus_Type, Distance, Price) values("Sleeper", 1500, 2700);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 500, 620);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 600, 744);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 700, 868);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 1000, 1240);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 1200, 1488);
insert into `price`(Bus_Type, Distance, Price) values("Sitting", 1500, 1860);

-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?
select gender, count(Gender) from passenger where Distance >=600 group by Gender;

-- 4) Find the minimum ticket price for Sleeper Bus. 
select min(Price) as Minimum_Sleeper_Fare from Price where bus_type = "Sleeper" ;

-- 5) Select passenger names whose names start with character 'S'
SELECT passenger_name from passenger where Passenger_name LIKE 's%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,Destination City, Bus_Type, Price in the output
select pass.Passenger_name, pass.Boarding_City, pass.Destination_City, pass.Bus_Type, Price from 
passenger as pass inner join Price as pri on pass.Bus_Type = pri.Bus_type and 
pass.Distance = pri.Distance;

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KMs
-- Assuming that Distance = 1000 Km
select distinct Passenger_name, Price from 
passenger as pass inner join Price as pri on pass.Bus_Type = pri.Bus_type and 
pass.Distance = pri.Distance
where pass.Bus_Type = "Sitting" and pass.Distance = 1000 order by Passenger_name;

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
-- Assuming Bangalore = Bengaluru
select distinct price from price where Distance = ( select Distance from passenger where passenger_name = 'Pallavi' and Boarding_City = 'Panaji' and Destination_City = 'Bengaluru' )
                        and ( Bus_Type = 'Sleeper' or Bus_Type = 'Sitting' ) ;
       
-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. 
select distinct Distance as Distinct_Distance from passenger order by Distance desc;  

-- 10) Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by all passengers without using user variables

select passenger_name,  Distance, Distance * 100 / total.dist as 'Percent of Distance' from passenger
cross join( select sum(Distance) as dist from passenger ) as total;   
    
-- 11)  Display the distance, price in three categories in table Price
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500    
-- c) Cheap otherwise

select distinct Distance, Price, 
 CASE
    WHEN Price > 1000 THEN "Expensive"
    WHEN Price > 500 and Price < 1000 THEN "Average Cost"
   ELSE "Cheap"
 END as Price_Analysis from  price;

