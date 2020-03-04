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
using System.Windows.Browser;
using Microsoft.Maps.MapControl;

namespace TrailMap
{
    public class BmTileSource : Microsoft.Maps.MapControl.TileSource
    {
        private const string TilePathBlueMarbleWeb = @"http://s3.amazonaws.com/com.modestmaps.bluemarble/{0}-r{2}-c{1}.jpg";

        //Constructor Called by XAML instanciation; Wait for MapMode to be set to initialize services
        public BmTileSource()
            : base()
        {
        }

        public override Uri GetUri(int x, int y, int zoomLevel)
        {
            return new Uri(string.Format(TilePathBlueMarbleWeb, zoomLevel, x, y));
        }
    }
}
