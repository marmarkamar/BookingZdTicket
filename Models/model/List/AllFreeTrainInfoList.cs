using System;
using System.Collections.Generic;
using Models.Interface;

namespace Models.model.List
{
    public class AllFreeTrainInfoList: IFreeList
    {
        public BookingValue bookingValue { get; set; }
        public List<AllFreeTrainInfo> allfreeTraininfoList { get; set; }
        public DateTime Date { get; set; }

        public AllFreeTrainInfoList()
        {
            allfreeTraininfoList = new List<AllFreeTrainInfo>();
            bookingValue = new BookingValue();
        }
    }
}
