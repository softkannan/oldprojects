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
using Microsoft.Maps.MapControl;

namespace TrailMap
{
    public class YahooTileSource : Microsoft.Maps.MapControl.TileSource, IMapProvider
    {
        // Yahoo version strings
        public string VersionYahooMap = "4.3";
        public string VersionYahooSatellite = "1.9";
        public string VersionYahooLabels = "4.3";

        private const string TilePathAerial = @"http://us.maps3.yimg.com/aerial.maps.yimg.com/tile?v=1.7&t=a&x={0}&y={1}&z={2}";
        private const string TilePathHybrid = @"http://us.maps3.yimg.com/aerial.maps.yimg.com/png?v=2.2&t=h&x={0}&y={1}&z={2}";
        private const string TilePathStreet = @"http://us.maps2.yimg.com/us.png.maps.yimg.com/png?v=3.52&t=m&x={0}&y={1}&z={2}";

        private MapType _MapMode = MapType.Normal;

        //Constructor Called by XAML instanciation; Wait for MapMode to be set to initialize services
        public YahooTileSource()
            : base()
        {
        }

        public Microsoft.Maps.MapControl.TileSource HybridBase
        {
            get
            {
                YahooTileSource retVal = new YahooTileSource();
                retVal.MapMode = MapType.Satellite;
                return retVal;
            }
        }

        public string FileExtn
        {
            get
            {
                if (this.MapMode == MapType.Normal || this.MapMode == MapType.Hybrid)
                {
                    return "png";
                }
                else
                {
                    return "jpeg";
                }
            }
        }

        public MapType MapMode
        {
            get { return _MapMode; }
            set
            {
                _MapMode = value;
            }
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

            string url = string.Empty;

            switch (_MapMode)
            {
                case MapType.Normal:
                    {
                        url = string.Format(TilePathStreet,x,posY,zoom);
                    }
                    break;
                case MapType.Satellite:
                    {
                        url = string.Format(TilePathAerial, x, posY, zoom);
                    }
                    break;
                case MapType.Hybrid:
                    {
                        url = string.Format(TilePathHybrid, x, posY, zoom);
                    }
                    break;
            }

            return new Uri(url);
        }
    }
}
