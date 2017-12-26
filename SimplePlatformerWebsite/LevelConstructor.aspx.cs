using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Serialization;

class StringWriterUtf8 : StringWriter
{
    public override Encoding Encoding
    {
        get
        {
            return Encoding.UTF8;
        }
    }
}

public partial class LevelConstructor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            LevelDataLabel.Text = (string)Session["LevelName"] + ", " + (int)Session["XSize"] + "x" + (int)Session["YSize"];
            LevelNameTextBox.Text = (string)Session["LevelName"];
            LevelYSizeTextBox.Text = ((int)Session["YSize"]).ToString();
            VariablesLiteral.Text = "" +
                "<script type='text/javascript'>" +
                "   window.levelName = '" + (string)Session["LevelName"] + "';" +
                "   window.xSize = " + (int)Session["XSize"] + ";" +
                "   window.ySize = " + (int)Session["YSize"] + ";" +
                "</script>";
        }
    }

    protected void SaveLevelButton_Click(object sender, EventArgs e)
    {
        int ySize = Convert.ToInt32(LevelYSizeTextBox.Text);

        XMLToCSharp.Level level = new XMLToCSharp.Level();
        level.Name = LevelNameTextBox.Text;
        level.Blocks = new List<XMLToCSharp.Block>();

        string[] lines = LevelDataTextBox.Text.Split(',');
        for (int row = 0; row < lines.Length; row++)
        {
            for (var col = 0; col < lines[row].Length; col++)
            {
                int realY = ySize - row - 1;
                switch (lines[row][col])
                {
                    case '8':
                        level.Exit = new XMLToCSharp.Exit() { X = col, Y = realY };
                        break;
                    case '4':
                        level.Player = new XMLToCSharp.Player() { X = col, Y = realY };
                        break;
                    case '2':
                        level.Blocks.Add(new XMLToCSharp.Block() { Type = "Gem", X = col, Y = realY });
                        break;
                    case '1':
                        level.Blocks.Add(new XMLToCSharp.Block() { Type = "Ground", X = col, Y = realY });
                        break;
                }
            }
        }

        string resultingFile;
        XmlSerializer serializer = new XmlSerializer(typeof(XMLToCSharp.Level));
        using (StringWriterUtf8 textWriter = new StringWriterUtf8())
        {
            serializer.Serialize(textWriter, level);
            resultingFile = textWriter.ToString();
        }

        SimplePlatformerEntities ents = new SimplePlatformerEntities();
        ents.levels.Add(new levels() { name = level.Name, level = resultingFile });
        ents.SaveChanges();

        Response.Redirect("~/Default.aspx");
    }
}