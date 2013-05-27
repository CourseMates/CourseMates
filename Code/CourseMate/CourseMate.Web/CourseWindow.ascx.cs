using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;

namespace CourseMate.Web
{
    public partial class CourseWindow : System.Web.UI.UserControl
    {

        public string ModuleID
        {
            get { return dmp.Module.ModuleID; }
            set { dmp.Module.ModuleID = value; }
        }

        private string _iconClass;
        public string IconClass
        {
            get
            {
                return _iconClass;
                //return dmp.Module.Shortcut.IconCls;
            }
            set
            {
                _iconClass = value;
                //dmp.Module.Shortcut.IconCls = value;
            }
        }
        private string _courseName;
        public string CourseName
        {
            get
            {
                return _courseName;
            }
            set
            {
                _courseName = value;
                //winCourse.Title = _courseName;
                //dmp.Module.Shortcut.Name = _courseName;
                //txtCourseName.Text = _title;
            }
        }

        public int CourseID { get; set; }

        private bool _isAdmin;
        public bool IsAdmin
        {
            get
            {
                return _isAdmin;
            }
            set
            {
                _isAdmin = value;
                //txtCourseName.Visible = _isAdmin;
                //sperator1.Visible = _isAdmin;
                //sperator2.Visible = _isAdmin;
                //btnChangeName.Visible = _isAdmin;
                //btnDeleteCourse.Visible = _isAdmin;
                //btnLeaveCourse.Visible = !_isAdmin;
                //cmbFolderColor.Visible = _isAdmin;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
        
        protected void UploadClick(object sender, DirectEventArgs e)
        {
            //if (this.uploadFiled.HasFile)
            //{
            //    new CourseMate.Web.CMwcf.CourseMatesClient().UploadFile(1, "newfile.pdf", 0, "123", 1, 1, uploadFiled.FileContent);
            //}
        }
    }
}