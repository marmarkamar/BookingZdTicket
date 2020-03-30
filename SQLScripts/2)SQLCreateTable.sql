
use RailWay

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Privilege') < 1

CREATE TABLE Privilege
(
	ID INT IDENTITY (1,1),
	
	Name VARCHAR (60) NOT NULL,
	Coefficent DECIMAL (6,3) NOT NULL,
	
	PRIMARY KEY (ID) 
);
ELSE
PRINT 'Privilege Already exists';


IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Person') < 1
CREATE TABLE Person
(
	ID INT IDENTITY (1,1),
	
	Surname VARCHAR (60) NOT NULL,
	Name VARCHAR (60)NOT NULL,
	PrivilegeID INT NOT NULL FOREIGN KEY REFERENCES Privilege(ID),
	Telefon VARCHAR (15),
	MailAddres VARCHAR (60)
	
	PRIMARY KEY (ID) 
);
ELSE
PRINT 'Person Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='SeatType') < 1
CREATE TABLE SeatType
(
	ID INT IDENTITY (1,1),
	
	Type VARCHAR (20) NOT NULL,
	
	PRIMARY KEY (ID)
);
ELSE
PRINT 'SeatType Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='CarType') < 1
CREATE TABLE CarType
(
	ID INT IDENTITY (1,1),
	
	TYPE VARCHAR (20) NOT NULL,
	NumberSeat INT,
	Coefficent DECIMAL (6,3) NOT NULL,
	
	PRIMARY KEY (ID)
);
ELSE
PRINT 'CarType Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='TrainType') < 1

CREATE TABLE TrainType
(
	ID INT IDENTITY (1,1),
	
	Type VARCHAR (20) NOT NULL,
			
	PRIMARY KEY (ID)
);
ELSE
PRINT 'TrainType Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Train') < 1
CREATE TABLE Train
(
	ID INT IDENTITY (1,1),
	
	TrainType INT NOT NULL FOREIGN KEY REFERENCES TrainType(ID),
	
	PRIMARY KEY (ID)
);
ELSE
PRINT 'Train Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Car') < 1
CREATE TABLE Car
(
	ID INT IDENTITY (1,1),
	
	Type INT NOT NULL FOREIGN KEY REFERENCES CarType(ID),
	TrainID INT NOT NULL FOREIGN KEY REFERENCES Train(ID),
	NumbeR INT NOT NULL

	PRIMARY KEY (ID)
);
ELSE
PRINT 'Car Already exists';

	IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Seat') < 1
CREATE TABLE Seat
(
	ID INT IDENTITY (1,1),
	
	Number INT NOT NULL,
	Type INT NOT NULL FOREIGN KEY REFERENCES SeatType(ID),
	CarID INT NOT NULL FOREIGN KEY REFERENCES Car(ID),
	
	PRIMARY KEY (ID)
);
ELSE
PRINT 'Seat Already exists';
ALTER TABLE Seat
ADD CHECK (Number>=1);

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Station') < 1
CREATE TABLE Station
(
	ID INT IDENTITY (1,1) ,
	
	Name VARCHAR (50) NOT NULL ,

	PRIMARY KEY (ID)
);
ELSE
PRINT 'Station Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Route') < 1
CREATE TABLE Route
(
	ID INT NOT NULL,

	Name VARCHAR (50) NOT NULL ,

	PRIMARY KEY (ID)
);
ELSE
PRINT 'Route Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='StationRoute') < 1
CREATE TABLE StationRoute
(
	ID INT IDENTITY (1,1) ,
	
	RouteID INT NOT NULL FOREIGN KEY REFERENCES Route(ID),
	StationID INT NOT NULL FOREIGN KEY REFERENCES Station(ID),
	
	TimeArrival TIME NOT NULL, 
	TimeDeparture TIME NOT NULL,

	Distance decimal (6,3) NOT NULL,

	PRIMARY KEY (ID)
);
ELSE
PRINT 'StationRoute Already exists';



IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='CoefficentRoute') < 1
CREATE TABLE CoefficentRoute
(
	ID INT IDENTITY (1,1),
	
	RouteID INT NOT NULL FOREIGN KEY REFERENCES Route(ID),
	Coefficent DECIMAL (6,3) NOT NULL,

	PRIMARY KEY (ID)
);
ELSE
PRINT 'CoefficentRoute Already exists';

IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='RouteTrain') < 1
CREATE TABLE RouteTrain
(
	ID INT IDENTITY (1,1),
	
	TrainID INT  NOT NULL FOREIGN KEY REFERENCES Train (ID),
	RouteID INT NOT NULL FOREIGN KEY REFERENCES Route (ID),
	
	PRIMARY KEY (ID)
);
ELSE
PRINT 'RouteTrain Already exists';


IF 
(SELECT COUNT(name) FROM sys.objects WHERE type in ('U') AND name ='Ticket') < 1
CREATE TABLE Ticket
(
	ID INT IDENTITY (1,1),

	PersonID INT NOT NULL FOREIGN KEY REFERENCES Person(ID),   
	StationFrom INT,
	StationTo INT NOT NULL,
	RouteTrainID INT NOT NULL FOREIGN KEY REFERENCES RouteTrain(ID),
	CarID INT NOT NULL FOREIGN KEY REFERENCES Car(ID),	
	SeatID INT NOT NULL FOREIGN KEY REFERENCES Seat(ID), 
	Date DATETIME NOT NULL,
	Price DECIMAL (8,3) NOT NULL,
	TimeArrive	time,
	TimeDepart	time

	PRIMARY KEY (ID)
);
ELSE
PRINT 'Ticket Already exists';

