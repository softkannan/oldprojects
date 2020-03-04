using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.IO;

namespace TrailMapLauncher
{
    class Program
    {
        static void Main(string[] args)
        {
            Process proc = new Process();

            proc.StartInfo.FileName = "mongoose.exe";

            proc.Start();

            Process procPage = new Process();

            procPage.StartInfo.FileName = "http://localhost:8080/Trailmap.html";

            procPage.Start();
        }
    }
}
