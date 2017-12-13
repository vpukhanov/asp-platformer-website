using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DownloadLevel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request["id"] == null)
        {
            Response.StatusCode = 404;
            return;
        }
        else
        {
            int reqId = Convert.ToInt32(Request["id"]);
            SimplePlatformerEntities ents = new SimplePlatformerEntities();
            levels foundLevel = (from level in ents.levels
                                 where level.id == reqId
                                 select level).FirstOrDefault();

            if (foundLevel == null)
            {
                Response.StatusCode = 404;
                return;
            }
            else
            {
                Response.Clear();
                Response.ContentType = "text/xml";
                Response.AddHeader("content-disposition", "attachment; filename=\"" + foundLevel.name + ".level\"");
                Response.Write(foundLevel.level);
                Response.End();
            }
        }
    }
}