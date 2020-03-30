using System.Collections.Generic;


namespace Models.model.Models
{
    public class FreeSeatList
    {
        public CarInfo CarInfos { get; set; }

        public List<CarSeat> freeSeat { get; set; }

        public FreeSeatList()
        {
            freeSeat = new List<CarSeat>();
        }


    }
}
