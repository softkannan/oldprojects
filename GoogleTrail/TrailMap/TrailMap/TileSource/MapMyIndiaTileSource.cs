using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Maps.MapControl.Core;
using Microsoft.Maps.MapControl;

namespace TrailMap.TileSource
{
    public class MapMyIndiaTileSource : Microsoft.Maps.MapControl.TileSource, IMapProvider
    {
        private const string mapMyIndiaURL = "http://maps.yimg.com/hw/tile?locale=en&imgtype=png&yimgv=1.2&v=4.1&x={0}&y={1}&z={2}";

        //Constructor Called by XAML instanciation; Wait for MapMode to be set to initialize services
        public MapMyIndiaTileSource()
            : base()
        {
        }

        public string FileExtn
        {
            get { return "png"; }
        }

        public MapType MapMode { get; set; }

        public Microsoft.Maps.MapControl.TileSource HybridBase
        {
            get { throw new NotImplementedException(); }
        }

        public override Uri GetUri(int x, int y, int zoomLevel)
        {
            // The math used here was copied from the DeepEarth Project (http://deepearth.codeplex.com) 
            double posY;
            double zoom = 18 - zoomLevel;
            double num4 = Math.Pow(2.0, zoomLevel) / 2.0;

            if (y < num4)
            {
                posY = (num4 - Convert.ToDouble(y)) - 1.0;
            }
            else
            {
                posY = ((Convert.ToDouble(y) + 1) - num4) * -1.0;
            }
            //Randomize to different OSM Servers based on URL prefix
            return new Uri(string.Format(mapMyIndiaURL, x, posY, zoom));

        }

    }
}
