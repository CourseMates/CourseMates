using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Refresh();
        }
        [DirectMethod(ShowMask=true)]
        public void Refresh()
        {
            int x = 0;
            Random r = new Random();
            List<object> obj = new List<object>();
            for (int i = 0; i < 10; i++)
            {
                obj.Add(new
                {
                    ItemID = i,
                    Title = "Title " + i,
                    Content = "Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content Content ",
                    Owner = "Owner " + i,
                    Date = DateTime.Now,
                    Level = 50*x,
                });
                x = r.Next(0, 2);
            }
            storeQA.DataSource = obj;
            storeQA.DataBind();
        }
    }
}