using System;
using Models.Interface;

namespace Models.model.Models
{
    public class BookingValueForSeat: IBookingValueForSeat
    {
       public int TrainRouteId { get; set; }
       public string StationFrom { get; set; }
       public string StationTo { get; set; }
       public string CarType { get; set; }
       public DateTime Date { get; set; }
       public TimeSpan Time { get; set; }
    }
}
