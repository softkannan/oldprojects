using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace TileDownLoader.Utils
{

    // helper class to ignore namespaces when de-serializing
    public class NamespaceIgnorantXmlTextReader : XmlTextReader
    {
        public NamespaceIgnorantXmlTextReader(System.IO.TextReader reader) : base(reader) { }

        public override string NamespaceURI
        {
            get { return ""; }
        }
    }

    // helper class to omit XML decl at start of document when serializing
    public class XTWFND : XmlTextWriter
    {
        public XTWFND(System.IO.TextWriter w) : base(w) { Formatting = System.Xml.Formatting.Indented; }
        public override void WriteStartDocument() { }
    }

    public static class MapUtil
    {
        public static TSource GetElement<TSource>(this IEnumerable<TSource> source, int position)
        {
            int count = 0;
            foreach (TSource item in source)
            {
                if (count == position)
                {
                    return item;
                }
                count++;
            }
            throw new InvalidOperationException();
        }

        public static TSource GetData<TSource>(this List<TSource> source, string row, string column) where TSource : ImageInfo
        {
            return (from item in source where item.Row == row && item.Column == column select item).First<TSource>();
        }
    }
}
