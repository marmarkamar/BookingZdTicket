using System;

namespace Models.Interface
{
    public interface IBookingValueForSeat
    {
        int TrainRouteId { get; set; }
        string StationFrom { get; set; }
        string StationTo { get; set; }
        string CarType { get; set; }
        DateTime Date { get; set; }
        TimeSpan Time { get; set; }

    }
}