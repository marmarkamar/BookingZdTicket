using System;
using System.Collections.Generic;

namespace Models.Interface
{
    public interface IBuyingTicketValue
    {
        string StationFrom { get; set; }
        string StationTo { get; set; }
        DateTime Date { get; set; }
        List<string>Privilege { get; set; }
        List<int> SeatID { get; set; }
        List<string> Name { get; set; }
        List<string> SName { get; set; }
        List<string> Mail { get; set; }
    }
}