use RailWay
go

CREATE PROC FindPlaceProc(
		@StationFrom VARCHAR(40), 
		@StationTo VARCHAR(40),
		@Date DATE,
		@Time TIME
	)
	AS
	BEGIN
		DECLARE @CheckDate date;
		DECLARE @idFrom int ,@idTo int;	
		set @CheckDate = CONVERT (date, SYSDATETIME())  
		SET @idFrom = (select id from Station where [Name] = @StationFrom);
		SET @idTo = (select id from Station where [Name] = @StationTo);		
		
		if (@Date >= @CheckDate AND (DATEADD (DAY,30,@CheckDate)) >= @Date)	--	
			BEGIN
				
				SELECT 
					S1.RouteTrainID AS TrainNumber,
					S1.RouteName,
					COUNT(NumberSeat) as NumberSeat,
					S1.TimeArrival1 AS TimeArrival,
					S1.TimeArrival2 AS TimeDeparture
				FROM 
					(SELECT *FROM GetRouteTrain(@StationFrom,@StationTo)) AS S1
				JOIN 
					(SELECT *FROM GetFreeSeatNumberColab(@idFrom,@idTo,@Date)) AS S2
				ON S1.TrainID = S2.TrainID
				WHERE S1.TimeArrival1 >= @Time And @Date != @CheckDate OR S1.TimeArrival1 > CONVERT (time, SYSDATETIME()) 
				GROUP BY S1.RouteTrainID, S1.RouteName,S1.TimeArrival1,S1.TimeArrival2;

					SELECT 
					S1.RouteTrainID AS TrainNumber,
					S2.CarType,
					COUNT(S2.NumberSeat) as NumberSeat
				FROM 
					(SELECT *FROM GetRouteTrain(@StationFrom,@StationTo)) AS S1
				JOIN 
					(SELECT *FROM GetFreeSeatNumberColab(@idFrom,@idTo,@Date)) AS S2
				ON S1.TrainID = S2.TrainID
				WHERE (S1.TimeArrival1 >= @Time And @Date != @CheckDate OR S1.TimeArrival1 > CONVERT (time, SYSDATETIME())) 
				GROUP BY S1.RouteTrainID,S2.CarType--!!!!!!!!!!!!!!!!!!
				ORDER BY S1.RouteTrainID;

				END
		ELSE  
			--PRINT 'Incorrect Date';
			RAISERROR ('Incorrect Date',16, 1 ); 
	END
	go
	

CREATE PROC FindAllPlaceProc(
		@TrainRouteId int,
		@StationFrom VARCHAR(40), 
		@StationTo VARCHAR(40),
		@CarType VARCHAR(40),
		@Date DATE,
		@Time TIME
	)
	AS
	BEGIN
		DECLARE @CheckDate date;
		DECLARE @idFrom int ,@idTo int;	
		set @CheckDate = CONVERT (date, SYSDATETIME())  
		SET @idFrom = (select id from Station where [Name] = @StationFrom);
		SET @idTo = (select id from Station where [Name] = @StationTo);		
		
		if (@Date >= @CheckDate AND (DATEADD (DAY,30,@CheckDate)) >= @Date)	--	
			BEGIN
				
				SELECT 
					S1.RouteTrainID AS TrainNumber,
					S1.RouteName,
					S1.TimeArrival1 AS TimeArrival,
					S1.TimeArrival2 AS TimeDeparture
				FROM 
					(SELECT *FROM GetRouteTrain(@StationFrom,@StationTo)) AS S1
				JOIN 
					(SELECT *FROM GetFreeSeatNumberColab(@idFrom,@idTo,@Date)) AS S2
				ON S1.TrainID = S2.TrainID
				WHERE S1.RouteTrainID=@TrainRouteId AND S1.TimeArrival1 >= @Time And @Date != @CheckDate OR S1.TimeArrival1 > CONVERT (time, SYSDATETIME()) 
				GROUP BY S1.RouteTrainID, S1.RouteName,S1.TimeArrival1,S1.TimeArrival2;

					SELECT 
					S1.RouteTrainID AS TrainNumber,
					S2.CarType,
					COUNT(S2.NumberSeat) as NumberSeat
				FROM 
					(SELECT *FROM GetRouteTrain(@StationFrom,@StationTo)) AS S1
				JOIN 
					(SELECT *FROM GetFreeSeatNumberColab(@idFrom,@idTo,@Date)) AS S2
				ON S1.TrainID = S2.TrainID
				WHERE S1.RouteTrainID=@TrainRouteId AND (S1.TimeArrival1 >= @Time And @Date != @CheckDate OR S1.TimeArrival1 > CONVERT (time, SYSDATETIME())) 
				GROUP BY S1.RouteTrainID,S2.CarType
				ORDER BY S1.RouteTrainID;

				SELECT 
					S1.RouteTrainID AS TrainNumber,
					S2.seatID,
					S2.CarType,
					S2.NumberCar,
					S2.NumberSeat as NumberSeat
				FROM 
					(SELECT *FROM GetRouteTrain(@StationFrom,@StationTo)) AS S1
				JOIN 
					(SELECT *FROM GetFreeSeatNumberColab(@idFrom,@idTo,@Date)) AS S2
				ON S1.TrainID = S2.TrainID
				WHERE S2.CarType = @CarType AND S1.RouteTrainID = @TrainRouteId AND (S1.TimeArrival1 >= @Time And @Date != @CheckDate OR S1.TimeArrival1 > CONVERT (time, SYSDATETIME()))  
				ORDER BY S2.NumberCar;

				END
		ELSE  
			--PRINT 'Incorrect Date';
			RAISERROR ('Incorrect Date',16, 1 ); 
	END
	go


