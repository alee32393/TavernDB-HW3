USE ALee_2019

GO
/*drop tables*/
DROP TABLE IF EXISTS RoomStay;
DROP TABLE IF EXISTS Room;
DROP TABLE IF EXISTS GuestLevel;
DROP TABLE IF EXISTS GuestClass;
DROP TABLE IF EXISTS Counts;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Guest;
DROP TABLE IF EXISTS GuestStatus;
DROP TABLE IF EXISTS Service;
DROP TABLE IF EXISTS ServiceStatus;
DROP TABLE IF EXISTS SuppliesReceived;
DROP TABLE IF EXISTS Supplies;
DROP TABLE IF EXISTS Tavern;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS Roles;


CREATE TABLE Roles(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Description VARCHAR(MAX)

);
CREATE TABLE Location(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);
CREATE TABLE Users(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	RoleID INT FOREIGN KEY REFERENCES Roles(ID)
);

/* Created tables */
CREATE TABLE Tavern(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	LocationID INT FOREIGN KEY REFERENCES Location(ID),
	OwnerID INT FOREIGN KEY REFERENCES Users(ID)
);

CREATE TABLE Supplies(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Unit VARCHAR(50),
);
CREATE TABLE SuppliesReceived(
	ID INT identity Primary Key,
	Date DATETIME,
	QTY DECIMAL,
	COST DECIMAL,
	SupplyID INT,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE ServiceStatus(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);

CREATE TABLE Service(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	StatusID INT FOREIGN KEY REFERENCES ServiceStatus(ID),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

CREATE TABLE GuestStatus(
	ID INT identity Primary Key,
	Name VARCHAR(100)
);

CREATE TABLE Guest(
	ID INT identity Primary Key,
	Name VARCHAR(250),
	Notes VARCHAR(250),
	Birthdate Date,
	CakeDays date,
	GuestStatusID INT FOREIGN KEY REFERENCES GuestStatus(ID)
);
CREATE TABLE Sales(
	ID INT identity Primary Key,
	ServiceID INT FOREIGN KEY REFERENCES Service(ID),
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	Price DECIMAL,
	PurchaseDate DATE,
	Amount DECIMAL,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);
CREATE TABLE Counts(
	SupplyID INT identity Primary Key,
	Date Date,
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID),
	Count DECIMAL
);
CREATE TABLE GuestClass(
	ID INT identity Primary Key,
	Name VARCHAR(250)
);


CREATE TABLE GuestLevel(
	ID INT identity Primary Key,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	ClassID INT FOREIGN KEY REFERENCES GuestClass(ID),
	Date date
);

/* creates rooms*/
CREATE TABLE Rooms(
	ID INT IDENTITY Primary Key,
	Status VARCHAR(250),
	TavernID INT FOREIGN KEY REFERENCES Tavern(ID)
);

/*Creates rooms stayed in */
CREATE TABLE RoomStay(
	ID INT IDENTITY Primary Key,
	SaleID INT,
	GuestID INT FOREIGN KEY REFERENCES Guest(ID),
	RoomID INT FOREIGN KEY REFERENCES Rooms(ID),
	Date Date,
	Rate DECIMAL
);

/*
/*Adds a primary key to table user*/
ALTER TABLE Users ADD PRIMARY KEY ID;

/*Adds to the supplies table a foreign key that references another table */
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (TavernID) References Tavern(TavernID);
ALTER TABLE SuppliesReceived ADD FOREIGN KEY (SupplyID) References Supplies(SupplyID);

/*Alter a table in some way by dropping the TestDrop text field in SuppliesReceived*/
ALTER TABLE SuppliesReceived DROP COLUMN EmployeeReceiverName;
*/

/* adding data to the tavern */



INSERT INTO Roles
VALUES
('Manager', 'manages the place'),
('greeter', 'greets guest'),
('maid',' cleans the joint'),
('cook', 'cooks food'),
('idiot', 'let people make fun of him');
/*adding data to location*/
INSERT INTO Location
VALUES
('Philly'),
('Springfield'),
('Mt Laurel'),
('Chester'),
('Not Philly
');
/* adding data to the user */

INSERT INTO Users
VALUES
('Joanna', '1'),
('Peter', '2'),
('Steven','3'),
('Rob', '4'),
('Carrie', '5');
INSERT INTO Tavern 
VALUES
('Howl By the Moon','1', '1'),
('Moes Tavern', '2', '2'),
('Miller Ale House', '3','3'),
('Maggies Pub', '4','4'),
('Xfinity', '5','5');

/* adding data to the supplies */
INSERT INTO Supplies
VALUES
('Miller Lite','ounces'),
('Toilet Paper','roll'),
('Mugs','pounds'),
('Water','gallons'),
('Apple Cider Vinegar','jugs');

/* adding data to the supplies being received */

INSERT INTO SuppliesReceived
VALUES
(01/01/2011, 100, 1000,1,2),
(02/02/2012, 50, 500,5,3),
(03/03/2013, 99, 12,2,5),
(04/04/2014, 23, 3,3,2),
(05/05/2015, 4, 66,1,3);

/* adding data to the statuses of the service */
INSERT INTO ServiceStatus
VALUE
('Active'),
('Inactive'),
('Out of Stock'),
('Discontinued');

/* adding data to the services */
INSERT INTO Service
VALUES
('Room Service' , 1,5),
('Chiropractor' , 2,4),
('Television' , 1,3),
('Grub Hub' , 2,2),
('Room Service' , 1,2);

INSERT INTO GuestStatus
VALUE
('Sick'),
('0HP'),
('Alive'),
('Hungry'),
('Excited');

INSERT INTO Guest
VALUES
('Eric','manager',2/12/2012,5/23/1990,2),
('Bruce','CEO',3/31/1990,5/23/2011,3),
('Clark','reporter',5/30/2012,3/03/1930,1),
('Barry','scientist',1/11/2011,2/26/2000,5),
('Dianna','amazon',12/12/2012,10/2010,2);

/* adding data to the sales */

INSERT INTO Sales
VALUE
(3,3,199.99,01/12/2020,199.99,4),
(2,2,67.45,12/11/2000,199.99,5),
(3,5,150.00,05/11/1999,150.0,1),
(5,2,1099.00,01/12/2020,35.0,2),
(1,1,245.02,01/12/2020,245.02,3);


INSERT INTO Counts
VALUE
('3',11/11/2011,5,10.1),
('2',12/12/2012,5,10.1),
('4',03/23/1993,5,10.1),
('1',04/05/1996,5,10.1),
('3',08/14/2019,5,10.1);


INSERT INTO GuestClass
VALUE
('Warrior'),
('Mge'),
('Archer'),
('Thief'),
('Pirate');

INSERT INTO Rooms
VALUES
('Vacant',1),
('Occupied',2),
('Out of Order', 3),
('No longer avaiable',4),
('redesigning',5);

INSERT INTO RoomStay
VALUES
(1,4,5,'03/10/2019',10.00),
(2,1,5,'12/10/2012',1.00),
(3,3,5,'08/10/2015',23.50),
(4,2,5,'04/10/2017',154.00),
(5,2,5,'01/10/2020',999.00);

--2. Write a query that returns guests with a birthday before 2000. 
SELECT Birthdate FROM Guest WHERE
Birthdate < '2000-01-01';

--3. Write a query to return rooms that cost more than 100 gold a night
SELECT Rate FROM RoomStay WHERE Rate >100;

--4. Write a query that returns UNIQUE guest names.
SELECT DISTINCT Name FROM Guest;

--5. Write a query that returns all guests ordered by name (ascending) Use ASC or DESC after your ORDER BY [col]
SELECT Name FROM Guest ORDER BY Name ASC;

--6. Write a query that returns the top 10 highest price sales
SELECT TOP 10 *  FROM Sales ORDER BY Price DESC; 

--7. Write a query to return all Lookup Table Names - this is, not the names of the tables 
--but the Names of things like Status/Role/Class,etc. (w/ Union)
SELECT Name FROM Roles
UNION
SELECT Name FROM Location
UNION
SELECT Name FROM Users
UNION
SELECT Name FROM Supplies
UNION
SELECT Name FROM ServiceStatus
UNION
SELECT Name FROM Service
UNION
SELECT Name FROM GuestStatus
UNION
SELECT Name FROM Guest
UNION
SELECT Name FROM GuestClass;

--8. Write a query that returns Guest Classes with Levels and Generate a new column 
--with a label for their level grouping (lvl 1-10, 10-20, etc)

SELECT CONCAT('Guest Class:', GuestID, 'Guest Level:',ClassID) FROM GuestLevel WHERE ClassID BETWEEN 1 AND 10 ORDER BY ClassID ASC;

SELECT CONCAT('Guest Class:', GuestID, 'Guest Level:',ClassID) FROM GuestLevel WHERE ClassID BETWEEN 11 AND 20 ORDER BY ClassID ASC;

--9. Write a series of INSERT commands that will insert the statuses of one table into another of your choosing 
--using SELECT statements (See our lab in class - The INSERT commands should be generated). 
--It’s ok if the data doesn’t match or make sense! :) 
--Remember, INSERT Commands look like: INSERT INTO Table1 (column1, column2) VALUES (column1, column2)

--I know this is wrong, it can generate the insert into taverns the name of columns and the data type, not really sure where to go now...
SELECT CONCAT('INSERT INTO ',TABLE_NAME,' ' , 'VALUES', ' (') as queryPiece 
FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Taverns'
UNION
SELECT CONCAT(cols.COLUMN_NAME, ' ' ,cols.DATA_TYPE) as queryPiece FROM INFORMATION_SCHEMA.COLUMNS as cols WHERE TABLE_NAME = 'GuestStatus'
UNION
SELECT CONCAT(')','}');