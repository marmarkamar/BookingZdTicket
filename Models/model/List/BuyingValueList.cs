using System;
using Models.model.Models;
using System.Collections.Generic;
using Models.Interface;

namespace Models.model.List
{
    public class BuyingValueList: IBuyingValueList
    {
        public List<BuyingValue> TicketList { get; set; } 
        public BuyingValueList()
        {
            TicketList = new List<BuyingValue>();
        }

    }
}