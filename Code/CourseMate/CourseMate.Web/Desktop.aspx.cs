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
        public int CurrentCourse 
        {
            get
            {
                if (Session["CurrentCourse"] == null)
                    return -1;
                return (int)Session["CurrentCourse"];
            }
            set
            {
                Session["CurrentCourse"] = value;
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
        public FileStructure CourseFiles
        {
            get
            {
                if (Session["CourseFiles"] != null)
                    return Session["CourseFiles"] as FileStructure;
                return null;
            }
            set
            {
                Session["CourseFiles"] = value;
            }
        }
        public Dictionary<int, Course> Courses
        {
            get
            {
                if (Session["Courses"] == null)
                    return null;
                return (Dictionary<int, Course>)Session["Courses"];
            }
            set
            {
                Session["Courses"] = value;
            }
        }
        
        protected void Page_Load(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(SessionID))
            {
                X.Redirect("Error.aspx");
            }
            else
            {
                this.storeFolderColors.DataSource = new object[]
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

                if (!X.IsAjaxRequest)
                {
                    Courses = new Dictionary<int, Course>();
                    Course[] allCourses = new CourseMatesClient().GetCourseByUserId(SessionID, UserID.ToString());

                    foreach (Course course in allCourses)
                    {
                        Courses.Add(course.ID, course);
                        DesktopModule m = new DesktopModule
                        {
                            ModuleID = "Course-" + course.ID,
                            Shortcut = new DesktopShortcut
                            {
                                Name = course.CourseName,
                                IconCls = course.IconClass,
                                TextCls = "x-folder-text",
                                Handler = "#{winCourse}.show();#{DirectMethods}.LoadCourseData(" + course.ID + ");",
                            }
                        };

                        MyDesktop.Modules.Add(m);
                    }
                }
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

        protected void UploadClick(object sender, DirectEventArgs e)
        {
            //if (this.uploadFiled.HasFile)
            //{
            //    new CourseMate.Web.CMwcf.CourseMatesClient().UploadFile(1, "newfile.pdf", 0, "123", 1, 1, uploadFiled.FileContent);
            //}
        }

        protected void FileItemClick(object sender, DirectEventArgs e)
        {
            int fileId;

            if (int.TryParse(e.ExtraParams["nodeId"].ToString().Split('-')[1], out fileId))
            {
                UpdateViewPanel(fileId);
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
                    TextCls = "x-folder-text",
                    Handler = "#{winCourse}.show();#{DirectMethods}.LoadCourseData(" + id + ");",
                }
            };

            MyDesktop.AddModule(m);
            MyDesktop.ArrangeShortcuts();
        }
        
        private FileItem GetFileItem(FileItem item, int courseId)
        {
            if (item == null)
                return null;
            if (item.ID == courseId)
                return item;
            foreach (var file in item.SubItems)
            {
                FileItem f = GetFileItem(file, courseId);
                if (f != null)
                {
                    if (f.ID == courseId)
                        return f;
                }
            }
            return null;
        }

        private Node GetFileStructure(FileItem fs)
        {
            Node root = new Node();
            root.Text = fs.FileName;
            root.NodeID = "Node-" + fs.ID;
            root.Icon = fs.IsFolder ? Icon.Folder : Icon.Report;

            if(fs.ID == CourseFiles.RootFolder.ID)
                root.Expanded = true;

            foreach (FileItem item in fs.SubItems)
            {
                Node n = GetFileStructure(item);
                if (n.Children.Count == 0)
                    n.Leaf = true;
                root.Children.Add(n);
            }

            return root;
        }

        [DirectMethod]
        public void UpdateViewPanel(int fileId)
        {
            FileItem item = GetFileItem(CourseFiles.RootFolder, fileId);
            if (item == null)
                return;

            if (item.IsFolder)
            {
                List<object> obj = new List<object>();
                if (item.ID != CourseFiles.RootFolder.ID)
                {
                    obj.Add(new
                    {
                        FileID = item.PerantID,
                        FileName = "Go Back",
                        ImageUrl = @"Images\goback.png"
                    });
                }

                foreach (var file in item.SubItems)
                {
                    obj.Add(new
                    {
                        FileID = file.ID,
                        FileName = file.FileName,
                        ImageUrl = file.Type.IconClass,
                        Size = 3.4,
                        LastModify = DateTime.Now,
                        Rate = 5,
                        Type = "Word 2007",
                        Owner = "benoh"
                    });
                }
                storeFiles.DataSource = obj.ToArray();
                storeFiles.DataBind();
            }
            
        }
        
        [DirectMethod(ShowMask=true, CustomTarget="winCourse")]
        public void LoadCourseData(int courseId)
        {
            if (CurrentCourse != courseId)
            {
                CourseMatesClient client = new CourseMatesClient();
                CourseFiles = client.GetCourseFiles(courseId);
                UpdateViewPanel(CourseFiles.RootFolder.ID);
                if(filesTreePanel.Root.Count >0)
                    filesTreePanel.Root.RemoveAt(0);
                filesTreePanel.SetRootNode(GetFileStructure(CourseFiles.RootFolder));

                winCourse.Title = Courses[courseId].CourseName;
                CurrentCourse = courseId;
            }
        }
    }
}