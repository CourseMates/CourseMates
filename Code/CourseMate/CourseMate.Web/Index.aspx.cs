using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(object sender, DirectEventArgs e)
        {
            if (txtUsername.Text == "benoh" && txtPassword.Text == "P@ssw0rd")
            {
                Response.Redirect("Desktop.aspx");
            }
            else
            {
                Ext.Net.MessageBox msg = new MessageBox();
                msg.Show(new MessageBoxConfig()
                {
                    Title="Login Error",
                    Message="User or password dont exist.",
                    Icon= MessageBox.Icon.ERROR,
                    Buttons = MessageBox.Button.OK
                });
                txtPassword.Text = "";
                txtUsername.Text = "";
                loggInWin.Close();

            }
        }
    }
}