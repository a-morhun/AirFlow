//using System;
//using System.Collections.Generic;
//using System.Globalization;
//using System.Linq;
//using System.Web;
//using Umbraco.Core.Models;
//using Umbraco.Core.Strings;

//namespace AirFlow.Routing   
//{
//    public class AirFlowSegmentProvider : IUrlSegmentProvider
//    {
//        public string GetUrlSegment(IContentBase content)
//        {
//            return $"1-{content.Name}";
//        }

//        public string GetUrlSegment(IContentBase content, CultureInfo culture)
//        {
//            return $"2-{content.Name}";
//        }
//    }
//}