using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using CourseMate.Web.CMwcf;

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

            Store1.DataSource = new object[]
            {
                new object[]{"Black","x-black-folder"},
                new object[]{"Beige","x-beige-folder"},
                new object[]{"Blue","x-blue-folder"},
                new object[]{"Green","x-green-folder"},
                new object[]{"Lila","x-lila-folder"},
                new object[]{"Orange","x-orange-folder"},
                new object[]{"Pink","x-pink-folder"},
                new object[]{"White","x-white-folder"}
            };
            Store1.DataBind();

            Course[] allCourses = new CourseMatesClient().GetCourseByUserId(SessionID, UserID.ToString());

            foreach (Course course in allCourses)
            {
                DesktopModule m = new DesktopModule
                {
                    ModuleID = "Course-" + course.ID,
                    Shortcut = new DesktopShortcut
                    {
                        Name = course.CourseName,
                        IconCls = course.IconClass,
                        TextCls = "x-folder-text"
                    },

                    AutoRun = false
                };

                MyDesktop.Modules.Add(m);
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
            int courseId = -1;
            courseId = new CourseMatesClient().CreateNewCourse(SessionID, UserID, txtCourseName.Text, cmbFolderColor.SelectedItem.Value);
            if (courseId != -1)
            {
                CreateNewCourseMudole(courseId, txtCourseName.Text, cmbFolderColor.SelectedItem.Value);
                ShowMessage("Create new course", "The course has been created", MessageBox.Icon.INFO, MessageBox.Button.OK);
                winAddNewCourse.Close();
            }
            else
            {
                ShowMessage("Create new course", "Can't create course", MessageBox.Icon.ERROR, MessageBox.Button.OK);
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
        
        private void CreateNewCourseMudole(int id, string name, string iconCls)
        {
            DesktopModule m = new DesktopModule
            {
                ModuleID = "Course-" + id,
                Shortcut = new DesktopShortcut
                {
                    Name = name,
                    IconCls = iconCls,
                    TextCls = "x-folder-text"
                },

                AutoRun = false
            };

            MyDesktop.AddModule(m);
            MyDesktop.ArrangeShortcuts();
        }
    }
}