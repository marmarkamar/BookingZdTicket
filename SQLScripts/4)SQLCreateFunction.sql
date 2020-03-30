use RailWay
go

CREATE FUNCTION GetFreeSeatNumberPart1 (
@Date DATE
) 
		RETURNS TABLE
		AS
		RETURN
			SELECT 
				S.ID as seatID,
				S.Number as NumberSeat,
				C.TrainID,
				C.NumbeR AS NumberCar,
				CT.[TYPE] AS CarType,
				ST.[Type]						
			FROM Seat AS S
			JOIN
		         Car AS C
			ON S.CarID = C.ID
		    JOIN 
				 CarType AS CT
			ON C.[Type] =CT.ID
			JOIN
				 SeatType AS ST
			ON S.Type =ST.ID
			LEFT JOIN 
				 Ticket AS T
			ON S.ID = T.SeatID
			WHERE		
				T.Date IS NULL OR 
				T.Date != @Date;

go
		
		
CREATE FUNCTION GetFreeSeatNumberPart2 (
			@StationFrom int, 
			@StationTo int,
			@Date DATE
) 
		RETURNS TABLE
		AS
		RETURN(
			SELECT 
				S.ID as seatID,
				S.Number as NumberSeat,
				C.TrainID,
				C.NumbeR AS NumberCar,
				CT.[TYPE] AS CarType,
				ST.[Type]	
			FROM Seat AS S
			JOIN
		         Car AS C
			ON S.CarID = C.ID
		    JOIN 
				 CarType AS CT
			ON C.[Type] =CT.ID
			JOIN
				 SeatType AS ST
			ON S.Type =ST.ID
			LEFT JOIN 
				 Ticket AS T
			ON S.ID = T.SeatID
			WHERE		
				T.Date = @Date AND
				(T.StationFrom BETWEEN @StationFrom - 1 and @StationTo - 1  OR 
				T.StationTo BETWEEN @StationFrom - 1 and @StationTo -1 OR
				@StationFrom BETWEEN T.StationFrom -1 and T.StationTo -1  OR
				@StationTo BETWEEN T.StationFrom -1  and T.StationTo -1 ));
go

CREATE FUNCTION GetFreeSeatNumberColab (
			  @StationFrom int, 
			  @StationTo int,
			  @Date DATE
			  )   
		RETURNS TABLE
		AS
		RETURN
				SELECT *			
				FROM 
					GetFreeSeatNumberPart1(@Date)  
				EXCEPT 			
				SELECT *				
				FROM 
					GetFreeSeatNumberPart2(@StationFrom,@StationTo,@Date);

go
CREATE FUNCTION GetRouteTrain (
		@StationFrom VARCHAR(40), 
		@StationTo VARCHAR(40)		
		)   
    RETURNS TABLE
	AS
	RETURN
		SELECT 
			S1.RouteTrainID,
			S1.TrainID,
			S1.RouteName,
			S1.StaitionName AS Sfrom ,
			S1.TimeArrival AS TimeArrival1,
			S2.StaitionName AS Sto,
			S2.TimeArrival AS TimeArrival2
		FROM 
				(SELECT * FROM RouteStationView WHERE	StaitionName = @StationFrom)	AS S1
			JOIN
				(SELECT * FROM RouteStationView	WHERE StaitionName = @StationTo	)	AS S2
			ON S1.RouteTrainID = S2.RouteTrainID
			WHERE S1.StationRouteID < S2.StationRouteID;
