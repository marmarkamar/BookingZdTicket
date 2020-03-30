using System;
using Models.Interface;

namespace Models
{
    public class BookingValue: IBookingValue
    {
        public string StationFrom { get; set; }
        public string StationTo { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan Time { get; set; }
    }
}