CREATE PROC GetSomeSeatInfo(
@SeatID INT
	)
	AS
	BEGIN
		Select 
		S.ID as SeatID,
		S.Number as SeatNumber,
		C.NumbeR as CarNumber
		from 
			Seat as S
		join
			Car as C 
		On S.CarID = C.ID 
		WHERE S.ID = @SeatID				
	END
	go


	CREATE FUNCTION GetPriseForTicket(
	@SeatID int,
	@RouteTrainID int,
	@PersonID int,
	@idFrom int,
	@idTo int
	)   
    RETURNS decimal (6,3)
	AS
	BEGIN

	 declare @CarCoeff decimal (6,3),@PrivilegCoeff decimal(6,3), @CoeffRoute decimal(6,3),@distans decimal(6,3);
	 declare @resultPrise  decimal(6,3);
	 set @CarCoeff = (select top 1 ct.Coefficent as CarCoeff 
	 from Seat as s
	join 
	[dbo].[Car] as c
	on s.CarID = c.ID
	join
	[dbo].[CarType] as ct
	on c.[Type] = ct.ID
	where s.ID = @SeatID);

	set @PrivilegCoeff =(select top 1 pr.Coefficent as PrivilegCoeff
	 from [dbo].[Person] as p
	join 
		[dbo].[Privilege] as pr
	on p.PrivilegeID = pr.ID
	where p.ID = @PersonID);

	set @CoeffRoute =(select top 1 cr.Coefficent as CoeffRoute
	 from [dbo].[CoefficentRoute] as Cr
	where cr.RouteID = @RouteTrainID);

	set @distans =	(select top 1
		SF.Distance
	from [dbo].[StationRoute] as SF
	where sf.StationID =@idTo)	-
	(select top 1 
		SF.Distance
	from [dbo].[StationRoute] as SF
	where sf.StationID =@idFrom)

	set @resultPrise = @distans * @CoeffRoute * @PrivilegCoeff * @CarCoeff;

	return (@resultPrise)
