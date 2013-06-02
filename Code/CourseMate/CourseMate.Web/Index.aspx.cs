using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using CourseMate.Web.CMwcf;
using CourseMate.Web;

namespace CourseMate.Web
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public string SessionID
        {
            get 
            { 
                if(Session["SessionID"] != null)
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

        }

        protected void Login_Click(object sender, DirectEventArgs e)
        {
            CourseMatesClient cm = new CourseMatesClient();
            int id;
            string session = cm.Login(txtUsername.Text, BLL.Utilitys.GetMd5Hash(txtPassword.Text), out id);
            
            if (!string.IsNullOrEmpty(session))
            {
                SessionID = session;
                UserID = id;
                X.Redirect("Desktop.aspx");
            }
            else
            {
                ShowMessage("Login Error", "User or password dont exist.", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                txtPassword.Text = "";
            }
        }

        protected void Register_Click(object sender, DirectEventArgs e)
        {
            CourseMatesClient cm = new CourseMatesClient();
            User user = new User()
            {
                FirstName = txtRFName.Text,
                LastName = txtRLName.Text,
                Email = txtREmail.Text,
                Password = BLL.Utilitys.GetMd5Hash(txtRPassword.Text),
                UserName = txtRUsername.Text,
                GCMId = string.Empty,
            };
            
            string session;
            int id;

            SQLStatus status = cm.Register(user, out id, out session);

            switch (status)
            {
                case SQLStatus.Succeeded:
                    SessionID = session;
                    UserID = id;
                    ShowMessage("Create New User", "", MessageBox.Icon.NONE, MessageBox.Button.OK);
                    Response.Redirect("Desktop.aspx");
                    break;
                case SQLStatus.Failed:
                    ShowMessage("Create New User", "Unknown error, please try later", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                    break;
                case SQLStatus.UserExists:
                    ShowMessage("Create New User", "The user name is alredy exist", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                    break;
                case SQLStatus.EmailExists:
                    ShowMessage("Create New User", "The email address is alredy exist", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                    break;
                default:
                    break;
            }

        }

        protected void SendEmail_Click(object sender, DirectEventArgs e)
        {
            if (new CourseMatesClient().SendRestorePassword(txtFPEmail.Text))
            {
                ShowMessage("Forget Password", "A Restore email was send your email. ", MessageBox.Icon.INFO, MessageBox.Button.OK);
            }
            else
            {
                ShowMessage("Forget Password", "Email don't exsit.", MessageBox.Icon.WARNING, MessageBox.Button.OK);
            }
        }

        private void ShowMessage(string title, string msg, MessageBox.Icon icon, MessageBox.Button btn)
        {
            Ext.Net.MessageBox msgbox = new MessageBox();
            msgbox.Show(new MessageBoxConfig()
            {
                Title = title,
                Message = msg,
                Icon = icon,
                Buttons = btn
            });
        }
    }
}