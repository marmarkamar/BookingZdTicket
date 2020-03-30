using System.Collections.Generic;
using Models;
using Models.Interface;
using DataBase;
using Models.model.List;
using Models.model.Models;

namespace DaL
{
    public class Conection: IConnect
    {
        private FreeTrainCar freeTrainCar;
        private Repository repository;
        private DBConnect Base;
        private IFreeList allFreeTrainInfo;
        private FreeTrainCar freeSeat;
        private IFreeSeatList freeSeatlist;
        private SeatInfo seatInfo;
        private List<BuyingValue> buying;
        private List<ShowTicketValue> ShowTicketValue;
        private IShowTicketValueList ShowTicketValueList;
        private IStationList stationListValue;
        public Conection()
        {
            freeTrainCar = new FreeTrainCar();
            Base = new DBConnect();
            allFreeTrainInfo = new AllFreeTrainInfoList();;
            repository =  new Repository();
            freeSeat = new FreeTrainCar();
            freeSeatlist = new FreeSeatModellist();
            seatInfo = new SeatInfo();
            buying =   new List<BuyingValue>();
            ShowTicketValue = new List<ShowTicketValue>();
            ShowTicketValueList = new ShowTicketValueList();
            stationListValue = new StationList();
        }

        public IFreeList GetTrainFromBD(IBookingValue bookingValue)
        {
            freeTrainCar = Base.GetTrain(bookingValue, freeTrainCar);
            allFreeTrainInfo = repository.InsertInAllFreeTrainInfo(freeTrainCar, bookingValue);

            return allFreeTrainInfo;
        }
        
        public IFreeSeatList GetFreeSeatFromBase(IBookingValueForSeat bookingValueForSeat)
        {
            freeSeat = Base.GetFreeSeat(bookingValueForSeat, freeSeat);

            freeSeatlist = repository.InsertIntoFreeSeatList(freeSeat,bookingValueForSeat);
            
            return freeSeatlist;
        }

        public ISeatInfo GetFreeSeatInfo(int ID)
        {
            seatInfo = Base.GetFreeSeatInfoFromDB(ID, seatInfo);

            return seatInfo;
        }

        public IBuyingValueList GetBuyingInfo(BuyingTicketValue buyingValue)
        {
            buying= Base.GetBuyingInfoFromDB(buyingValue);
            BuyingValueList buingValueList = new BuyingValueList();
            buingValueList = repository.InsertValueIntoClass(buyingValue, buying, buingValueList);

            return buingValueList;
        }
        public IShowTicketValueList InsertValue(BuyingValueForInsert InsertValue)
        {
            ShowTicketValue = Base.InsertValueInTicketBS(InsertValue, ShowTicketValue);
            ShowTicketValueList = repository.InsertShowValueIntoClass(InsertValue, ShowTicketValue, ShowTicketValueList);
            return ShowTicketValueList;
        }
        
        public IStationList GetStationTop10FromDB(string station)
        {
            stationListValue.StatiListValue = Base.GetStationTop10(station);
            return stationListValue;
        }
        
        public bool Check(string station1, string station2)
        {
            return Base.CheckInBase(station1,station2);
        }
        public void Send(string InsertValue, string name, string sName)
        {
            EmailService Letter = new EmailService();
            string mail = Base.GetMailFromBD(name, sName);
            Letter.SendMail("smtp.gmail.com", "marmarkamar@gmail.com", "159753789654321", mail, "Ticket", InsertValue);
        }

    }
}
