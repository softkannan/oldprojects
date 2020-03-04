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

namespace TrailMap.TileSource
{
    public class TileSourceProvider
    {
        private YahooTileSource yahooSource = null;
        public YahooTileSource YahooSource
        {
            get
            {
                if (yahooSource == null)
                {
                    yahooSource = new YahooTileSource();
                }
                return yahooSource;
            }
        }
        private GoogleTileSource googleSource = null;

        public GoogleTileSource GoogleSource
        {
            get 
            {
                if (googleSource == null)
                {
                    googleSource = new GoogleTileSource();
                }
                return googleSource; 
            }
        }
        private CloudeMateTileSource cmSource = null;

        public CloudeMateTileSource CmSource
        {
            get
            {
                if (cmSource == null)
                {
                    cmSource = new CloudeMateTileSource();
                }
                return cmSource;
            }
        }

        private OpenStreetMapTileSource openStreetMapTileSource = null;

        public OpenStreetMapTileSource OpenStreetMapTileSource
        {
            get
            {
                if (openStreetMapTileSource == null)
                {
                    openStreetMapTileSource = new OpenStreetMapTileSource();
                }
                return openStreetMapTileSource;
            }
        }

        private MapMyIndiaTileSource mapMyIndiaTileSource = null;

        public MapMyIndiaTileSource MapMyIndiaTileSource
        {
            get
            {
                if (mapMyIndiaTileSource == null)
                {
                    mapMyIndiaTileSource = new MapMyIndiaTileSource();
                }
                return mapMyIndiaTileSource;
            }
        }

        private BingTileSource bingTileSource = null;

        public BingTileSource BingTileSource
        {
            get 
            {
                if (bingTileSource == null)
                {
                    bingTileSource = new BingTileSource();
                }
                return bingTileSource; 
            }
        }


    }
}
