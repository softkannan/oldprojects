using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileDownLoader.Projection
{
    public class LocationRect : IFormattable
    {
        // Fields
        private Location center;
        private double halfHeight;
        private double halfWidth;

        // Methods
        public LocationRect()
        {
            this.center = new Location(0.0, 0.0);
        }

        public LocationRect(LocationRect rect)
        {
            this.center = new Location(rect.center);
            this.halfHeight = rect.halfHeight;
            this.halfWidth = rect.halfWidth;
        }

        public LocationRect(IList<Location> locations)
            : this()
        {
            double num = -90.0;
            double num2 = 90.0;
            double num3 = 180.0;
            double num4 = -180.0;
            foreach (Location location in locations)
            {
                num = Math.Max(num, location.Latitude);
                num2 = Math.Min(num2, location.Latitude);
                num3 = Math.Min(num3, location.Longitude);
                num4 = Math.Max(num4, location.Longitude);
            }
            this.Init(num, num3, num2, num4);
        }

        public LocationRect(Location corner1, Location corner2)
            : this(new Location[] { corner1, corner2 })
        {
        }

        public LocationRect(Location center, double width, double height)
        {
            this.center = center;
            this.halfWidth = width / 2.0;
            this.halfHeight = height / 2.0;
        }

        public LocationRect(double north, double west, double south, double east)
            : this()
        {
            this.Init(north, west, south, east);
        }

        public bool Equals(LocationRect value)
        {
            return (this == value);
        }

        public override bool Equals(object obj)
        {
            if ((obj == null) || !(obj is LocationRect))
            {
                return false;
            }
            LocationRect rect = (LocationRect)obj;
            return (this == rect);
        }

        public override int GetHashCode()
        {
            return ((this.center.GetHashCode() ^ this.halfWidth.GetHashCode()) ^ this.halfHeight.GetHashCode());
        }

        private void Init(double north, double west, double south, double east)
        {
            if (west > east)
            {
                east += 360.0;
            }
            this.center = new Location((south + north) / 2.0, (west + east) / 2.0);
            this.halfHeight = (north - south) / 2.0;
            this.halfWidth = Math.Abs((double)(east - west)) / 2.0;
        }

        public LocationRect Intersection(LocationRect rect)
        {
            LocationRect rect2 = new LocationRect();
            if (!this.Intersects(rect))
            {
                return rect2;
            }
            double num = this.center.Longitude - this.halfWidth;
            double num2 = rect.center.Longitude - rect.halfWidth;
            double num3 = this.center.Longitude + this.halfWidth;
            double num4 = rect.center.Longitude + rect.halfWidth;
            if (Math.Abs((double)(this.center.Longitude - rect.center.Longitude)) > 180.0)
            {
                if (this.center.Longitude < rect.center.Longitude)
                {
                    num += 360.0;
                    num3 += 360.0;
                }
                else
                {
                    num2 += 360.0;
                    num4 += 360.0;
                }
            }
            double num5 = Math.Max(num, num2);
            double num6 = Math.Min(num3, num4);
            double num7 = Math.Min(this.North, rect.North);
            double num8 = Math.Max(this.South, rect.South);
            return new LocationRect(new Location((num7 + num8) / 2.0, Location.NormalizeLongitude((num5 + num6) / 2.0)), num6 - num5, num7 - num8);
        }

        public bool Intersects(LocationRect rect)
        {
            double num = Math.Abs((double)(this.center.Latitude - rect.center.Latitude));
            double num2 = Math.Abs((double)(this.center.Longitude - rect.center.Longitude));
            if (num2 > 180.0)
            {
                num2 = 360.0 - num2;
            }
            return ((num <= (this.halfHeight + rect.halfHeight)) && (num2 <= (this.halfWidth + rect.halfWidth)));
        }

        public static bool operator ==(LocationRect rect1, LocationRect rect2)
        {
            if (object.ReferenceEquals(rect1, rect2))
            {
                return true;
            }
            if ((rect1 == null) || (rect2 == null))
            {
                return false;
            }
            return (((rect1.center == rect2.center) && (rect1.halfWidth == rect2.halfWidth)) && (rect1.halfHeight == rect2.halfHeight));
        }

        public static bool operator !=(LocationRect rect1, LocationRect rect2)
        {
            return !(rect1 == rect2);
        }

        string IFormattable.ToString(string format, IFormatProvider provider)
        {
            return string.Format(provider, "{0:" + format + "} {1:" + format + "}", new object[] { this.Northwest, this.Southeast });
        }

        public override string ToString()
        {
            return ((IFormattable)this).ToString(null, null);
        }

        public string ToString(IFormatProvider provider)
        {
            return ((IFormattable)this).ToString(null, provider);
        }

        // Properties
        public Location Center
        {
            get
            {
                return this.center;
            }
        }

        public double East
        {
            get
            {
                if (this.halfWidth != 180.0)
                {
                    return Location.NormalizeLongitude(this.center.Longitude + this.halfWidth);
                }
                return 180.0;
            }
            set
            {
                this.Init(this.North, this.West, this.South, value);
            }
        }

        public double Height
        {
            get
            {
                return (this.halfHeight * 2.0);
            }
        }

        public double North
        {
            get
            {
                return (this.center.Latitude + this.halfHeight);
            }
            set
            {
                this.Init(value, this.West, this.South, this.East);
            }
        }

        public Location Northeast
        {
            get
            {
                return new Location(this.North, this.East);
            }
            set
            {
                if (this.center == null)
                {
                    this.Init(value.Latitude, value.Longitude, value.Latitude, value.Longitude);
                }
                else
                {
                    this.Init(value.Latitude, this.West, this.South, value.Longitude);
                }
            }
        }

        public Location Northwest
        {
            get
            {
                return new Location(this.North, this.West);
            }
        }

        public double South
        {
            get
            {
                return (this.center.Latitude - this.halfHeight);
            }
            set
            {
                this.Init(this.North, this.West, value, this.East);
            }
        }

        public Location Southeast
        {
            get
            {
                return new Location(this.South, this.East);
            }
        }

        public Location Southwest
        {
            get
            {
                return new Location(this.South, this.West);
            }
            set
            {
                if (this.center == null)
                {
                    this.Init(value.Latitude, value.Longitude, value.Latitude, value.Longitude);
                }
                else
                {
                    this.Init(this.North, value.Longitude, value.Latitude, this.East);
                }
            }
        }

        public double West
        {
            get
            {
                if (this.halfWidth != 180.0)
                {
                    return Location.NormalizeLongitude(this.center.Longitude - this.halfWidth);
                }
                return -180.0;
            }
            set
            {
                this.Init(this.North, value, this.South, this.East);
            }
        }

        public double Width
        {
            get
            {
                return (this.halfWidth * 2.0);
            }
        }
    }


}
