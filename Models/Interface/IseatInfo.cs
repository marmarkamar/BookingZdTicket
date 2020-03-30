namespace Models.Interface
{
    public interface ISeatInfo
    {
        int SeatID { get; set; }
        int SeatNumber { get; set; }
        int CarNumber { get; set; }
        decimal Price { get; set; }
    }
}