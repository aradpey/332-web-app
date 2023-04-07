drop database if exists restaurantDB;
create database restaurantDB;
use restaurantDB;

create table customerAccount(
    emailAddress varchar(100),
    firstName varchar(100),
    lastName varchar(100),
    cellNum char(10),
    streetAddress varchar(100),
    city varchar(100),
    pc char(6),
    creditAmt decimal(6, 2),
    primary key (emailAddress));

create table foodOrder(
	orderID integer,
	totalPrice decimal(6,2),
	tip decimal(6, 2),
	primary key (orderID));

create table food (
	name varchar(100),
	primary key (name));

create table restaurant(
	name varchar(100),
	streetAddress varchar(100),
	city varchar(100),
	pc char(6),
	url varchar(200),
	primary key (name));

create table employee(
	ID integer,
	firstName varchar(100),
	lastName varchar(100),
	emailAddress varchar(100),
	restaurantName varchar(100),
	primary key (ID),
	foreign key(restaurantName) references restaurant(name) on delete cascade);

create table manager(
	empid integer primary key,
	foreign key (empid) references employee(ID) on delete cascade);

create table serverStaff(
	empid integer primary key,
	foreign key (empid) references employee(ID) on delete cascade);

create table chef(
	empid integer primary key,
	foreign key (empid) references employee(ID) on delete cascade);

create table deliveryPerson(
	empid integer primary key,
	foreign key (empid) references employee(ID) on delete cascade);

create table payment(
	customerEmail varchar(100),
	date date not null,
	paymentAmount decimal(6,2) not null,
	primary key (customerEmail, date),
	foreign key (customerEmail) references customerAccount(emailAddress) on delete cascade);

create table shift(
	empID integer not null,
	day varchar(15) not null,
	startTime time not null,
	endTime time not null,
	primary key (empID, day),
	foreign key (empID) references employee(ID) on delete cascade);

create table chefCredentials (
	empID integer not null,
	cred varchar(30),
	primary key (empID, cred),
	foreign key (empID) references employee(ID) on delete cascade);

create table orderPlacement(
	customerEmail varchar(100) not null,
	orderID integer not null,
	restaurant varchar(100) not null,
	orderTime time,
    orderDate date,
	primary key (customerEmail, orderID, restaurant),
	foreign key (customerEmail) references customerAccount(emailAddress) on delete cascade,
	foreign key (orderID) references foodOrder(orderID) on delete cascade,
	foreign key (restaurant) references restaurant(name) on delete cascade);

create table relatedTo(
	customer varchar(100) not null,
	employee integer not null,
	relationship varchar(100),
	primary key (customer, employee),
	foreign key (customer) references customerAccount(emailAddress) on delete cascade,
	foreign key (employee) references employee(ID) on delete cascade);

create table menu(
	restaurant varchar(100) not null,
	food varchar(100) not null,
	price decimal(6, 2),
	primary key (restaurant, food),
	foreign key (restaurant) references restaurant(name) on delete cascade,
	foreign key (food) references food (name) on delete cascade);

create table foodItemsinOrder(
	orderID integer not null,
	food varchar(100) not null,
	primary key (orderID, food),
	foreign key (orderID) references foodOrder(orderID) on delete cascade,
	foreign key (food) references food(name) on delete cascade);

create table delivery(
	orderID integer not null,
	deliveryPerson integer not null,
	deliveryTime time,
    deliveryDate date,
	primary key (orderID, deliveryPerson),
	foreign key (orderID) references foodOrder(orderID) on delete cascade,
	foreign key (deliveryPerson) references employee(id) on delete cascade);

create table worksAt(
	employeeID integer not null,
	restaurant varchar(100) not null,
	primary key (employeeID, restaurant),
	foreign key (employeeID) references employee(ID) on delete cascade,
	foreign key (restaurant) references restaurant(name) on delete cascade);

-- ---------------------------------------------

