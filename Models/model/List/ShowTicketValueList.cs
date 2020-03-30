using System.Collections.Generic;
using Models.Interface;
using Models.model.Models;

namespace Models.model.List
{ public class ShowTicketValueList : IShowTicketValueList
    {
        public  List<ShowTicketValue> ShowTicketValue { get; set; }
        public ShowTicketValueList()
        {
            ShowTicketValue = new List<ShowTicketValue>();
        }
    }
}