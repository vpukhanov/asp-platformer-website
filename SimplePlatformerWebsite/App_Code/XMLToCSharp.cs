using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

/// <summary>
/// Summary description for XMLToCSharp
/// </summary>
namespace XMLToCSharp
{
    [XmlRoot(ElementName = "Block")]
    public class Block
    {
        [XmlAttribute(AttributeName = "Type")]
        public string Type { get; set; }
        [XmlAttribute(AttributeName = "X")]
        public int X { get; set; }
        [XmlAttribute(AttributeName = "Y")]
        public int Y { get; set; }
    }

    [XmlRoot(ElementName = "Player")]
    public class Player
    {
        [XmlAttribute(AttributeName = "X")]
        public int X { get; set; }
        [XmlAttribute(AttributeName = "Y")]
        public int Y { get; set; }
    }

    [XmlRoot(ElementName = "Exit")]
    public class Exit
    {
        [XmlAttribute(AttributeName = "X")]
        public int X { get; set; }
        [XmlAttribute(AttributeName = "Y")]
        public int Y { get; set; }
    }

    [XmlRoot(ElementName = "Level")]
    public class Level
    {
        [XmlElement(ElementName = "Block")]
        public List<Block> Blocks { get; set; }
        [XmlElement(ElementName = "Player")]
        public Player Player { get; set; }
        [XmlElement(ElementName = "Exit")]
        public Exit Exit { get; set; }
        [XmlAttribute(AttributeName = "Name")]
        public string Name { get; set; }
    }
}