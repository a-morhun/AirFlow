using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Drawing;

namespace AirFlow.Models.Home
{
    public class AirConditioner
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public int MaxTemperature { get; set; }
        public int MinTemperature { get; set; }
        public string TemperatureScale { get; set; }
        public string ImageUrl { get; set; }
        public string PositionX { get; set; }
        public string PositionY { get; set; }
        public string Width { get; set; }
        public string Height { get; set; }
        public bool IsVertical { get; set; }

        public AirConditioner(Guid id,
            string name, 
            int maxTemperature, 
            int minTemperature, 
            string temperatureScale,
            string imageUrl,
            string positionX, 
            string positionY,
            string width,
            string height,
            bool isVertical)
        {
            Id = id;
            Name = name;
            MaxTemperature = maxTemperature;
            MinTemperature = minTemperature;
            TemperatureScale = temperatureScale;
            ImageUrl = imageUrl;
            PositionX = positionX;
            PositionY = positionY;
            Width = width;
            Height = height;
            IsVertical = isVertical;
        }
    }
}