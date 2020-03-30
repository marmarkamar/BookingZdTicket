using System;

namespace Models.Interface
{
    public interface IBuyingValue
    {
        int TrainNumber { get; set; }
        string RouteName { get; set; }
        int CarNumber { get; set; }
        string CarType { get; set; }
        int SeatID { get; set; }
        int SeatNumber { get; set; }

        string StationFrom { get; set; }
        string StationTo { get; set; }
        DateTime Date { get; set; }
        string Name { get; set; }
        string SName { get; set; }
        decimal Price { get; set; }

    }
}