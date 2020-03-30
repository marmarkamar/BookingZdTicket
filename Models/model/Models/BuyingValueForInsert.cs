using System;
using Models.Interface;
using System.Collections.Generic;

namespace Models.model.Models
{
    public class BuyingValueForInsert: IBuyingValueForInsert
    {
        public List<string> StationFrom { get; set; }
        public List<string> StationTo { get; set; }
        public List<string> Surname { get; set; }
        public List<string> Name { get; set; }
        public List<int>  SeatID { get; set; }
        public List<DateTime> Date { get; set; }

    }
}