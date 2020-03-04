using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using Microsoft.Maps.MapControl;
using Microsoft.Maps.MapControl.Core;
using Microsoft.Maps.MapControl.Navigation;
using TrailMap.TileSource;
using TrailMap.Controls;
using TrailMap.Utils;

namespace TrailMap
{
    public partial class MainPage : UserControl
    {
        List<OverlayItem> overlays = new List<OverlayItem>();

        ComboBox mapSource = new ComboBox();
        private CommandRadioButton bttnNormal = new CommandRadioButton();
        private CommandRadioButton bttnSatellite = new CommandRadioButton();
        private CommandRadioButton bttnHybrid = new CommandRadioButton();
        private CommandRadioButton bttnTerrain = new CommandRadioButton();
        MapTileLayer tileLayer = new MapTileLayer();

        TileSourceProvider sourceProvider = new TileSourceProvider();

        MapType mapType = MapType.Normal;
        IMapProvider currentSource;

        private MapTool m_currentTool = MapTool.View;

        #region ctor

        void MapForeground_TemplateApplied(object sender, EventArgs e)
        {
            map.MapForeground.NavigationBar.TemplateApplied += NavigationBar_TemplateApplied;
        }

        void NavigationBar_TemplateApplied(object sender, EventArgs e)
        {
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Clear();

            map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(mapSource);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
        }

        public MainPage()
        {
            InitializeComponent();

            bttnNormal.Content = "Normal";
            bttnNormal.Click += bttnNormal_Click;
            bttnNormal.IsChecked = true;
            bttnSatellite.Content = "Satellite";
            bttnSatellite.Click += bttnSatellite_Click;
            bttnHybrid.Content = "Hybrid";
            bttnHybrid.Click += bttnHybrid_Click;
            bttnTerrain.Content = "Terrain";
            bttnTerrain.Click += bttnTerrain_Click;

            mapSource.Items.Add("Bing");
            mapSource.Items.Add("Google");
            mapSource.Items.Add("Yahoo");
            mapSource.Items.Add("CloudMade");
            mapSource.Items.Add("OpenStreet");
            mapSource.Items.Add("MapMyIndia");
            mapSource.Items.Add("BingAsOverlay");
            mapSource.SelectedIndex = 0;

            comboOverlay.Items.Add("Google");
            comboOverlay.Items.Add("Yahoo");
            comboOverlay.Items.Add("CloudMade");
            comboOverlay.Items.Add("OpenStreet");
            comboOverlay.Items.Add("MapMyIndia");
            comboOverlay.Items.Add("BingAsOverlay");
            comboOverlay.SelectedIndex = -1;

            comboToolMode.SelectedIndex = 0;

            listOfOverlays.ItemsSource = null;

            mapSource.SelectionChanged += mapSource_SelectionChanged;

            map.MapForeground.TemplateApplied += MapForeground_TemplateApplied;
            map.MouseLeftButtonDown += new MouseButtonEventHandler(map_MouseLeftButtonDown);
            map.MouseMove += new MouseEventHandler(map_MouseMove);
            map.MouseLeftButtonUp += new MouseButtonEventHandler(map_MouseLeftButtonUp);

        } 
        #endregion

        #region Properties
        public IMapProvider CurrentSource
        {
            get
            {
                if (currentSource == null)
                {
                    IMapProvider retVal = this.SourceProvider.BingTileSource;
                    retVal.MapMode = mapType;
                    return retVal;
                }
                return currentSource;
            }
        }
        public MapTool CurrentTool
        {
            get { return m_currentTool; }
        }

        public TileSourceProvider SourceProvider
        {
            get { return sourceProvider; }
        } 
        #endregion
        
        #region Mouse Handling
        void map_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            if (this.CurrentTool == MapTool.CaptureTiles &&
                customMapArea.Action == CustomAction.Area)
            {
                customMapArea.AreaData.Flag = false;
                customMapArea.AreaData.EtLocation = map.ViewportPointToLocation(e.GetPosition(map));

                DrawRect(customMapArea.AreaData.StLocation, customMapArea.AreaData.EtLocation);
            }
        }

