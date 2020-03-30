use RailWay;
go

CREATE VIEW RouteStationView
AS 
	SELECT 
		RT.ID AS RouteTrainID,
		RT.TrainID,
		R.[Name] AS RouteName,
		SR.ID AS StationRouteID,
		S.[Name] AS StaitionName,
		SR.TimeArrival,
		SR.TimeDeparture
	FROM		
		RouteTrain AS RT
	JOIN
		Route AS R
	ON	RT.RouteID = R.ID
	JOIN	
		StationRoute AS SR
	ON	R.ID = SR.RouteID
	JOIN 
		Station AS S
	ON	SR.StationID = S.ID	
