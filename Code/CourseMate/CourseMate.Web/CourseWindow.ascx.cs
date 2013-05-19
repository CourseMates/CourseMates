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
        private string _title;
        public string Title 
        {
            get
            {
                return _title;
            }
            set
            {
                _title = value;
                winCourse.Title = _title;
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
            //Store1.DataSource = new object[]
            //{
            //    new object[]{"Black","x-black-folder"},
            //    new object[]{"Beige","x-beige-folder"},
            //    new object[]{"Blue","x-blue-folder"},
            //    new object[]{"Green","x-green-folder"},
            //    new object[]{"Lila","x-lila-folder"},
            //    new object[]{"Orange","x-orange-folder"},
            //    new object[]{"Pink","x-pink-folder"},
            //    new object[]{"White","x-white-folder"}
            //};
            //Store1.DataBind();
        }
        
        protected void UploadClick(object sender, DirectEventArgs e)
        {
            if (this.FileUploadField1.HasFile)
            {
                new CourseMate.Web.CMwcf.CourseMatesClient().UploadFile(1, "newfile.pdf", 0, "123", 1, 1, FileUploadField1.FileContent);
            }
        }

    }
}