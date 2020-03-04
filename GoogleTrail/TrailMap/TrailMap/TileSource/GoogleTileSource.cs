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
using System.IO;
using System.Diagnostics;

namespace TrailMap
{
    public class GoogleTileSource:Microsoft.Maps.MapControl.TileSource,IMapProvider
    {
        #region Constants
        // Google version strings
        public string VersionGoogleMap = "m@141";
        public string VersionGoogleSatellite = "76";
        public string VersionGoogleLabels = "h@141";
        public string VersionGoogleTerrain = "t@126,r@141";
        public string SecGoogleWord = "Galileo";
        public bool CorrectGoogleVersions = true;

        // Google (China) version strings
        public string VersionGoogleMapChina = "m@123";
        public string VersionGoogleSatelliteChina = "s@59";
        public string VersionGoogleLabelsChina = "h@123";
        public string VersionGoogleTerrainChina = "t@108,r@123";

        // Google (Korea) version strings
        public string VersionGoogleMapKorea = "kr1.12";
        public string VersionGoogleSatelliteKorea = "59";
        public string VersionGoogleLabelsKorea = "kr1t.12"; 
        #endregion

        public GoogleTileSource()
            : base("http://mt2.google.com/vt/lyrs=m@107&hl=lt&x=18&y=10&z=5&s=")
        {
        }

        public Microsoft.Maps.MapControl.TileSource HybridBase
        { 
            get
            {
                GoogleTileSource retVal = new GoogleTileSource();
                retVal.MapMode = MapType.Satellite;
                return retVal;
            }
        }

        public string FileExtn
        {
            get { return "jpeg"; }
        }
        public MapType MapMode { get;set;}

        public override Uri GetUri(int x, int y, int zoomLevel)
        {
            try
            {
                switch (this.MapMode)
                {
                    case MapType.Normal:
                        //NormalMap
                        {
                            string server = "mt";
                            string request = "vt";
                            string language = "en";
                            string sec1 = ""; // after &x=...
                            string sec2 = ""; // after &zoom=...
                            GetSecGoogleWords(x, y, out sec1, out sec2);
                            TryCorrectGoogleVersions();

                            //http://mt2.google.com/vt/lyrs=m@107&hl=lt&x=18&y=10&z=5&s=
                            //http://mt0.google.com/vt/lyrs=m@126&hl=en&x=5898&y=3773&z=13&s=Gal
                        

                            string url = string.Format("http://{0}{1}.google.com/{2}/lyrs={3}&hl={4}&x={5}{6}&y={7}&z={8}&s={9}", server, GetServerNum(x, y, 4), request, VersionGoogleMap, language, x, sec1, y, zoomLevel, sec2);

                            return new Uri(url);
                        }
                    case MapType.Satellite:
                        //Satellite
                        {
                            string server = "khm";
                            string request = "kh";
                            string language = "en";
                            string sec1 = ""; // after &x=...
                            string sec2 = ""; // after &zoom=...
                            GetSecGoogleWords(x, y, out sec1, out sec2);
                            TryCorrectGoogleVersions();
                            //http://khm0.google.com/kh/v=61&x=188754&y=120754&z=18&s=
                            string url = string.Format("http://{0}{1}.google.com/{2}/v={3}&hl={4}&x={5}{6}&y={7}&z={8}&s={9}", server, GetServerNum(x, y, 4), request, VersionGoogleSatellite, language, x, sec1, y, zoomLevel, sec2);
                            return new Uri(url);
                        }
                    case MapType.Hybrid:
                        {
                            string language = "en";
                            string server = "mt";
                            string request = "vt";
                            string sec1 = ""; // after &x=...
                            string sec2 = ""; // after &zoom=...
                            GetSecGoogleWords(x,y, out sec1, out sec2);
                            TryCorrectGoogleVersions();

                            // http://mt1.google.com/vt/lyrs=h@107&hl=lt&x=583&y=325&z=10&s=Ga
                            //http://mt0.google.com/vt/lyrs=h@126&hl=en&x=188752&y=120755&z=18&s=Gal

                            string url = string.Format("http://{0}{1}.google.com/{2}/lyrs={3}&hl={4}&x={5}{6}&y={7}&z={8}&s={9}", server, GetServerNum(x,y, 4), request, VersionGoogleLabels, language,x, sec1, y, zoomLevel, sec2);
                            return new Uri(url);
                        }
                    case MapType.Terrain:
                        //Terrain
                        {
                            string server = "mt";
                            string request = "vt";
                            string language = "en";
                            string sec1 = ""; // after &x=...
                            string sec2 = ""; // after &zoom=...
                            GetSecGoogleWords(x, y, out sec1, out sec2);
                            TryCorrectGoogleVersions();

                            //http://mt1.google.com/vt/lyrs=t@125,r@126&hl=en&x=1475&y=943&z=11&s=

                            string url = string.Format("http://{0}{1}.google.com/{2}/v={3}&hl={4}&x={5}{6}&y={7}&z={8}&s={9}", server, GetServerNum(x, y, 4), request, VersionGoogleTerrain, language, x, sec1, y, zoomLevel, sec2);
                            return new Uri(url);
                        }
                }
            }
            catch (Exception ex)
            {
            }
            return null;
        }

