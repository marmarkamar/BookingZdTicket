using System;
using System.Collections.Generic;
using Models.Interface;
using Models.model.Models;

namespace Models.model.List
{
    public class FreeSeatModellist :IFreeSeatList
    {
        public BookingValue bookingValue { get; set; }
        public FreeTrainInfo FreeTrainInfo { get; set; }
        public List<FreeCarInfo> CarTypeSeatInfos { get; set; }
        public List<FreeSeatList> free { get; set; }

        public DateTime Date { get; set; }

        public FreeSeatModellist()
        {
            free = new List<FreeSeatList>();
            bookingValue = new BookingValue();

        }
    }
}
