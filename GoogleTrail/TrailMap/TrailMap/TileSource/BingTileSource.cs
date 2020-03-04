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
using System.Text;

namespace TrailMap.TileSource
{
    public class BingTileSource : Microsoft.Maps.MapControl.TileSource, IMapProvider
    {
        // BingMaps
        public string VersionBingMaps = "472";

        private const string TilePathAerial = @"http://ecn.t{0}.tiles.virtualearth.net/tiles/a{1}.jpeg?g={2}&mkt=en-us&shading=hill&n=z";
        private const string TilePathHybrid = @"http://ecn.t{0}.tiles.virtualearth.net/tiles/h{1}.jpeg?g={2}&mkt=en-us&shading=hill&n=z";
        private const string TilePathStreet = @"http://ecn.t{0}.tiles.virtualearth.net/tiles/r{1}.png?g={2}&mkt=en-us&shading=hill&n=z";

        private MapType _MapMode = MapType.Normal;

        //Constructor Called by XAML instanciation; Wait for MapMode to be set to initialize services
        public BingTileSource()
            : base()
        {
        }

        public string FileExtn
        {
            get
            {
                if (this.MapMode == MapType.Normal)
                {
                    return "png";
                }
                else
                {
                    return "jpeg";
                }
            }
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

        public MapType MapMode
        {
            get { return _MapMode; }
            set
            {
                _MapMode = value;
            }
        }

        /// <summary>
        /// gets server num based on position
        /// </summary>
        /// <param name="pos"></param>
        /// <returns></returns>
        internal int GetServerNum(int x, int y, int max)
        {
            return (x + 2 * y) % max;
        }

        /// <summary>
        /// Converts tile XY coordinates into a QuadKey at a specified level of detail.
        /// </summary>
        /// <param name="tileX">Tile X coordinate.</param>
        /// <param name="tileY">Tile Y coordinate.</param>
        /// <param name="levelOfDetail">Level of detail, from 1 (lowest detail)
        /// to 23 (highest detail).</param>
        /// <returns>A string containing the QuadKey.</returns>
        internal string TileXYToQuadKey(int tileX, int tileY, int levelOfDetail)
        {
            StringBuilder quadKey = new StringBuilder();
            for (int i = levelOfDetail; i > 0; i--)
            {
                char digit = '0';
                int mask = 1 << (i - 1);
                if ((tileX & mask) != 0)
                {
                    digit++;
                }
                if ((tileY & mask) != 0)
                {
                    digit++;
                    digit++;
                }
                quadKey.Append(digit);
            }
            return quadKey.ToString();
        }

        public override Uri GetUri(int x, int y, int zoomLevel)
        {
            string key = TileXYToQuadKey(x, y, zoomLevel);

            string url = string.Empty;

            switch (_MapMode)
            {
                case MapType.Normal:
                    {
                        url = string.Format(TilePathStreet, GetServerNum(x, y, 4), key, VersionBingMaps);
                    }
                    break;
                case MapType.Satellite:
                    {
                        url = string.Format(TilePathAerial, GetServerNum(x, y, 4), key, VersionBingMaps);
                    }
                    break;
                case MapType.Hybrid:
                    {
                        url = string.Format(TilePathHybrid, GetServerNum(x, y, 4), key, VersionBingMaps);
                    }
                    break;
            }

            return new Uri(url);
        }
    }
}
