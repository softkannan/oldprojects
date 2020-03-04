using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Windows.Forms;
using System.IO;
using System.Xml.Serialization;
using System.Net;
using System.ComponentModel;
using System.Threading;
using Wintellect.PowerCollections;
using System.Text.RegularExpressions;
using TileDownLoader.Utils;
using TileDownLoader.Kml;

namespace TileDownLoader
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private BackgroundWorker m_downloadWorker = null;
        private BackgroundWorker m_kmlWorker = null;

        public BackgroundWorker KmlWorker
        {
            get { return m_kmlWorker; }
        }

        public BackgroundWorker DownloadWorker
        {
            get { return m_downloadWorker; }
        }
        public MainWindow()
        {
            InitializeComponent();
        }

        private void bttnBrowse_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog fileDialog = new OpenFileDialog();
            fileDialog.DefaultExt = ".mapprj";
            fileDialog.Filter = "Map Project|*.mapprj";

            if (fileDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtMapPrjpath.Text = fileDialog.FileName;
            }
        }

        private void bttnBrowseFolder_Click(object sender, RoutedEventArgs e)
        {
            FolderBrowserDialog browseDialog = new FolderBrowserDialog();
            browseDialog.RootFolder = Environment.SpecialFolder.MyDocuments;
            if (browseDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtOutputFolder.Text = browseDialog.SelectedPath;
                txtInputFolder.Text = browseDialog.SelectedPath;
            }
        }

        private void bttnBrowseInputfolder_Click(object sender, RoutedEventArgs e)
        {
            FolderBrowserDialog browseDialog = new FolderBrowserDialog();
            browseDialog.RootFolder = Environment.SpecialFolder.MyDocuments;
            if (browseDialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                txtInputFolder.Text = browseDialog.SelectedPath;
            }
        }

        private string UserAgent = "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.7) Gecko/20091221 Firefox/3.5.7";
        /// <summary>
        /// timeout for map connections
        /// </summary>
        private int Timeout = 30 * 1000;

        private void bttnDownloadTiles_Click(object sender, RoutedEventArgs e)
        {
            if ((!string.IsNullOrWhiteSpace(txtMapPrjpath.Text)) && File.Exists(txtMapPrjpath.Text) &&
               (!string.IsNullOrWhiteSpace(txtOutputFolder.Text)) && Directory.Exists(txtOutputFolder.Text))
            {
                Url[] allImages;

                using (FileStream fs = File.Open(txtMapPrjpath.Text, FileMode.Open, FileAccess.Read))
                {
                    XmlSerializer ser = new XmlSerializer(typeof(Url[]));

                    allImages = ser.Deserialize(fs) as Url[];
                }

                m_downloadWorker = new BackgroundWorker();

                m_downloadWorker.DoWork += new DoWorkEventHandler(worker_DoWork);

                m_downloadWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(worker_RunWorkerCompleted);
                m_downloadWorker.ProgressChanged += new ProgressChangedEventHandler(worker_ProgressChanged);

                m_downloadWorker.WorkerReportsProgress = true;
                m_downloadWorker.WorkerSupportsCancellation = true;
                m_downloadWorker.RunWorkerAsync(new RunWorkArg(allImages, txtOutputFolder.Text));
            }
            else
            {
                System.Windows.MessageBox.Show("Please select proper map project file and output folder");
            }

        }

        enum Action
        {
            Success,
            Canceled,
            Error
        }

        class RunWorkArg
        {
            private Url[] allImages;

            public Url[] AllImages
            {
                get { return allImages; }
            }
           
            private string outputFolder;

            public string OutputFolder
            {
                get { return outputFolder; }
            }
            public RunWorkArg(Url[] allImages, string outputfolder)
            {
                this.allImages = allImages;
                this.outputFolder = outputfolder;
            }

            private Action action = Action.Success;

            public Action Action
            {
                get { return action; }
                set { action = value; }
            }

            private Exception error = null;

            public Exception Error
            {
                get { return error; }
                set { error = value; }
            }

        }

        void worker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            downProgress.Value = e.ProgressPercentage;
        }

        void worker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            RunWorkArg arg = e.Result as RunWorkArg;

            if (arg.Action == Action.Success)
            {
                System.Windows.MessageBox.Show("Tiles are downloaded.");
            }
            else if (arg.Action == Action.Canceled)
            {
                System.Windows.MessageBox.Show("User Cancel Completed.");
            }
            else
            {
                if (e.Error != null)
                {
                    System.Windows.MessageBox.Show(String.Format("Error:{0}.", e.Error.Message));

                }
                else
                {
                    if (e.Result != null && e.Result is RunWorkArg)
                    {
                        RunWorkArg err = e.Result as RunWorkArg;

                        if (err.Error != null)
                        {
                            System.Windows.MessageBox.Show(String.Format("Error:{0}.", err.Error.Message));
                        }
                        else
                        {
                            System.Windows.MessageBox.Show("Unknown error occured");
                        }
                    }
                    else
                    {
                        System.Windows.MessageBox.Show("Unknown error occured");
                    }
                }
            }
        }

        void worker_DoWork(object sender, DoWorkEventArgs e)
        {
            RunWorkArg arg = e.Argument as RunWorkArg;

            try
            {
                int index = 0;
                foreach (Url item in arg.AllImages)
                {
                    Thread.Sleep(100);

                    if (this.DownloadWorker.CancellationPending)
                    {
                        arg.Action = Action.Canceled;
                        break;
                    }

                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(item.Src);

                    request.UserAgent = UserAgent;
                    request.Timeout = Timeout;
                    request.ReadWriteTimeout = Timeout * 6;
                    request.Accept = "*/*";

                    using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
                    {
                        using (Stream responseStream = response.GetResponseStream())
                        {
                            using (FileStream writer = File.OpenWrite(String.Format("{0}\\{1}", arg.OutputFolder, item.Target)))
                            {
                                responseStream.CopyTo(writer);
                            }
                        }
                    }

                    index++;

                    m_downloadWorker.ReportProgress((int)(((double)index / (double)arg.AllImages.Length) * 100.0));
                }

                if (this.KmlWorker != null)
                {
                    this.KmlWorker.ReportProgress(100);
                }
            }
            catch (Exception ex)
            {
                arg.Action = Action.Error;
                arg.Error = ex;
            }
            
            e.Result = arg;
        }

        private void bttnCancel_Click(object sender, RoutedEventArgs e)
        {
            this.DownloadWorker.CancelAsync();
            
        }
        class KmlThreadArg
        {
            private string selectedPath;

            public string SelectedPath
            {
                get { return selectedPath; }
               
            }
            private string kmlName;

            public string KmlName
            {
                get { return kmlName; }
            }
            public KmlThreadArg(string selectedPath, string kmlName)
            {
                this.selectedPath = selectedPath;
                this.kmlName = kmlName;
            }
        }

        private void bttnGenerateKml_Click(object sender, RoutedEventArgs e)
        {
            if ((!string.IsNullOrWhiteSpace(txtKMLName.Text)) &&
               (!string.IsNullOrWhiteSpace(txtInputFolder.Text)) && Directory.Exists(txtInputFolder.Text))
            {
                m_kmlWorker = new BackgroundWorker();

                m_kmlWorker.WorkerReportsProgress = true;
                m_kmlWorker.WorkerSupportsCancellation = true;

                m_kmlWorker.DoWork += new DoWorkEventHandler(m_kmlWorker_DoWork);
                m_kmlWorker.ProgressChanged += new ProgressChangedEventHandler(m_kmlWorker_ProgressChanged);
                m_kmlWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(m_kmlWorker_RunWorkerCompleted);
                m_kmlWorker.RunWorkerAsync(new KmlThreadArg(txtInputFolder.Text, txtKMLName.Text));
            }
            else
            {
                System.Windows.MessageBox.Show("please enter valid kml name and tiles folder.");
            }
        }

        void m_kmlWorker_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            if (e.Cancelled)
            {
                System.Windows.MessageBox.Show("User cancel completed.");
            }
            else if (e.Error != null)
            {
                System.Windows.MessageBox.Show(String.Format("Error:{0}.", e.Error.Message));
            }
            else
            {
                if ((bool)e.Result == true)
                {
                    System.Windows.MessageBox.Show("Kml Generation Completed Successfully.");
                }
                else
                {
                    System.Windows.MessageBox.Show("Kml Generation failed.");
                }
            }
        }

        void m_kmlWorker_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            progressKml.Value = e.ProgressPercentage;
        }

        void m_kmlWorker_DoWork(object sender, DoWorkEventArgs e)
        {
            KmlThreadArg arg = e.Argument as KmlThreadArg;
            e.Result = false;

            MultiDictionary<string, ImageInfo> filesGrouped4x4 = new MultiDictionary<string, ImageInfo>(false);

            {
                List<ImageInfo> allFiles = new List<ImageInfo>();
                List<string> rows = new List<string>();
                List<string> columns = new List<string>();

                Regex filePattern = new Regex(@"Img_(?<Row>\d+)_(?<Column>\d+)_(?<Zoom>\d+)\.*", RegexOptions.Compiled | RegexOptions.CultureInvariant | RegexOptions.Singleline);

                foreach (string item in Directory.GetFiles(arg.SelectedPath, "*.*", SearchOption.TopDirectoryOnly))
                {
                    Match match = filePattern.Match(item);
                    if (match.Success)
                    {
                        string row = match.Groups["Row"].Value;
                        string column = match.Groups["Column"].Value;

                        allFiles.Add(new ImageInfo(item, row, column, match.Groups["Zoom"].Value));

                        if (!rows.Contains(row))
                        {
                            rows.Add(row);
                        }

                        if (!columns.Contains(column))
                        {
                            columns.Add(column);
                        }
                    }
                }

                rows.Sort();
                columns.Sort();

                int totalRowRun = 0;
                int totalColumnRun = 0;

                if (rows.Count > 0)
                {
                    totalRowRun = (int)rows.Count / 4;
                    if (rows.Count % 4 > 0)
                    {
                        totalRowRun++;
                    }
                }

                if (columns.Count > 0)
                {

                    totalColumnRun = (int)columns.Count / 4;
                    if (columns.Count % 4 > 0)
                    {
                        totalColumnRun++;
                    }
                }

                string rowKey;
                string columnKey;

                string _4x4Key;

                for (int indexRow = 0; indexRow < totalRowRun; indexRow++)
                {
                    int actualStartRow = indexRow * 4;
                    string rowStartKey = rows[actualStartRow];

                    for (int indexX = actualStartRow; indexX < rows.Count && indexX < actualStartRow + 4; indexX++)
                    {
                        rowKey = rows[indexX];

                        for (int indexColumn = 0; indexColumn < totalColumnRun; indexColumn++)
                        {
                            int actualStartColumn = indexColumn * 4;
                            string startColumnKey = columns[actualStartColumn];
                            _4x4Key = String.Format("{0}x{1}", rowStartKey, startColumnKey);


                            for (int indexY = actualStartColumn; indexY < columns.Count && indexY < actualStartColumn + 4; indexY++)
                            {
                                columnKey = columns[indexY];
                                ImageInfo data = allFiles.GetData<ImageInfo>(rowKey, columnKey);

                                filesGrouped4x4.Add(_4x4Key, data);
                            }
                        }
                    }
                }
            }
            {
                string kmlFolder = String.Format("{0}\\{1}\\", arg.SelectedPath, arg.KmlName);

                if (Directory.Exists(kmlFolder))
                {
                    System.Windows.MessageBox.Show("Folder already exits, select diffrent folder");
                    return;
                }

                Directory.CreateDirectory(kmlFolder);

                ImageInfo imageInfo;

                TileDownLoader.Projection.MercatorProjection projections = new TileDownLoader.Projection.MercatorProjection();

                List<GroundOverlayType> overlays = new List<GroundOverlayType>();
                int index = 0;
                foreach (string imgkey in filesGrouped4x4.Keys)
                {
                    if (this.KmlWorker.CancellationPending)
                    {
                        return;
                    }

                    this.KmlWorker.ReportProgress((int)(((double)index / (double)filesGrouped4x4.Keys.Count) * 100.0));

                    imageInfo = filesGrouped4x4[imgkey].First<ImageInfo>();

                    string fileName = String.Format("{0}\\Img_{1}_{2}_{3}.jpeg", kmlFolder, imageInfo.Row, imageInfo.Column, imageInfo.Zoom);

                    MultiDictionary<string, ImageInfo> tempData = new MultiDictionary<string, ImageInfo>(false);

                    foreach (ImageInfo item in filesGrouped4x4[imgkey])
                    {
                        tempData.Add(item.Row, item);
                    }

                    int rowCount = tempData.Keys.Count;
                    int columnCount = tempData[tempData.Keys.First<string>()].Count;
                    int imageWidth = rowCount * 256;
                    int imageHeight = columnCount * 256;

                    TileDownLoader.Projection.Point imgPt = new TileDownLoader.Projection.Point(int.Parse(imageInfo.Row), int.Parse(imageInfo.Column));

                    TileDownLoader.Projection.Point imgXYInVirtualSingleImageStPoint = projections.FromTileXYToPixel(imgPt);

                    TileDownLoader.Projection.Point imgXYInVirtualSingleImageEtPoint = new TileDownLoader.Projection.Point(imgXYInVirtualSingleImageStPoint.X + imageWidth,
                        imgXYInVirtualSingleImageStPoint.Y + imageHeight);

                    TileDownLoader.Projection.Location latlng1 = projections.FromPixelToLatLng(imgXYInVirtualSingleImageStPoint, int.Parse(imageInfo.Zoom));
                    TileDownLoader.Projection.Location latlng2 = projections.FromPixelToLatLng(imgXYInVirtualSingleImageEtPoint, int.Parse(imageInfo.Zoom));


                    GroundOverlayType gndOverlay = new GroundOverlayType();

                    gndOverlay.LatLonBox = new LatLonBoxType();

                    gndOverlay.LatLonBox.north = latlng1.Latitude;
                    gndOverlay.LatLonBox.south = latlng2.Latitude;
                    gndOverlay.LatLonBox.east = latlng2.Longitude;
                    gndOverlay.LatLonBox.west = latlng1.Longitude;

                    gndOverlay.name = System.IO.Path.GetFileNameWithoutExtension(fileName);
                    gndOverlay.color = new byte[] { 0xff, 0xff, 0xff, 0xff };
                    gndOverlay.Icon = new LinkType();
                    gndOverlay.Icon.href = System.IO.Path.GetFileName(fileName);
                  
                    System.Drawing.Bitmap stichedBmp = new System.Drawing.Bitmap(imageWidth, imageHeight);

                    System.Drawing.Graphics grp = System.Drawing.Graphics.FromImage(stichedBmp);
                    int rowLoop = 0;
                    int columnLoop = 0;
                    List<string> keysTemp = new List<string>(tempData.Keys);
                    keysTemp.Sort();
                    foreach (string key in keysTemp)
                    {
                        int x = rowLoop * 256;
                        columnLoop = 0;
                        foreach (ImageInfo imgData in tempData[key])
                        {
                            int y = columnLoop * 256;

                            grp.DrawImage(new System.Drawing.Bitmap(imgData.Path), new System.Drawing.Point(x, y));
                            columnLoop++;
                        }
                        rowLoop++;
                    }

                    grp.Dispose();

                    // EncoderParameter object in the array.

                    System.Drawing.Imaging.ImageCodecInfo myImageCodecInfo = GetEncoderInfo("image/jpeg");

                    System.Drawing.Imaging.EncoderParameters myEncoderParameters = new System.Drawing.Imaging.EncoderParameters(1);

                    System.Drawing.Imaging.EncoderParameter myEncoderParameter = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 100L);
                    myEncoderParameters.Param[0] = myEncoderParameter;

                    stichedBmp.Save(fileName, myImageCodecInfo, myEncoderParameters);

                    stichedBmp.Dispose();

                    overlays.Add(gndOverlay);

                    index++;
                }

                List<List<GroundOverlayType>> splitedOverlays = new List<List<GroundOverlayType>>();

                for (int localIndex = 0; localIndex < overlays.Count; localIndex+=100)
                {
                    int lastData = (localIndex + 100) < overlays.Count ? localIndex + 100 : overlays.Count;

                    List<GroundOverlayType> tempOverlays = new List<GroundOverlayType>();

                    for (int subIndex = localIndex; subIndex < lastData; subIndex++)
                    {
                        tempOverlays.Add(overlays[subIndex]);
                    }

                    splitedOverlays.Add(tempOverlays);
                }

                int fileCount = 1;

                foreach (List<GroundOverlayType> item in splitedOverlays)
                {
                    GenerateKmlFile(arg, kmlFolder, item, fileCount);
                    fileCount++;
                }

            }

            this.KmlWorker.ReportProgress(100);

            e.Result = true;
        }

        private static void GenerateKmlFile(KmlThreadArg arg, string kmlFolder, List<GroundOverlayType> fileOverlays,int kmlfileCount)
        {
            FolderType folder = new FolderType();

            folder.name = String.Format("{0}_{1}", arg.KmlName, kmlfileCount);

            folder.Items1 = fileOverlays.ToArray();

            KmlType kml = new KmlType();

            kml.Item = folder;

            string fileNameKmz = String.Format("{0}\\{1}{2}.kml", kmlFolder, arg.KmlName, kmlfileCount);

            using (FileStream fs = File.Create(fileNameKmz))
            {
                XmlSerializer ser = new XmlSerializer(typeof(KmlType));

                ser.Serialize(fs, kml);
            }
        }

         private static System.Drawing.Imaging.ImageCodecInfo GetEncoderInfo(String mimeType)
        {
            int j;
            System.Drawing.Imaging.ImageCodecInfo[] encoders;
            encoders = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders();
            for (j = 0; j < encoders.Length; ++j)
            {
                if (encoders[j].MimeType == mimeType)
                    return encoders[j];
            }
            return null;
        }

        private void bttnCancelKML_Click(object sender, RoutedEventArgs e)
        {
            this.KmlWorker.CancelAsync();
        }
    }

    [Serializable]
    public class Url
    {
        public string Src { get; set; }
        public string Target { get; set; }
    }
}
