using System.Web.Mvc;
using Models;
using Models.Interface;
using Models.model.Models;
using Ninject;

namespace homework.Controllers
{
    public class HomePageController : Controller
    {
        public IBookingValue bookingValue;
        public IBookingValueForSeat bookingValueForSeat;
        public IConnect TrainInfo;
        public IFreeList allFreeTrainInfoList;
        public IFreeSeatList freeSeatList;
        public ISeatInfo seatInfo;
        public IBuyingValueList buying;
        public IShowTicketValueList ShowTicketValueList;
        public IStationList StationListValue;

        public HomePageController(IBookingValue BV, IFreeList AFTI, IConnect C, IFreeSeatList FSL, IBookingValueForSeat BVFS, ISeatInfo SI, IBuyingValueList BVL, IShowTicketValueList istvl, IStationList svl)
        {
            bookingValue = BV;
            TrainInfo = C;
            allFreeTrainInfoList = AFTI;
            freeSeatList = FSL;
            bookingValueForSeat = BVFS;
            seatInfo = SI;
            buying = BVL;
            ShowTicketValueList = istvl;
            StationListValue = svl;
        }
        public ActionResult Index()
        {
            return View(bookingValue);
        }
        [HttpPost]
        public ActionResult Index(BookingValue bookingValue)
        {
            if (TrainInfo.Check(bookingValue.StationFrom,bookingValue.StationTo))
            {
                allFreeTrainInfoList = TrainInfo.GetTrainFromBD(bookingValue);
                return View("ShowTrain", allFreeTrainInfoList);
            }

            ViewBag.Massage = "Incorrect Station ";
            return View("View");
        }

        [HttpPost]
        public ActionResult GetFreeSeat(BookingValueForSeat bookingValueForSeat)
        {
            freeSeatList = TrainInfo.GetFreeSeatFromBase(bookingValueForSeat);
            return View(freeSeatList);
        }
        [HttpPost]
        public ActionResult ShowFreeSeat(FreeSeatList free)
            {
                if (free.CarInfos.CarType == "CB")
                {
                    return View("ShowCB", free);
                }
                else if (free.CarInfos.CarType == "К")
                {
                    return View("ShowK", free);
                }
                else if (free.CarInfos.CarType == "Люкс")
                {
                    return View("ShowLuks", free);
                }
                else if (free.CarInfos.CarType == "ПЛ")
                {
                    return View("ShowPl", free);
                }
                else
                {
                    return View("ShowC", free);
                }
            }

        [HttpPost]
        public ActionResult BookingSeats(int id)
        {
            seatInfo = TrainInfo.GetFreeSeatInfo(id);
            return View("ReserveTicket", seatInfo);
        }  
        [HttpPost]
        public ActionResult BuyingTicket(BuyingTicketValue buyingValue)
        {
            buying = TrainInfo.GetBuyingInfo(buyingValue);

                    return View("BuyingTicket", buying);
        } 
        [HttpPost]
        public ActionResult InsertTicket(BuyingValueForInsert InsertValue)
        {
            ShowTicketValueList = TrainInfo.InsertValue(InsertValue);
            
            return View("Ticket", ShowTicketValueList);
        }
        [HttpPost]
        public ActionResult SelectStationValue(string InsertValue)
        {
            StationListValue = TrainInfo.GetStationTop10FromDB(InsertValue);
            
            return Json(StationListValue.StatiListValue);
        }
        public void SendMail(string InsertValue,string name, string sName)
        {
            TrainInfo.Send(InsertValue,name,sName);
        }


    }
}
