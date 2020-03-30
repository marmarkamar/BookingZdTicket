using System;
using System.Collections.Generic;

namespace Models.Interface
{
    public interface IBuyingValueForInsert
    {
        List<string> StationFrom { get; set; }
        List<string> StationTo { get; set; }
        List<string> Surname { get; set; }
        List<string> Name { get; set; }
        List<int>  SeatID { get; set; }
        List<DateTime> Date { get; set; }
    }
}