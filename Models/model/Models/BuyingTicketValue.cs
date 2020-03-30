using System;
using Models.Interface;
using System.Collections.Generic;

namespace Models.model.Models
{
    public class BuyingTicketValue : IBuyingTicketValue
    {
        public string StationFrom { get; set; }
        public string StationTo { get; set; }
        public DateTime Date { get; set; }
        public List<string> Privilege { get; set; }
        public  List<int> SeatID { get; set; }
        public  List<string> Name { get; set; }
        public List<string> SName { get; set; }
        public List<string> Mail { get; set; }

    }
}