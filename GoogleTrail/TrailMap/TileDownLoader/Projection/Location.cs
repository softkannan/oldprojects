using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileDownLoader.Projection
{
    public enum AltitudeReference
    {
        Ground,
        Ellipsoid,
        SeaLevel,
        Surface
    }

    public class Location : IFormattable
    {
        // Fields
        private double altitude;
        private AltitudeReference altitudeReference;
        private double latitude;
        private double longitude;
        public const double MaxLatitude = 90.0;
        public const double MaxLongitude = 180.0;
        public const double MinLatitude = -90.0;
        public const double MinLongitude = -180.0;

        // Methods
        public Location()
            : this(0.0, 0.0, 0.0, AltitudeReference.Ground)
        {
        }

        public Location(Location location)
        {
            this.Latitude = location.latitude;
            this.Longitude = location.Longitude;
            this.Altitude = location.Altitude;
            this.AltitudeReference = location.AltitudeReference;
        }

        public Location(double latitude, double longitude)
            : this(latitude, longitude, 0.0, AltitudeReference.Ground)
        {
        }

        public Location(double latitude, double longitude, double altitude)
            : this(latitude, longitude, altitude, AltitudeReference.Ground)
        {
        }

        public Location(double latitude, double longitude, double altitude, AltitudeReference altitudeReference)
        {
            this.latitude = latitude;
            this.longitude = longitude;
            this.altitude = altitude;
            this.altitudeReference = altitudeReference;
        }

        public override bool Equals(object obj)
        {
            if ((obj == null) || !(obj is Location))
            {
                return false;
            }
            Location location = (Location)obj;
            return (this == location);
        }

        public override int GetHashCode()
        {
            return (((this.Latitude.GetHashCode() ^ this.Longitude.GetHashCode()) ^ this.Altitude.GetHashCode()) ^ this.AltitudeReference.GetHashCode());
        }

        private static bool IsEqual(double value1, double value2)
        {
            return (Math.Abs((double)(value1 - value2)) <= double.Epsilon);
        }

        public static double NormalizeLongitude(double longitude)
        {
            if ((longitude >= -180.0) && (longitude <= 180.0))
            {
                return longitude;
            }
            return (longitude - (Math.Floor((double)((longitude + 180.0) / 360.0)) * 360.0));
        }

        public static bool operator ==(Location location1, Location location2)
        {
            if (object.ReferenceEquals(location1, location2))
            {
                return true;
            }
            if ((location1 == null) || (location2 == null))
            {
                return false;
            }
            return (((IsEqual(location1.Latitude, location2.Latitude) && IsEqual(location1.Longitude, location2.Longitude)) && IsEqual(location1.Altitude, location2.Altitude)) && (location1.AltitudeReference == location2.AltitudeReference));
        }

        public static bool operator !=(Location location1, Location location2)
        {
            return !(location1 == location2);
        }

        string IFormattable.ToString(string format, IFormatProvider provider)
        {
            return string.Format(provider, "{0:" + format + "},{1:" + format + "},{2:" + format + "}", new object[] { this.latitude, this.longitude, this.altitude });
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
        public double Altitude
        {
            get
            {
                return this.altitude;
            }
            set
            {
                this.altitude = value;
            }
        }

        public AltitudeReference AltitudeReference
        {
            get
            {
                return this.altitudeReference;
            }
            set
            {
                this.altitudeReference = value;
            }
        }

        public double Latitude
        {
            get
            {
                return this.latitude;
            }
            set
            {
                this.latitude = value;
            }
        }

        public double Longitude
        {
            get
            {
                return this.longitude;
            }
            set
            {
                this.longitude = value;
            }
        }
    }
}
