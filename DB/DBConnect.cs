using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using Dapper;
using Models;
using Models.Interface;
using Models.model.Models;

namespace DataBase
{
    public class DBConnect
    {
        public FreeTrainCar GetTrain(IBookingValue bookingValue,FreeTrainCar freeTrainCar)
        {
            using ( var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString)) 
            {
                var sql = "exec [FindPlaceProc] @StationFrom, @StationTo, @Date,@Time";
                var values = new {bookingValue.StationFrom, bookingValue.StationTo, bookingValue.Date, bookingValue.Time};
                using (var multi = connection.QueryMultiple(sql, values))
                {
                    freeTrainCar.freeTrain = multi.Read<FreeTrainInfo>().ToList();
                    freeTrainCar.freeCar = multi.Read<FreeCarInfo>().ToList();
                }
            }
            return freeTrainCar;
        }

        public FreeTrainCar GetFreeSeat(IBookingValueForSeat bookingValueForSeat, FreeTrainCar freeSeat)
        {
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql = "exec [FindAllPlaceProc] @TrainRouteId, @StationFrom, @StationTo, @CarType, @Date,@Time";
                var values = new { bookingValueForSeat.TrainRouteId, bookingValueForSeat.StationFrom, bookingValueForSeat.StationTo, bookingValueForSeat.CarType, bookingValueForSeat.Date, bookingValueForSeat.Time };
                using (var multi = connection.QueryMultiple(sql, values))
                {
                    freeSeat.freeTrain = multi.Read<FreeTrainInfo>().ToList();
                    freeSeat.freeCar = multi.Read<FreeCarInfo>().ToList();
                    freeSeat.freeSeat = multi.Read<CarSeat>().ToList();
                }
            }
            return freeSeat;
        } 

        public SeatInfo GetFreeSeatInfoFromDB(int SeatID, SeatInfo SeatInfo)
        {
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql = "exec [GetSomeSeatInfo] @SeatID";
                var values = new {SeatID};
                SeatInfo = connection.QueryFirst<SeatInfo>(sql, values);
            }
            return SeatInfo;
        } 

        public List<BuyingValue> GetBuyingInfoFromDB(BuyingTicketValue buyingValue)
        {
            List<BuyingValue> buying = new List<BuyingValue>();
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql = "exec [GetBuingValueForTicket] @StationFrom,@StationTo,@Surname,@Name,@Privilege,@SeatID,@Mail";
                
                for (int i = 0; i < buyingValue.SeatID.Count; i++)
                {
                    var values = new
                    {
                        StationFrom = buyingValue.StationFrom, 
                        StationTo = buyingValue.StationTo,
                        Surname = buyingValue.SName[i],
                        Name = buyingValue.Name[i], 
                        Privilege = buyingValue.Privilege[i], 
                        SeatID = buyingValue.SeatID[i],
                        Mail = buyingValue.Mail[i]
                    };
                    buying.Add(connection.QueryFirst<BuyingValue>(sql, values));
                }
            }
            return buying;
        }

        public List<ShowTicketValue> InsertValueInTicketBS(BuyingValueForInsert InsertValue, List<ShowTicketValue> ShowTicketValue)
        {
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql1 = "exec [InsertTicket]  @StationFrom,@StationTo,@Surname,@Name,@SeatID,@Date";
                var sql2 = "exec [ShowTicket] @Surname,@Name,@SeatID,@Date,@StationFrom,@StationTo";

                for (int i = 0; i < InsertValue.SeatID.Count; i++)
                {
                    var values1 = new
                    {
                        StationFrom = InsertValue.StationFrom[i], StationTo = InsertValue.StationTo[i], Surname = InsertValue.Surname[i], Name = InsertValue.Name[i],
                        SeatID = InsertValue.SeatID[i],Date = InsertValue.Date[i]
                    };
                    var values2 = new
                    {
                        Surname = InsertValue.Surname[i],
                        Name = InsertValue.Name[i],
                        SeatID = InsertValue.SeatID[i],
                        Date = InsertValue.Date[i],
                        StationFrom = InsertValue.StationFrom[i],
                        StationTo = InsertValue.StationTo[i]
                    };

                    connection.Query(sql1, values1);
                    ShowTicketValue.Add(connection.QueryFirst<ShowTicketValue>(sql2, values2));
                }
            }
            return ShowTicketValue;
        }

        public  bool  CheckInBase(string stationValue1,string stationValue2)
        {
            List<Station> stationList= new List<Station>();

            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString)) 
            {
                var sql = "SELECT [Name] FROM [RailWay].[dbo].[Station] WHERE Name Like @Station";
                var values1 = new { Station = stationValue1 };
                var values2 = new { Station = stationValue2 };
                stationList = connection.Query<Station>(sql, values1).ToList(); 
                if (stationList.Count > 0)
                {
                    stationList = connection.Query<Station>(sql, values2).ToList();
                    if (stationList.Count > 0)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        public List<string> GetStationTop10(string stationValue)
        {
            List<string> stationList = new List<string>();
            stationValue = stationValue + "%";
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql = "SELECT TOP 10 [Name] FROM [RailWay].[dbo].[Station] WHERE Name Like @Station";
                var values = new { Station = stationValue};
                stationList = connection.Query<string>(sql, values).ToList();
            }
            return stationList;
        } 

        public string GetMailFromBD (string Name, string sName)
        {
            string Mail = "";
            using (var connection = new SqlConnection(ConfigurationManager.ConnectionStrings["RW"].ConnectionString))
            {
                var sql = "select top 1 MailAddres as Mail from [Person] where [Name] = '" + Name + "' and [Surname] = '" + sName +"';";
                Mail = connection.Query<string>(sql).ToList()[0];
            }
            return Mail;
        }
    }
}
