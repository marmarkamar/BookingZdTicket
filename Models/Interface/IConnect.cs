using Models.Interface;
using Models.model.Models;

namespace Models
{
    public interface IConnect
    {
        IFreeList GetTrainFromBD(IBookingValue bookingValue);
        bool Check(string station1, string station2);
        IFreeSeatList GetFreeSeatFromBase (IBookingValueForSeat bookingValueForSeat);
        ISeatInfo GetFreeSeatInfo(int id);
        IBuyingValueList GetBuyingInfo(BuyingTicketValue buyingValue);
        IShowTicketValueList InsertValue(BuyingValueForInsert InsertValue);
        IStationList GetStationTop10FromDB(string insertValue);
        void Send(string InsertValue, string name, string sName);
    }
}