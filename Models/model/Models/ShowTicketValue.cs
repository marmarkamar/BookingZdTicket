using System;
using Models.Interface;


namespace Models.model.Models
{
    public class ShowTicketValue : IShowTicketValue
    {
       public int Train { get; set; }
       public string TrainName { get; set; }
       public int CarNumber { get; set; }
       public int SeatNumber { get; set; }
       public string NamePerson { get; set; }
       public string SurnamePerson { get; set; }
       public string CarType { get; set; }
       public TimeSpan TimeArrive { get; set; }
       public TimeSpan TimeDeparture { get; set; }
       public string StationFrom { get; set; }
       public string StationTo { get; set; }
       public DateTime Date { get; set; }
       public decimal Prise { get; set; }
    }
}