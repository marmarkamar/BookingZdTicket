using Models.Interface;

namespace Models.model.Models
{
    public class SeatInfo : ISeatInfo
    {
        public int SeatID { get; set; }
        public int SeatNumber { get; set; }
        public int CarNumber { get; set; }
        public decimal Price { get; set; }
    }
}