INSERT INTO customerAccount VALUES
('john.doe@example.com', 'John', 'Doe', '1234567890', '123 Main St', 'New York', '10001', 120.50),
('jane.smith@example.com', 'Jane', 'Smith', '2345678901', '456 Second Ave', 'Los Angeles', '90001', 100.00),
('michael.brown@example.com', 'Michael', 'Brown', '3456789012', '789 Third St', 'Chicago', '60601', 150.75),
('emily.wilson@example.com', 'Emily', 'Wilson', '4567890123', '1012 Fourth Ave', 'Houston', '77001', 200.00),
('william.jones@example.com', 'William', 'Jones', '5678901234', '1235 Fifth St', 'Philadelphia', '19019', 80.00),
('olivia.garcia@example.com', 'Olivia', 'Garcia', '6789012345', '678 Sixth Ave', 'Phoenix', '85001', 175.00),
('james.rodriguez@example.com', 'James', 'Rodriguez', '7890123456', '901 Seventh St', 'San Antonio', '78201', 140.00),
('isabella.martinez@example.com', 'Isabella', 'Martinez', '8901234567', '2348 Eighth Ave', 'San Diego', '92101', 95.00),
('benjamin.johnson@example.com', 'Benjamin', 'Johnson', '9012345678', '5679 Ninth St', 'Dallas', '75201', 110.00),
('charlotte.jackson@example.com', 'Charlotte', 'Jackson', '0123456789', '8910 Tenth Ave', 'San Jose', '95101', 130.00);

INSERT INTO foodOrder VALUES
(1, 25.00, 5.00),
(2, 30.00, 6.00),
(3, 15.00, 3.00),
(4, 20.00, 4.00),
(5, 35.00, 7.00),
(6, 40.00, 8.00),
(7, 45.00, 9.00),
(8, 50.00, 10.00),
(9, 55.00, 11.00),
(10, 60.00, 12.00);

INSERT INTO food VALUES
('Pepperoni Pizza'),
('Margherita Pizza'),
('Caesar Salad'),
('Classic Burger'),
('Cheeseburger'),
('Veggie Burger'),
('Spaghetti Bolognese'),
('Fettuccine Alfredo'),
('Pesto Pasta'),
('Greek Salad'),
('Cobb Salad'),
('Nicoise Salad');

INSERT INTO restaurant VALUES
('Pizza Palace', '123 Main St', 'New York', '10001', 'https://pizzapalace.example.com'),
('Burger Kingdom', '456 Second Ave', 'Los Angeles', '90001', 'https://burgerkingdom.example.com'),
('Pasta Paradise', '789 Third St', 'Chicago', '60601', 'https://pastaparadise.example.com'),
('Salad Sanctuary', '1012 Fourth Ave', 'Houston', '77001', 'https://saladsanctuary.example.com');

INSERT INTO employee VALUES
(1, 'Michael', 'Scott', 'michael.scott@example.com', 'Pizza Palace'),
(2, 'Dwight', 'Schrute', 'dwight.schrute@example.com', 'Pizza Palace'),
(3, 'Jim', 'Halpert', 'jim.halpert@example.com', 'Burger Kingdom'),
(4, 'Pam', 'Beesly', 'pam.beesly@example.com', 'Burger Kingdom'),
(5, 'Stanley', 'Hudson', 'stanley.hudson@example.com', 'Pasta Paradise'),
(6, 'Angela', 'Martin', 'angela.martin@example.com', 'Pasta Paradise'),
(7, 'Kevin', 'Malone', 'kevin.malone@example.com', 'Salad Sanctuary'),
(8, 'Meredith', 'Palmer', 'meredith.palmer@example.com', 'Salad Sanctuary'),
(9, 'Oscar', 'Martinez', 'oscar.martinez@example.com', 'Pizza Palace'),
(10, 'Ryan', 'Howard', 'ryan.howard@example.com', 'Burger Kingdom'),
(11, 'Eva', 'Fisher', 'eva.fisher@email.com', 'Pasta Paradise'),
(12, 'Martin', 'Johnson', 'martin.johnson@email.com', 'Salad Sanctuary');


INSERT INTO manager VALUES
(1),
(3),
(5),
(7);

INSERT INTO serverStaff VALUES
(2),
(4),
(6),
(8);

INSERT INTO chef VALUES
(9),
(10);

INSERT INTO deliveryPerson VALUES
(11),
(12);

INSERT INTO payment VALUES
('john.doe@example.com', '2023-04-02', 25.00),
('jane.smith@example.com', '2023-04-02', 30.00),
('michael.brown@example.com', '2023-04-03', 15.00),
('emily.wilson@example.com', '2023-04-10', 20.00),
('william.jones@example.com', '2023-04-10', 35.00),
('olivia.garcia@example.com', '2023-04-10', 40.00),
('james.rodriguez@example.com', '2023-04-10', 45.00),
('isabella.martinez@example.com', '2023-04-10', 50.00),
('benjamin.johnson@example.com', '2023-04-10', 55.00),
('charlotte.jackson@example.com', '2023-04-10', 60.00);

