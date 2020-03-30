using DaL;
using Ninject.Modules;
using Models.Interface;
using Models;
using Models.model.List;
using Models.model.Models;

namespace homework.Util
{
    public class NinjectRegistrations : NinjectModule
    {
        public override void Load()
        {
            Bind<IBookingValue>().To<BookingValue>();
            Bind<IConnect>().To<Conection>();
            Bind<IFreeList>().To<AllFreeTrainInfoList>();
            Bind<IFreeSeatList>().To<FreeSeatModellist>();
            Bind<IBookingValueForSeat>().To<BookingValueForSeat>();
            Bind<ISeatInfo>().To<SeatInfo>();
            Bind<IBuyingValueList>().To<BuyingValueList>();
            Bind<IShowTicketValueList>().To<ShowTicketValueList>();
            Bind<IStationList>().To<StationList>();
        }
    }
}