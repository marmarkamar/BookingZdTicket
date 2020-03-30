using System;
using System.Collections.Generic;
using Models.model.Models;

namespace Models.Interface
{
    public interface IFreeSeatList
    {
        List<FreeSeatList> free { get; set; }
        DateTime Date { get; set; }
        FreeTrainInfo FreeTrainInfo { get; set; }
         List<FreeCarInfo> CarTypeSeatInfos { get; set; }
         BookingValue bookingValue { get; set; }

    }
}