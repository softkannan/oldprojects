﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using BruTile;
using BruTile.Cache;
using BruTile.Samples.Common;

namespace MapNavigator
{
    class Renderer
    {
        private readonly Canvas _canvas;

        public Renderer(Canvas canvas)
        {
            _canvas = canvas;
        }

        public void Render(Viewport viewport, ITileSource tileSource, ITileCache<Tile<Image>> tileCache)
        {
            _canvas.Children.Clear();

            var level = Utilities.GetNearestLevel(tileSource.Schema.Resolutions, viewport.UnitsPerPixel);
            var tileInfos = tileSource.Schema.GetTileInfos(viewport.Extent, level);
            foreach (var tileInfo in tileInfos)
            {
                var tile = tileCache.Find(tileInfo.Index);
                if (tile != null)
                {
                    _canvas.Children.Add(tile.Image);
                    PositionImage(tile.Image, tileInfo.Extent, viewport);
                }
            }
        }

        public static void PositionImage(Image image, Extent extent, Viewport viewport)
        {
            var min = viewport.WorldToScreen(extent.MinX, extent.MinY);
            var max = viewport.WorldToScreen(extent.MaxX, extent.MaxY);

            Canvas.SetLeft(image, min.X);
            Canvas.SetTop(image, max.Y);
            image.Width = max.X - min.X;
            image.Height = min.Y - max.Y;
        }

        public static Rect RoundToPixel(Rect dest)
        {
            // To get seamless aligning you need to round the 
            // corner coordinates to pixel.
            dest = new Rect(
                Math.Round(dest.Left),
                Math.Round(dest.Top),
                (Math.Round(dest.Right) - Math.Round(dest.Left)),
                (Math.Round(dest.Bottom) - Math.Round(dest.Top)));
            return dest;
        }

    }
}
