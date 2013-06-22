using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CourseMate.Web.CMwcf;
using CourseMate.Web.BLL;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class ResetPassword : System.Web.UI.Page
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
        public CourseMatesClient CourseMatesWS
        {
            get
            {
                if (Session["CourseMatesWS"] != null)
                    return Session["CourseMatesWS"] as CourseMatesClient;
                return new CourseMatesClient();
            }
            set
            {
                Session["CourseMatesWS"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request["i"] != null && Request["u"] != null)
                {
                    int uid = -1;
                    int.TryParse(Request["i"].ToString(), out uid);

                    if (uid > 0 && !string.IsNullOrEmpty(Request["u"].ToString()))
                    {
                        SessionID = CourseMatesWS.GetUserSession(uid, Request["u"].ToString(), LinkType.ResetPassword);
                        if (string.IsNullOrEmpty(SessionID))
                            Response.Redirect("Error.aspx");
                        UserID = uid;
                    }
                    else
                    {
                        Response.Redirect("Error.aspx");
                    }
                }
                else
                {
                    Response.Redirect("Error.aspx");
                }  
            }
        }

        protected void ChangePasswordClick(object sender, EventArgs e)
        {
            if (CourseMatesWS.RestorePassword(SessionID, UserID, Utilitys.GetMd5Hash(txtPassword.Text)))
            {
                Response.Redirect("Desktop.aspx");
            }
        }
    }
}