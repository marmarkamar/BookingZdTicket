using System;
using System.Collections.Generic;
using Models.model;

namespace Models.Interface
{
    public interface IFreeList
    {
         BookingValue bookingValue { get; set; }
         List<AllFreeTrainInfo> allfreeTraininfoList { get; set; }
         DateTime Date { get; set; }
    }
}
