using System;

namespace Models.Interface
{
    public interface IShowTicketValue
    {
        int Train { get; set; }
        string TrainName { get; set; }
        int CarNumber { get; set; }
        int SeatNumber { get; set; }
        string NamePerson { get; set; }
        string SurnamePerson { get; set; }
        string CarType { get; set; }
        TimeSpan TimeArrive { get; set; }
        TimeSpan TimeDeparture { get; set; }

        decimal Prise { get; set; }
    }
}