        #region Other Helper Methods
        internal void GetSecGoogleWords(int x, int y, out string sec1, out string sec2)
        {
            sec1 = ""; // after &x=...
            sec2 = ""; // after &zoom=...
            int seclen = ((x * 3) + y) % 8;
            sec2 = SecGoogleWord.Substring(0, seclen);
            if (y >= 10000 && y < 100000)
            {
                sec1 = "&s=";
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

        bool isCorrectedGoogleVersions = false;

        /// <summary>
        /// true if google versions was corrected
        /// </summary>
        internal bool IsCorrectedGoogleVersions
        {
            get
            {
                return isCorrectedGoogleVersions;
            }
            set
            {
                isCorrectedGoogleVersions = value;
            }
        } 
        #endregion

        #region Version Correction
        /// <summary>
        /// try to correct google versions
        /// </summary>
        internal void TryCorrectGoogleVersions()
        {
            if (CorrectGoogleVersions && !IsCorrectedGoogleVersions)
            {
                IsCorrectedGoogleVersions = true; // try it only once

                string url = @"http://maps.google.com";
                try
                {
                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);

                    AsyncCallback resPCallBack = delegate(IAsyncResult asynchronousResult)
                    {
                        HttpWebRequest req = (HttpWebRequest)asynchronousResult.AsyncState;

                        using (HttpWebResponse response = (HttpWebResponse)req.EndGetResponse(asynchronousResult))
                        {
                            using (Stream responseStream = response.GetResponseStream())
                            {
                                using (StreamReader read = new StreamReader(responseStream))
                                {
                                    string html = read.ReadToEnd();

                                    // find it  
                                    // apiCallback(["http://mt0.google.com/vt/v\x3dw2.106\x26hl\x3dlt\x26","http://mt1.google.com/vt/v\x3dw2.106\x26hl\x3dlt\x26","http://mt2.google.com/vt/v\x3dw2.106\x26hl\x3dlt\x26","http://mt3.google.com/vt/v\x3dw2.106\x26hl\x3dlt\x26"],
                                    // ["http://khm0.google.com/kh/v\x3d45\x26","http://khm1.google.com/kh/v\x3d45\x26","http://khm2.google.com/kh/v\x3d45\x26","http://khm3.google.com/kh/v\x3d45\x26"],
                                    // ["http://mt0.google.com/vt/v\x3dw2t.106\x26hl\x3dlt\x26","http://mt1.google.com/vt/v\x3dw2t.106\x26hl\x3dlt\x26","http://mt2.google.com/vt/v\x3dw2t.106\x26hl\x3dlt\x26","http://mt3.google.com/vt/v\x3dw2t.106\x26hl\x3dlt\x26"],
                                    // "","","",false,"G",opts,["http://mt0.google.com/vt/v\x3dw2p.106\x26hl\x3dlt\x26","http://mt1.google.com/vt/v\x3dw2p.106\x26hl\x3dlt\x26","http://mt2.google.com/vt/v\x3dw2p.106\x26hl\x3dlt\x26","http://mt3.google.com/vt/v\x3dw2p.106\x26hl\x3dlt\x26"],jslinker,pageArgs);

                                    int id = html.LastIndexOf("apiCallback([");
                                    if (id > 0)
                                    {
                                        int idEnd = html.IndexOf("jslinker,pageArgs", id);
                                        if (idEnd > id)
                                        {
                                            string api = html.Substring(id, idEnd - id);
                                            if (!string.IsNullOrEmpty(api))
                                            {
                                                int i = 0;
                                                string[] opts = api.Split('['); //"[\""
                                                foreach (string opt in opts)
                                                {
                                                    if (opt.Contains("http://"))
                                                    {
                                                        int start = opt.IndexOf("x3d");
                                                        if (start > 0)
                                                        {
                                                            int end = opt.IndexOf("\\x26", start);
                                                            if (end > start)
                                                            {
                                                                start += 3;
                                                                string u = opt.Substring(start, end - start);

                                                                if (i == 0)
                                                                {
                                                                    if (u.StartsWith("m@"))
                                                                    {
                                                                        Debug.WriteLine("TryCorrectGoogleVersions[map]: " + u);
                                                                        VersionGoogleMap = u;
                                                                    }
                                                                    else
                                                                    {
                                                                        Debug.WriteLine("TryCorrectGoogleVersions[map FAILED]: " + u);
                                                                    }
                                                                }
                                                                else
                                                                    if (i == 1)
                                                                    {
                                                                        // 45
                                                                        if (char.IsDigit(u[0]))
                                                                        {
                                                                            Debug.WriteLine("TryCorrectGoogleVersions[satelite]: " + u);
                                                                            VersionGoogleSatellite = u;
                                                                        }
                                                                        else
                                                                        {
                                                                            Debug.WriteLine("TryCorrectGoogleVersions[satelite FAILED]: " + u);
                                                                        }
                                                                    }
                                                                    else
                                                                        if (i == 2)
                                                                        {
                                                                            if (u.StartsWith("h@"))
                                                                            {
                                                                                Debug.WriteLine("TryCorrectGoogleVersions[labels]: " + u);
                                                                                VersionGoogleLabels = u;
                                                                            }
                                                                            else
                                                                            {
                                                                                Debug.WriteLine("TryCorrectGoogleVersions[labels FAILED]: " + u);
                                                                            }
                                                                        }
                                                                        else
                                                                            if (i == 3)
                                                                            {
                                                                                // t@108,r@120
                                                                                if (u.StartsWith("t@"))
                                                                                {
                                                                                    Debug.WriteLine("TryCorrectGoogleVersions[terrain]: " + u);
                                                                                    VersionGoogleTerrain = u;
                                                                                    VersionGoogleTerrainChina = u;
                                                                                }
                                                                                else
                                                                                {
                                                                                    Debug.WriteLine("TryCorrectGoogleVersions[terrain FAILED]: " + u);
                                                                                }
                                                                                break;
                                                                            }
                                                                i++;
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    };

                    // Start the asynchronous request.
                    IAsyncResult result =
                      (IAsyncResult)request.BeginGetResponse(resPCallBack, request);
                }
                catch (Exception ex)
                {
                    Debug.WriteLine("TryCorrectGoogleVersions: " + ex.ToString());
                }
            } 
        #endregion

        }

    } 
}