INSERT INTO shift VALUES
(1, 'Monday', '09:00:00', '17:00:00'),
(1, 'Tuesday', '09:00:00', '17:00:00'),
(2, 'Tuesday', '09:00:00', '17:00:00'),
(3, 'Wednesday', '09:00:00', '17:00:00'),
(4, 'Thursday', '09:00:00', '17:00:00'),
(5, 'Friday', '09:00:00', '17:00:00'),
(6, 'Saturday', '09:00:00', '17:00:00'),
(7, 'Sunday', '09:00:00', '17:00:00'),
(8, 'Monday', '09:00:00', '17:00:00'),
(9, 'Tuesday', '09:00:00', '17:00:00'),
(10, 'Wednesday', '09:00:00', '17:00:00');

INSERT INTO chefCredentials VALUES
(9, 'Italian Cuisine'),
(9, 'Pizza Expert'),
(10, 'Burger Specialist'),
(10, 'Grilling Techniques');

INSERT INTO orderPlacement VALUES
('john.doe@example.com', 1, 'Pizza Palace', '12:00:00', '2023-04-02'),
('jane.smith@example.com', 2, 'Burger Kingdom', '12:30:00', '2023-04-02'),
('michael.brown@example.com', 3, 'Pasta Paradise', '13:00:00', '2023-04-03'),
('emily.wilson@example.com', 4, 'Salad Sanctuary', '13:30:00', '2023-04-10'),
('william.jones@example.com', 5, 'Pizza Palace', '14:00:00', '2023-04-10'),
('olivia.garcia@example.com', 6, 'Burger Kingdom', '14:30:00', '2023-04-10'),
('james.rodriguez@example.com', 7, 'Pasta Paradise', '15:00:00', '2023-04-10'),
('isabella.martinez@example.com', 8, 'Salad Sanctuary', '15:30:00', '2023-04-10'),
('benjamin.johnson@example.com', 9, 'Pizza Palace', '16:00:00', '2023-04-10'),
('charlotte.jackson@example.com', 10, 'Burger Kingdom', '16:30:00', '2023-04-10');

INSERT INTO relatedTo VALUES
('john.doe@example.com', 1, 'Friend'),
('jane.smith@example.com', 3, 'Cousin'),
('michael.brown@example.com', 5, 'Brother'),
('emily.wilson@example.com', 7, 'Sister'),
('william.jones@example.com', 9, 'Uncle');

INSERT INTO menu VALUES
('Pizza Palace', 'Pepperoni Pizza', 10.00),
('Pizza Palace', 'Margherita Pizza', 12.00),
('Pizza Palace', 'Caesar Salad', 8.00),
('Burger Kingdom', 'Classic Burger', 10.00),
('Burger Kingdom', 'Cheeseburger', 11.00),
('Burger Kingdom', 'Veggie Burger', 9.00),
('Pasta Paradise', 'Spaghetti Bolognese', 12.00),
('Pasta Paradise', 'Fettuccine Alfredo', 11.00),
('Pasta Paradise', 'Pesto Pasta', 10.00),
('Salad Sanctuary', 'Greek Salad', 9.00),
('Salad Sanctuary', 'Cobb Salad', 10.00),
('Salad Sanctuary', 'Nicoise Salad', 11.00);

INSERT INTO foodItemsinOrder VALUES
(1, 'Pepperoni Pizza'),
(2, 'Classic Burger'),
(3, 'Spaghetti Bolognese'),
(4, 'Greek Salad'),
(5, 'Margherita Pizza'),
(6, 'Cheeseburger'),
(7, 'Fettuccine Alfredo'),
(8, 'Cobb Salad'),
(9, 'Caesar Salad'),
(10, 'Veggie Burger');

INSERT INTO delivery VALUES
(1, 9, '12:30:00', '2023-04-02'),
(2, 10, '13:00:00', '2023-04-02'),
(3, 9, '13:30:00', '2023-04-03'),
(4, 10, '14:00:00', '2023-04-03'),
(5, 9, '14:30:00', '2023-04-05'),
(6, 10, '15:00:00', '2023-04-05'),
(7, 9, '15:30:00', '2023-04-10'),
(8, 10, '16:00:00', '2023-04-10'),
(9, 9, '16:30:00', '2023-04-10'),
(10, 10, '17:00:00', '2023-04-10');

INSERT INTO worksAt VALUES
(1, 'Pizza Palace'),
(2, 'Pizza Palace'),
(3, 'Burger Kingdom'),
(4, 'Burger Kingdom'),
(5, 'Pasta Paradise'),
(6, 'Pasta Paradise'),
(7, 'Salad Sanctuary'),
(8, 'Salad Sanctuary'),
(9, 'Pizza Palace'),
(10, 'Burger Kingdom');