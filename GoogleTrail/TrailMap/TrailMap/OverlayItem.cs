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
using TrailMap.TileSource;
using Microsoft.Maps.MapControl.Core;
using Microsoft.Maps.MapControl;

namespace TrailMap
{
    public class OverlayItem
    {
        public string DisplayName { get; private set; }
        private int opaque;
        public int Opaque
        {
            get { return opaque; }
            set
            {
                opaque = value;
                this.Provider.Opacity = ((double)value / 100.0);
            }
        }

        public int MapSource {get;private set;}

        private int mapType;
       
        public int MapType 
        {
            get { return mapType; }
            set
            {
                mapType = value;
                IMapProvider prov = this.Provider.TileSources[0] as IMapProvider;
                this.Provider.TileSources.Clear();
                prov.MapMode = (MapType)value;
                mapLayer.TileSources.Add(prov as Microsoft.Maps.MapControl.TileSource);
                mapLayer.Visibility = System.Windows.Visibility.Visible;
            }
        }
        public OverlayItem(string displayName,int opaque,int mapSource, MapType mapType)
        {
            this.MapSource = mapSource;
            this.mapType = (int)mapType;
            this.DisplayName = displayName;
            this.opaque = opaque;
        }

        private MapTileLayer mapLayer = null;
        static TileSourceProvider sourceProvider = new TileSourceProvider();

        private MapTileLayer GetProvider(int mapSourceType)
        {
            MapTileLayer retVal;
            switch (mapSourceType)
            {
                case 1:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add(sourceProvider.GoogleSource);
                    break;
                case 2:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add( sourceProvider.YahooSource);
                    break;
                case 3:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add(sourceProvider.CmSource);
                    break;
                case 4:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add(sourceProvider.OpenStreetMapTileSource);
                    break;
                case 5:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add( sourceProvider.MapMyIndiaTileSource);
                    break;
                case 6:
                    retVal = new MapTileLayer();
                    retVal.TileSources.Add(sourceProvider.BingTileSource);
                    break;
                default:
                    throw new IndexOutOfRangeException("Add overlay support");
            }

            return retVal;
        }

        public MapTileLayer Provider
        {
            get
            {
                if (mapLayer == null)
                {
                    mapLayer = GetProvider(MapSource);
                }

                IMapProvider provider = mapLayer.TileSources[0] as IMapProvider;

                provider.MapMode = (MapType)this.MapType;
                this.mapLayer.Opacity = ((double)this.Opaque / 100.0);
                return mapLayer;
            }
        }
    }
}
