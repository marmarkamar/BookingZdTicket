using System.Collections.Generic;


namespace Models.model
{
    public class AllFreeTrainInfo
    {
        public FreeTrainInfo freeTrain { get; set; }

        public IEnumerable<FreeCarInfo> freeCar;
    }
}
