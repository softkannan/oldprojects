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

namespace TrailMap
{
    public class OpenStreetMapTileSource : Microsoft.Maps.MapControl.TileSource,IMapProvider
    {
        public OpenStreetMapTileSource()
            : base("http://tile.openstreetmap.org/{2}/{0}/{1}.png")
        {
        }

        public override System.Uri GetUri(int x, int y, int zoomLevel)
        {
            return new Uri(string.Format(this.UriFormat, x, y, zoomLevel));
        }

        #region IMapProvider Members

        public string FileExtn { get { return "png"; } }

        public MapType MapMode{get;set;}

        public Microsoft.Maps.MapControl.TileSource HybridBase
        {
            get { throw new NotImplementedException(); }
        }

        #endregion
    }
}
