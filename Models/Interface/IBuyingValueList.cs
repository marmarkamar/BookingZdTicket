using System.Collections.Generic;
using Models.model.Models;

namespace Models.Interface
{
    public interface IBuyingValueList
    {
         List<BuyingValue> TicketList { get; set; }
    }
}