IF 
(SELECT COUNT(name) FROM sys.databases WHERE sys.databases .name = 'RailWay') < 1

CREATE DATABASE RailWay
ON
(
	NAME = 'RailWay',
	FILENAME = 'D:\12\RailWay',
	SIZE = 10MB,
	MAXSIZE =100MB,
	FILEGROWTH =5MB
)
LOG ON
(
	NAME = 'RailWayLog',
	FILENAME = 'D:\12\RailWayLog',
	SIZE = 5MB,
	MAXSIZE = 25MB,
	FILEGROWTH =5MB
)
ELSE
PRINT 'Already exists';
