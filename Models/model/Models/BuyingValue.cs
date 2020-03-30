using System;
using Models.Interface;


namespace Models.model.Models
{
    public class BuyingValue : IBuyingValue
    {
        public int TrainNumber { get; set; }
        public string RouteName { get; set; }
        public int CarNumber { get; set; }
        public string CarType { get; set; }
        public int SeatID { get; set; }
        public int SeatNumber { get; set; }

        public string StationFrom { get; set; }
        public string StationTo { get; set; }
        public DateTime Date { get; set; }
        public string Name { get; set; }
        public string SName { get; set; }
        public decimal Price { get; set; }
    }
}