        void map_MouseMove(object sender, MouseEventArgs e)
        {
            if (this.CurrentTool == MapTool.CaptureTiles &&
                customMapArea.Action == CustomAction.Area &&
                customMapArea.AreaData.Flag)
            {
                customMapArea.AreaData.EtLocation = map.ViewportPointToLocation(e.GetPosition(map));

                DrawRect(customMapArea.AreaData.StLocation, customMapArea.AreaData.EtLocation);
            }
        }

        void map_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            if (this.CurrentTool == MapTool.CaptureTiles &&
                customMapArea.Action == CustomAction.Area)
            {
                customMapArea.AreaData.StLocation = map.ViewportPointToLocation(e.GetPosition(map));
                customMapArea.AreaData.Flag = true;
            }
        } 
        #endregion

        #region MapType Buttons Handler
        void bttnTerrain_Click(object sender, RoutedEventArgs e)
        {
            mapType = MapType.Terrain;
            UpdateMapType();
        }

        void bttnHybrid_Click(object sender, RoutedEventArgs e)
        {
            mapType = MapType.Hybrid;
            UpdateMapType();
        }

        void bttnSatellite_Click(object sender, RoutedEventArgs e)
        {
            mapType = MapType.Satellite;
            UpdateMapType();
        }

        void bttnNormal_Click(object sender, RoutedEventArgs e)
        {
            mapType = MapType.Normal;
            UpdateMapType();
        } 
        #endregion

        #region Map Source and Tool Selection Handling
        void mapSource_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            MaporOverlayChanged();
        }
        private void comboToolMode_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {

            m_currentTool = (MapTool)comboToolMode.SelectedIndex;

            UpdateTool();
        } 
        #endregion

        #region Utility Methods
        private void UpdateMapType()
        {
            bttnNormal.IsChecked = false;
            bttnSatellite.IsChecked = false;
            bttnHybrid.IsChecked = false;
            bttnTerrain.IsChecked = false;

            map.Children.Clear();

            map.Children.Add(tileLayer);

            tileLayer.Visibility = System.Windows.Visibility.Collapsed;

            if (currentSource != null)
            {
                tileLayer.TileSources.Clear();
            }

            #region Main Map Source Management
            switch (mapType)
            {
                case MapType.Normal:
                    bttnNormal.IsChecked = true;
                    if (currentSource != null)
                    {
                        currentSource.MapMode = mapType;
                    }
                    else
                    {
                        map.Mode = new RoadMode();
                    }
                    break;
                case MapType.Hybrid:
                    bttnHybrid.IsChecked = true;
                    if (currentSource != null)
                    {
                        currentSource.MapMode = mapType;
                        tileLayer.TileSources.Add(currentSource.HybridBase);
                    }
                    else
                    {
                        AerialMode aerialMode = new AerialMode();
                        aerialMode.Labels = true;
                        map.Mode = aerialMode;
                    }
                    break;
                case MapType.Satellite:
                    bttnSatellite.IsChecked = true;
                    if (currentSource != null)
                    {
                        currentSource.MapMode = mapType;
                    }
                    else
                    {
                        AerialMode aerialMode = new AerialMode();
                        aerialMode.Labels = false;
                        map.Mode = aerialMode;
                    }
                    break;
                case MapType.Terrain:
                    bttnTerrain.IsChecked = true;
                    if (currentSource != null)
                    {
                        currentSource.MapMode = mapType;
                    }
                    else
                    {
                        map.Mode = new RoadMode();
                    }
                    break;
            }
            #endregion

            if (currentSource != null)
            {
                tileLayer.TileSources.Add(currentSource as Microsoft.Maps.MapControl.TileSource);
                tileLayer.Visibility = System.Windows.Visibility.Visible;
            }

            foreach (OverlayItem item in overlays)
            {
                MapTileLayer layer = item.Provider;
                map.Children.Add(layer);
                layer.Visibility = System.Windows.Visibility.Visible;
            }
        }

        private void DrawRect(Location stLoc, Location etLoc)
        {
            map.Children.Remove(customMapArea.Polygon);

            LocationRect rect = new LocationRect(stLoc, etLoc);

            customMapArea.Polygon.Locations = new LocationCollection() { rect.Northwest, rect.Northeast, rect.Southeast, rect.Southwest };

            map.Children.Add(customMapArea.Polygon);
        }

        private void UpdateTool()
        {
            // TODO: Add event handler implementation here.
            customMapArea.Visibility = System.Windows.Visibility.Collapsed;

            switch (this.CurrentTool)
            {
                case MapTool.CaptureTiles:
                    customMapArea.SetMap(map, this);
                    customMapArea.Visibility = System.Windows.Visibility.Visible;
                    break;
            }
        } 
        #endregion

        #region Overlay Management
        private void MaporOverlayChanged()
        {
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Remove(bttnNormal);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Remove(bttnSatellite);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Remove(bttnHybrid);
            map.MapForeground.NavigationBar.HorizontalPanel.Children.Remove(bttnTerrain);
            tileLayer.Visibility = System.Windows.Visibility.Collapsed;
            currentSource = null;

            switch (mapSource.SelectedIndex)
            {
                case 1:
                    currentSource = this.SourceProvider.GoogleSource;
                    map.Mode = new MercatorMode();

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnTerrain);
                    break;
                case 2:
                    currentSource = this.SourceProvider.YahooSource;
                    map.Mode = new MercatorMode();

                    if (mapType == MapType.Terrain)
                    {
                        mapType = MapType.Normal;
                    }

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    break;
                case 3:
                    currentSource = this.SourceProvider.CmSource;
                    map.Mode = new MercatorMode();

                    if (mapType == MapType.Satellite || mapType == MapType.Hybrid)
                    {
                        mapType = MapType.Normal;
                    }

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnTerrain);
                    break;
                case 4:
                    currentSource = this.SourceProvider.OpenStreetMapTileSource;
                    map.Mode = new MercatorMode();

                    if (mapType == MapType.Satellite || mapType == MapType.Hybrid || mapType == MapType.Terrain)
                    {
                        mapType = MapType.Normal;
                    }

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnTerrain);
                    break;
                case 5:
                    currentSource = this.SourceProvider.MapMyIndiaTileSource;
                    map.Mode = new MercatorMode();

                    if (mapType == MapType.Satellite || mapType == MapType.Hybrid || mapType == MapType.Terrain)
                    {
                        mapType = MapType.Normal;
                    }
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    //map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnTerrain);
                    break;
                case 6:
                    currentSource = this.SourceProvider.BingTileSource;
                    map.Mode = new MercatorMode();
                    if (mapType == MapType.Terrain)
                    {
                        mapType = MapType.Normal;
                    }

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    break;
                default:
                    tileLayer.Visibility = System.Windows.Visibility.Collapsed;
                    tileLayer.TileSources.Clear();
                    if (mapType == MapType.Terrain)
                    {
                        mapType = MapType.Normal;
                    }

                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnNormal);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnSatellite);
                    map.MapForeground.NavigationBar.HorizontalPanel.Children.Add(bttnHybrid);
                    break;
            }

            UpdateMapType();
        }



        private void bttnAdd_Click(object sender, RoutedEventArgs e)
        {
            string selectedItem = comboOverlay.SelectedItem as string;
            if (!string.IsNullOrWhiteSpace(selectedItem))
            {
                var query = from item in overlays where item.DisplayName == selectedItem select item;

                if (query.Count() == 0)
                {
                    overlays.Add(new OverlayItem(selectedItem, 50, comboOverlay.SelectedIndex + 1, MapType.Normal));
                    listOfOverlays.ItemsSource = null;
                    listOfOverlays.ItemsSource = overlays;
                    UpdateMapType();
                }
            }
        }
        public string[] Buttons
        {
            get
            {
                return new string[] { "N", "S", "H", "T" };
            }
        }
        public List<OverlayItem> Overlays
        {
            get { return overlays; }
        }

        private void bttnRemove_Click(object sender, RoutedEventArgs e)
        {
            OverlayItem selectedItem = listOfOverlays.SelectedItem as OverlayItem;
            if (selectedItem != null)
            {
                overlays.Remove(selectedItem);
                listOfOverlays.ItemsSource = null;
                listOfOverlays.ItemsSource = overlays;
                UpdateMapType();
            }
        } 
        #endregion
       
    }
}
