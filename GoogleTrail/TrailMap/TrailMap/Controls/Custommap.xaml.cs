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
using TrailMap.Projection;
using System.IO;
using System.Xml.Serialization;
using System.ComponentModel;

namespace TrailMap.Controls
{
    public partial class Custommap : UserControl
    {
        private Map m_map=null;
        private MainPage m_mainPage = null;
        private CustomMap m_customMap = new CustomMap();
        private MapPolygon m_polygon = null;

        public MapPolygon Polygon
        {
            get { return m_polygon; }
        }

        public CustomMap AreaData
        {
            get { return m_customMap; }
            set { m_customMap = value; }
        }
        public Custommap()
        {
            InitializeComponent();
        }

        public void SetMap(Map map, MainPage mainPage)
        {
            this.m_map = map;
            this.m_mainPage = mainPage;
            action = CustomAction.None;

            m_polygon = new MapPolygon();
            m_polygon.Fill = new SolidColorBrush(Colors.Blue);
            m_polygon.Stroke = new SolidColorBrush(Colors.Blue);
            m_polygon.StrokeThickness = 5;
            m_polygon.Opacity = 0.3;
        }

        private CustomAction action;

        public CustomAction Action
        {
            get { return action; }
        }

        private void bttnSelectArea_Click(object sender, RoutedEventArgs e)
        {
            m_map.MousePan -= map_MousePan;
            action = CustomAction.Zoom;
        }

        void map_MousePan(object sender, MapMouseDragEventArgs e)
        {
            e.Handled = true;
        }

        private void bttnSelectZoomLevel_Click(object sender, RoutedEventArgs e)
        {
            this.AreaData.ZoomLevel = m_map.ZoomLevel;
        }

        private void bttnSaveProjectFile_Click(object sender, RoutedEventArgs e)
        {
            MercatorProjection projections = new MercatorProjection();

            List<TrailMap.Projection.Point> allTiles = projections.GetAreaTileList(new LocationRect(this.AreaData.StLocation, this.AreaData.EtLocation), (int)this.AreaData.ZoomLevel, 0);
            List<Url> allUrls = new List<Url>();

            foreach (TrailMap.Projection.Point item in allTiles)
            {
                Url url = new Url();
                url.Src = m_mainPage.CurrentSource.GetUri(item.X, item.Y, (int)this.AreaData.ZoomLevel).AbsoluteUri;
                url.Target = string.Format("Img_{0}_{1}_{2}.{3}", item.X, item.Y, (int)this.AreaData.ZoomLevel, m_mainPage.CurrentSource.FileExtn);

                allUrls.Add(url);
            }

            SaveFileDialog dialog;
            dialog = new SaveFileDialog();
            dialog.DefaultExt = ".mapprj";
            dialog.Filter = "Map Project|*.mapprj";

            if (dialog.ShowDialog() == true)
            {
                using (Stream fs = (Stream)dialog.OpenFile())
                {
                    XmlSerializer ser = new XmlSerializer(typeof(Url[]));

                    ser.Serialize(fs, allUrls.ToArray());

                    //fs.Write(fileBytes, 0, fileBytes.Length);
                    fs.Close();
                    MessageBox.Show("Save Completed");
                }
            }
            
        }

        private void bttnDrawArea_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            action = CustomAction.Area;

            m_map.MousePan += map_MousePan;
        }
    }

    public enum CustomAction
    {
        None,
        Area,
        Zoom
    }

    public class Url
    {
        public string Src { get; set; }
        public string Target { get; set; }
    }

    public class CustomMap
    {
        bool flag = false;

        public bool Flag
        {
            get { return flag; }
            set { flag = value; }
        }
        List<string> fileNames;

        public List<string> FileNames
        {
            get { return fileNames; }
            set { fileNames = value; }
        }
        double zoomLevel;

        public double ZoomLevel
        {
            get { return zoomLevel; }
            set { zoomLevel = value; }
        }
        Location etLocation;

        public Location EtLocation
        {
            get { return etLocation; }
            set { etLocation = value; }
        }
        Location stLocation;

        public Location StLocation
        {
            get { return stLocation; }
            set { stLocation = value; }
        }
    }
}
