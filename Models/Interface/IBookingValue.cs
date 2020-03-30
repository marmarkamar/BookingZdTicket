using System;

namespace Models.Interface
{
    public interface IBookingValue
    {
        string StationFrom { get; set; }
        string StationTo { get; set; }
        DateTime Date { get; set; }
        TimeSpan Time { get; set; }
    }
}
