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
using System.Windows.Media.Imaging;
using Microsoft.Maps.MapControl;

namespace TrailMap
{
    public class CloudeMateTileSource : Microsoft.Maps.MapControl.TileSource, IMapProvider
    {
        private const string TilePathCycle = "http://{0}.andy.sandbox.cloudmade.com/tiles/cycle/{1}/{2}/{3}.png";
        private const string TilePathMobile = "http://{0}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/2/256/{1}/{2}/{3}.png";
        private const string TilePathNoNames = "http://{0}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/3/256/{1}/{2}/{3}.png";
        private const string TilePathWeb = "http://{0}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/1/256/{1}/{2}/{3}.png";
        private readonly Random _Rand = new Random();
        private readonly string[] TilePathPrefixes = new[] { "a", "b", "c" };


        //Constructor Called by XAML instanciation; Wait for MapMode to be set to initialize services
        public CloudeMateTileSource()
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
            string url = string.Empty;
            string prefix = string.Empty;
            switch (MapMode)
            {
                case MapType.Normal:
                    prefix = TilePathPrefixes[_Rand.Next(3)];
                    url = TilePathWeb;
                    break;
                case MapType.Hybrid:
                    prefix = TilePathPrefixes[_Rand.Next(3)];
                    url = TilePathMobile;
                    break;
                case MapType.Satellite:
                    prefix = TilePathPrefixes[_Rand.Next(3)];
                    url = TilePathNoNames;
                    break;
                case MapType.Terrain:
                    prefix = TilePathPrefixes[_Rand.Next(3)];
                    url = TilePathCycle;
                    break;
            }

            //Randomize to different OSM Servers based on URL prefix
            return new Uri(string.Format(url, prefix, zoomLevel, x, y));

        }

    }
}
