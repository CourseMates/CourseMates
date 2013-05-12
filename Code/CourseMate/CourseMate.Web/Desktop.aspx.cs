using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class Desktop : System.Web.UI.Page
    {
        public string SessionID
        {
            get
            {
                if (Session["SessionID"] != null)
                    return Session["SessionID"].ToString();
                return string.Empty;
            }
            set
            {
                Session["SessionID"] = value;
            }
        }

        public int UserID
        {
            get
            {
                if (Session["UserID"] != null)
                {
                    int x;
                    if (int.TryParse(Session["UserID"].ToString(), out x))
                    {
                        return x;
                    }
                }
                return -1;
            }
            set
            {
                Session["UserID"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(SessionID))
            {
                //Response.Redirect("Error.aspx");
            }
            else
            {
            }
        }

        protected void Logout_Click(object sender, DirectEventArgs e)
        {
            SessionID = string.Empty;
            UserID = -1;
            Response.Redirect("Index.aspx");
        }

        protected void AddNewCourse_Click(object sender, DirectEventArgs e)
        {
        }
    }
}