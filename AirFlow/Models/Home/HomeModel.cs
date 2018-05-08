using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AirFlow.Models.Home
{
    public class HomeModel
    {
        public string MapUrl { get; set; }
        public List<AirConditioner> AirConditioners { get; set; }

        public HomeModel(string mapUrl, List<AirConditioner> airConditioners)
        {
            MapUrl = mapUrl;
            AirConditioners = airConditioners;
        }
    }
}