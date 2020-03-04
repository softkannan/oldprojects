using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileDownLoader.Utils
{
    public class ImageInfo
    {
        public ImageInfo(string filePath, string row, string column, string zoom)
        {
            this.Path = filePath;
            this.Row = row;
            this.Column = column;
            this.Zoom = zoom;
        }

        public string Path { get; private set; }
        public string Row { get; private set; }
        public string Column { get; private set; }
        public string Zoom { get; private set; }
    }
}
