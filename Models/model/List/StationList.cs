using System.Collections.Generic;
using Models.Interface;

namespace Models.model.List
{
    public class StationList : IStationList
    {
        public List<string> StatiListValue { get; set; }
        public StationList()
        {
            StatiListValue = new List<string>();
        }
    }
}