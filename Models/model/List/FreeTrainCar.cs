using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models.model.Models;

namespace Models
{
    public class FreeTrainCar
    {
        public List<FreeTrainInfo> freeTrain;
        public List<FreeCarInfo> freeCar;
        public List<CarSeat> freeSeat;

        public FreeTrainCar()
        {
            freeTrain = new List<FreeTrainInfo>();
            freeCar = new List<FreeCarInfo>();
            freeSeat = new List<CarSeat>();
        }

    }
}
