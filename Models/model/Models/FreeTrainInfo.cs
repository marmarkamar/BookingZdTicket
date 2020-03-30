using System;

namespace Models
{
    public class FreeTrainInfo
    {
        public int TrainNumber { get; set; }
        public string RouteName { get; set; }
        public TimeSpan TimeArrival { get; set; }
        public TimeSpan TimeDeparture { get; set; }

    }
}