END;
go

	CREATE PROC GetBuingValueForTicket(
	@StationFrom VARCHAR(40), 
	@StationTo VARCHAR(40),
	@Surname VARCHAR (60),	
	@Name VARCHAR (60),
	@Privilege VARCHAR (60),
	@SeatID INT,
	@Mail VARCHAR (60)
	)
	AS
	BEGIN
		DECLARE @PrivilegeID int;
		DecLare @Price Decimal (8,2);
		DECLARE @PersonID int, @idFrom int ,@idTo int,@RouteID int;
		set @PrivilegeID = (select ID from  Privilege where [Name] = @Privilege)
		
		if(select count(ID) from Person where [Name] = @Name AND Surname = @Surname)<=0
		BEGIN
		INSERT INTO Person(Surname,[Name],PrivilegeID,MailAddres)
		VALUES (@Surname,@Name,@PrivilegeID,@Mail);
		END
		ELSE IF (select count(ID) from Person where [Name] = @Name AND Surname = @Surname AND PrivilegeID = @PrivilegeID)<=0
		BEGIN
			UPDATE Person SET PrivilegeID = @PrivilegeID WHERE Surname = @Surname and [Name] = @Name ;
		END

		set @PersonID = (select top 1 ID from  Person where [Name] = @Name  AND Surname = @Surname);
		SET @idFrom = (select top 1 id from Station where [Name] = @StationFrom);
		SET @idTo = (select top 1 id from Station where [Name] = @StationTo);		
		SET @RouteID = (select top 1 RouteID from Seat as S join Car as C ON s.CarID = c.ID join Train as T	ON c.TrainID = t.ID join RouteTrain as RT ON RT.TrainID = t.ID where S.ID = @SeatID);		
		set @Price = (select [dbo].[GetPriseForTicket] (@SeatID,@RouteID,@PersonID,@idFrom,@idTo));

	select 
		R.ID as TrainNumber,
		R.[Name] as RouteName,
		c.NumbeR as CarNumber,
		ct.[TYPE] as CarType,
		S.ID as SeatID,
		S.Number as SeatNumber,
		@Price as Price
	from 
		Seat as S
	join
		Car as C
	ON s.CarID = c.ID
	join
		Train as T
	ON c.TrainID = t.ID
	join
		RouteTrain as RT
	ON RT.TrainID = t.ID
	join
		CarType as CT
	ON CT.ID = C.Type
	join
		Route as R
	ON R.ID = t.ID
	Where S.ID = @SeatID
	END
	go


	CREATE PROC InsertTicket(
	@StationFrom VARCHAR(40), 
	@StationTo VARCHAR(40),
	@Surname VARCHAR (60),
	@Name VARCHAR (60),
	@SeatID INT,
	@Date DATE
	)
	AS
	BEGIN
		DECLARE @PersonID int, @idFrom int ,@idTo int,@RouteID int;
		DecLare @Price Decimal (6,3);
		DecLare @TimeArrive Time,@TimeDeparture Time;
			set @PersonID = (select ID from  Person where [Name] = @Name  AND Surname = @Surname);
			SET @idFrom = (select id from Station where [Name] = @StationFrom);
			SET @idTo = (select id from Station where [Name] = @StationTo);		
			SET @RouteID = (select RouteID from Seat as S join Car as C ON s.CarID = c.ID join Train as T	ON c.TrainID = t.ID join RouteTrain as RT ON RT.TrainID = t.ID where S.ID = @SeatID);		
			Set @TimeArrive =(select TimeArrival from StationRoute where RouteID = @RouteID AND StationID = @idFrom)
			Set @TimeDeparture =(select TimeDeparture from StationRoute where RouteID = @RouteID AND StationID = @idTo)	
			set @Price = (select [dbo].[GetPriseForTicket] (@SeatID,@RouteID,@PersonID,@idFrom,@idTo));

		INSERT INTO  Ticket(PersonID,StationFrom,StationTo,RouteTrainID,CarID,SeatID,[Date],Price,TimeArrive, TimeDepart)
		(select 
		@PersonID,
		@idFrom,@idTo,
		R.ID as RouteTrainID,
		s.CarID as CarID,
		S.ID as SeatID,
		@Date,
		@Price,
		@TimeArrive,
		@TimeDeparture
	from 
		Seat as S
	join
		Car as C
	ON s.CarID = c.ID
	join
		Train as T
	ON c.TrainID = t.ID
	join
		RouteTrain as RT
	ON RT.TrainID = t.ID
	join
		CarType as CT
	ON CT.ID = C.Type
	join
		Route as R
	ON R.ID = t.ID
	Where S.ID = @SeatID);
	end
	go

	
CREATE PROC ShowTicket(
	@Surname VARCHAR (60),
	@Name VARCHAR (60),
	@SeatID INT,
	@Date DATE,
	@StationFrom VARCHAR(40), 
	@StationTo VARCHAR(40)
	)
	AS
	BEGIN

		DECLARE @PersonID int,@TicketID int, @idFrom int ,@idTo int,@RouteID int;
		DecLare @TimeArrive Time,@TimeDeparture Time;
		Declare @Prise decimal (6,3);
		SET @PersonID = (select TOP 1 ID from  Person where [Name] = @Name  AND Surname = @Surname);
		SET @TicketID = (select TOP 1 ID from  Ticket where PersonID = @PersonID AND [Date] = Date AND SeatID = @SeatID)
		SET @idFrom = (select TOP 1 id from Station where [Name] = @StationFrom);
		SET @idTo = (select TOP 1 id from Station where [Name] = @StationTo);		
		SET @RouteID = (select TOP 1 RouteID from Seat as S join Car as C ON s.CarID = c.ID join Train as T	ON c.TrainID = t.ID join RouteTrain as RT ON RT.TrainID = t.ID where S.ID = @SeatID);		
		Set @TimeArrive =(select TOP 1 TimeArrival from StationRoute where RouteID = @RouteID AND StationID = @idFrom)
		Set @TimeDeparture =(select TOP 1 TimeDeparture from StationRoute where RouteID = @RouteID AND StationID = @idTo)	
		set @Prise=(select  [dbo].[GetPriseForTicket] (@SeatID,@RouteID,@PersonID,@idFrom,@idTo))

	select TOP 1
		Tik.RouteTrainID as Train,
		R.[Name] as TrainName,
		C.NumbeR as CarNumber,
		S.Number as SeatNumber,
		P.[Name] as NamePerson,
		P.Surname as SurnamePerson,	
		CT.[TYPE] as CarType,
		@TimeArrive as TimeArrive ,
		@TimeDeparture as TimeDeparture,
		@Prise as Prise 
	from 
	Ticket as Tik
	join
		Seat as S
	On Tik.SeatID = S.ID
	join
		Car as C
	ON s.CarID = c.ID
	join
		CarType as CT
	ON CT.ID = C.Type
	join
		Route as R
	ON R.ID = c.TrainID
	join
		Person as P
	On P.ID = Tik.PersonID
	Where Tik.ID =@TicketID; 
	end