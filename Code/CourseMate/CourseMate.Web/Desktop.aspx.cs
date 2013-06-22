using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
using CourseMate.Web.CMwcf;
using System.IO;
using CourseMate.Web.BLL;

namespace CourseMate.Web
{
    public partial class Desktop : System.Web.UI.Page
    {
        #region Session variables
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
        public int CurrentViewLocation
        {
            get
            {
                if (Session["CurrentViewLocation"] != null)
                {
                    int x;
                    if (int.TryParse(Session["CurrentViewLocation"].ToString(), out x))
                    {
                        return x;
                    }
                }
                return -1;
            }
            set
            {
                Session["CurrentViewLocation"] = value;
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
        public List<CMwcf.Notification> UserNotification
        {
            get
            {
                if (Session["UserNotification"] == null)
                    UserNotification = new List<CourseMate.Web.CMwcf.Notification>();
                return Session["UserNotification"] as List<CourseMate.Web.CMwcf.Notification>; 
            }
            set
            {
                Session["UserNotification"] = value;
            }
        }
        #endregion

        #region Listiners
        protected void Page_Load(object sender, EventArgs e)
        {

            if (string.IsNullOrEmpty(SessionID))
            {
                X.Redirect("Error.aspx");
            }
            else
            {
                object[] obj = new object[]
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
                storeFolderColors.DataSource = obj;
                storeFolderColors1.DataSource = obj;

                if (!X.IsAjaxRequest)
                {
                    GetAllCourses();

                    foreach (Course course in Courses.Values)
                    {
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

                    UserNotification = new List<CMwcf.Notification>();
                    CMwcf.Notification[] newNoti = CourseMatesWS.GetUserHistoryAndNotification(SessionID, UserID, GetLastNotificationDate());
                    newNoti.OrderByDescending(x => x.CreatedTime);
                    
                    List<object> obj1 = new List<object>();
                    foreach (var not in newNoti)
                    {
                        UserNotification.Add(not);
                        obj1.Add(
                        new
                        {
                            Subject = not.Subject,
                            Content = not.Content.Replace("\r\n", "<br>"),
                            Owner = not.Owner,
                            CourseName = not.CourseName,
                            CreatedTime = TimeAgo(not.CreatedTime)
                        });
                    }

                    storeNotification.DataSource = obj1;
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
            courseId = CourseMatesWS.CreateNewCourse(SessionID, UserID, txtCourseName.Text, cmbFolderColor.SelectedItem.Value);
            if (courseId != -1)
            {
                GetAllCourses();
                CourseFiles = CourseMatesWS.GetCourseFiles(SessionID, UserID, courseId);
                CreateNewCourseMudole(courseId, txtCourseName.Text, cmbFolderColor.SelectedItem.Value);
                winAddNewCourse.Close();
            }
            else
            {
                ShowMessage("Create new course", "Can't create course", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }

        protected void UploadNewFile(object sender, DirectEventArgs e)
        {
            bool isFolder;
            string fileName = string.Empty;
            int size = 0;
            string status = string.Empty;

            FileItem f = GetFileItem(CourseFiles.RootFolder, CurrentViewLocation);

            if (f.SubItems != null)
            {
                foreach (var item in f.SubItems)
                {
                    if (item.FileName == txtFolderName.Text || item.FileName == uploadFiled.PostedFile.FileName.Split('\\').Last())
                    {
                        ShowMessage("Error", "An item with the same name exists,<br>rename and try again.", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                        return;
                    }
                }
            }
            try
            {
                if (bool.TryParse(e.ExtraParams["isFolder"], out isFolder))
                {
                    if (isFolder)
                    {
                        fileName = txtFolderName.Text;
                        size = 0;
                        CourseMatesWS.UploadFile(CurrentCourse, fileName, true, CurrentViewLocation, SessionID, size, FileTypeE.Folder, UserID, Stream.Null);
                        status = "Success";
                        ReLoadCourseFiles(CurrentCourse);
                    }
                    else
                    {
                        fileName = uploadFiled.PostedFile.FileName.Split('\\').Last();
                        size = uploadFiled.PostedFile.ContentLength;
                        FileTypeE type;
                        if (GetFileType(fileName, out type))
                        {
                            CourseMatesWS.UploadFile(CurrentCourse, fileName, false, CurrentViewLocation, SessionID, size, type, UserID, uploadFiled.FileContent);
                            status = "Success";
                            ReLoadCourseFiles(CurrentCourse);
                        }
                        else
                            status = "Unsupported file type";
                    }
                }
            }
            catch (Exception)
            {
                status = "Failed";
            }
            string msg = @"<b>File Name:</b> {0}<br/>
                           <b>Size:</b> {1}<br/>
                           <b>Status:</b> {2}<br/>";
            msg = string.Format(msg, fileName, GetFormatedSize(size), status);
            X.Msg.Hide();
            ShowMessage("Add File", msg, MessageBox.Icon.INFO, MessageBox.Button.OK);

            winUploadFile.Hide();
        }

        protected void FileItemClick(object sender, DirectEventArgs e)
        {
            int fileId;

            if (int.TryParse(e.ExtraParams["nodeId"].ToString().Split('-')[1], out fileId))
            {
                UpdateViewPanel(fileId);
            }

        }

        protected void DeleteFile(object sender, DirectEventArgs e)
        {
            int fileId;

            if(int.TryParse(e.ExtraParams["FileID"], out fileId))
            {
                DeleteStatus status = CourseMatesWS.DeleteFile(SessionID, UserID, fileId);
                switch (status)
                {
                    case DeleteStatus.Success:
                        ReLoadCourseFiles(CurrentCourse);
                        break;
                    case DeleteStatus.Failed:
                        ShowMessage("Delete File", "Failes", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                        break;
                    case DeleteStatus.Authorized:
                        ShowMessage("Delete File", "You are not authorized deleting this item.", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                        break;
                    case DeleteStatus.FullFolder:
                        ShowMessage("Delete File", "This is a full folder, can not delete.", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                        break;
                }
            }
        }

        protected void RemoveUserFromCourse(object sender, DirectEventArgs e)
        {
            int userId;

             if (int.TryParse(e.ExtraParams["UserID"], out userId))
            {
                if (CourseMatesWS.RemoveUserFromCourse(SessionID, UserID, CurrentCourse, userId))
                {
                    LoadUsers();
                }
                else
                {
                    ShowMessage("Remove User", "You are not authorized deleting this user.", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                }
            }
        }

        protected void SetUserAsAbmin(object sender, DirectEventArgs e)
        {
            int userId;

            if (int.TryParse(e.ExtraParams["UserID"], out userId))
            {
                if (CourseMatesWS.SetUserAsCourseAdmin(SessionID, UserID, CurrentCourse, userId))
                {
                    LoadUsers();
                }
                else
                {
                    ShowMessage("Set as Admin", "Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
                }
            }
        }

        protected void DownloadFile(object sender, DirectEventArgs e)
        {
            int fileId;
            bool isFolder = false;
            bool.TryParse(e.ExtraParams["IsFolder"], out isFolder);
            if (int.TryParse(e.ExtraParams["FileID"], out fileId))
            {
                string fileName;
                int size;
                Stream stream;
                fileName = CourseMatesWS.GetFile(fileId, SessionID, UserID, out size, out stream);
                if (!isFolder)
                {
                    Response.BufferOutput = false;
                    byte[] buffer = new byte[6500];
                    int bytesRead = 0;

                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Response.ClearHeaders();
                    HttpContext.Current.Response.ContentType = "application/octet-stream";
                    HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + fileName);

                    bytesRead = stream.Read(buffer, 0, buffer.Length);

                    while (bytesRead > 0)
                    {
                        if (Response.IsClientConnected)
                        {
                            Response.OutputStream.Write(buffer, 0, bytesRead);
                            Response.Flush();
                            buffer = new byte[6500];
                            bytesRead = stream.Read(buffer, 0, buffer.Length);
                        }
                        else
                        {
                            bytesRead = -1;
                        }
                    } 
                }
            }
        }

        protected void DeleteCourse(object sender, DirectEventArgs e)
        {
            if (CourseMatesWS.DeleteCourse(SessionID, UserID, CurrentCourse))
            {
                Courses.Remove(CurrentCourse);
                winCourse.Close();
            }
        }

        protected void DeleteFourmItem(object sender, DirectEventArgs e)
        {
            int itemId;
            int.TryParse(e.ExtraParams["ItemID"].ToString(), out itemId);

            if (CourseMatesWS.DeleteForumItem(SessionID, UserID, CurrentCourse, itemId))
            {
                LoadForum();
            }
            else
            {
                ShowMessage("Delete Comment", "Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }
        
        protected void CheckForNewNotification(object sender, DirectEventArgs e)
        {
            CMwcf.Notification[] newNoti =  CourseMatesWS.GetUserHistoryAndNotification(SessionID, UserID, GetLastNotificationDate());
            if (newNoti.Length > 0)
            {
                foreach (var notification in newNoti)
                {
                    ShowNotification(notification);
                    UserNotification.Add(notification);
                }


                UserNotification = UserNotification.OrderByDescending(x => x.CreatedTime).ToList();

                List<object> obj = new List<object>();
                foreach (var not in UserNotification)
                {
                    obj.Add(
                    new
                    {
                        Subject = not.Subject,
                        Content = not.Content.Replace("\r\n","<br>"),
                        Owner = not.Owner,
                        CourseName = not.CourseName,
                        CreatedTime = TimeAgo(not.CreatedTime)
                    });
                }

                storeNotification.DataSource = obj;
                storeNotification.DataBind();
            }
        }
        #endregion

        #region Direct Methods
        [DirectMethod]
        public void ChangeMovie(string url)
        {
            fcHelpVideo.Url = url;
            fcHelpVideo.Render();
            MenuPanel1.Collapse();
        }

        [DirectMethod]
        public void UpdateViewPanel(int fileId)
        {
            CurrentViewLocation = fileId;
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
                        ImageUrl = @"Images\goback.png",
                        Size = 0,
                        LastModify = "",
                        Rate = 0,
                        Type = 0,
                        Owner = "",
                        IsFolder = false,
                        OwnerID = 0
                    });
                }
                if (item.SubItems != null)
                {
                    foreach (var file in item.SubItems)
                    {
                        obj.Add(new
                        {
                            FileID = file.ID,
                            FileName = file.FileName,
                            ImageUrl = file.Type.ImageUrl,
                            Size = GetFormatedSize(file.Size),
                            LastModify = TimeAgo(file.LastModify),
                            Rate = GetPresentege(file.Rate),
                            Type = file.Type.Description,
                            Owner = file.OwnerName,
                            IsFolder = file.IsFolder,
                            OwnerID = file.OwnerId
                        });
                    }
                }
                storeFiles.DataSource = obj.ToArray();
                storeFiles.DataBind();
            }

        }
        
        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void LoadCourseData(int courseId)
        {
            LoadFiles(courseId);
            LoadUsers();
            LoadSettings();
            LoadForum();
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void LoadForum()
        {
            if (!Courses[CurrentCourse].IsAdmin)
            {
                btnDeleteComment.Disabled = true;
            }
            else
            {
                btnDeleteComment.Disabled = false;
            }
            Forum fo = CourseMatesWS.GetCourseForum(SessionID, UserID, CurrentCourse);
            
            storeQA.DataSource = GetForumList(fo.AllItems.ToList() ,0);
            storeQA.DataBind();
        }
        
        [DirectMethod]
        public object GetAllUsers()
        {
            string[] l = CourseMatesWS.GetTop15Users(cbAddUserName.Text);
            List<object> obj = new List<object>();
            foreach (string name in l)
            {
                obj.Add(new { UserName = name });
            }
            return obj;
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void AddNewUserToCourse()
        {
            if (!CourseMatesWS.AddUserToCourse(SessionID, UserID, CurrentCourse, cbAddUserName.Value.ToString()))
            {
                ShowMessage("Add New User", "Failed adding user to course", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
            else
            {
                LoadUsers();  
            }
            cbAddUserName.Text = "";
            winAddUser.Hide();
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void LoadSettings()
        {
            winCourse.Title = Courses[CurrentCourse].CourseName;
            txtCourseNameChange.Text = Courses[CurrentCourse].CourseName;
            cmbFolderColor1.Value = Courses[CurrentCourse].IconClass;
            if (!Courses[CurrentCourse].IsAdmin)
            {
                txtCourseNameChange.ReadOnly = true;
                cmbFolderColor1.ReadOnly = true;
                fcSaveChanges.Disabled = true;
                btnDeleteCourse.Disabled = true;
            }
            else
            {
                txtCourseNameChange.ReadOnly = false;
                cmbFolderColor1.ReadOnly = false;
                fcSaveChanges.Disabled = false;
                btnDeleteCourse.Disabled = false;
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void LoadUsers()
        {
            User[] users = CourseMatesWS.GetCoursePartisipant(SessionID, UserID, CurrentCourse);
            List<object> obj = new List<object>();

            foreach (User u in users)
            {
                obj.Add(new
                {
                    UserID = u.ID,
                    UserName = u.UserName,
                    FirstName = u.FirstName,
                    LastName = u.LastName,
                    Email = u.Email,
                    IsAdmin = u.IsAdmin
                });
            }

            storeUserView.DataSource = obj;
            storeUserView.DataBind();
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void LoadFiles(int courseId)
        {
            if ((courseId == -1 || CurrentCourse == courseId) && CourseFiles != null)
            {
                UpdateViewPanel(CourseFiles.RootFolder.ID);
                if (filesTreePanel.Root.Count > 0)
                    filesTreePanel.Root.RemoveAt(0);
                filesTreePanel.SetRootNode(GetFileStructure(CourseFiles.RootFolder));

                return;
            }
            if (CurrentCourse != courseId)
            {
                ReLoadCourseFiles(courseId);
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void UpdateCourse()
        {
            if (CourseMatesWS.UpdateCourse(SessionID, UserID, CurrentCourse, txtCourseNameChange.Text, cmbFolderColor1.Value.ToString()))
            {
                winCourse.Title = txtCourseNameChange.Text;
                Courses[CurrentCourse].CourseName = txtCourseNameChange.Text;
                Courses[CurrentCourse].IconClass = cmbFolderColor1.Value.ToString();
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void AddNewFormItem()
        {
            ForumItem item = new ForumItem();
            item.Title = txtTitle.Text;
            int x;
            int.TryParse(hiddenItemId.Value.ToString(), out x);
            item.PerentIdSpecified = true;
            item.PerentId = x;
            item.CourseIdSpecified = true;
            item.Content = taContent.Text.Replace("\r\n","<br>");
            item.OwnerIdSpecified = true;
            item.OwnerId = UserID;
            item.CourseId = CurrentCourse;

            if (CourseMatesWS.AddNewForumItem(SessionID, UserID, item))
            {
                txtTitle.Text = "";
                taContent.Text = "";
                winNewComment.Hide();
                LoadForum();
            }
            else
            {
                ShowMessage("Add Comment", "Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void RateFile(int fileId, int rate)
        {
            if (CourseMatesWS.RateFile(SessionID, UserID, fileId, rate))
            {
                ReLoadCourseFiles(CurrentCourse);
                btnRateFileDown.Disabled = true;
                btnRateFileUp.Disabled = true;
            }
            else
            {
                ShowMessage("Rate File", "Error: Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }
        
        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void RateComment(int itemId, int rate)
        {
            if (CourseMatesWS.RateForumItem(SessionID, UserID, itemId, rate))
            {
                LoadForum();
                btnRateCommentDown.Disabled = true;
                btnRateCommentUp.Disabled = true;
            }
            else
            {
                ShowMessage("Rate Comment", "Error: Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winCourse")]
        public void SendMessage()
        {
            CMwcf.Notification noti = new CMwcf.Notification()
            {
                Subject = txtCASubject.Text,
                Content = taMessage.Text
            };

            if (!CourseMatesWS.AddNewNotification(SessionID, UserID, CurrentCourse, noti))
            {
                ShowMessage("Send Message", "Error: Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
            else
            {
                txtCASubject.Text = "";
                taContent.Text = "";
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winSettings")]
        public void ChangePassword()
        {
            if (CourseMatesWS.ChangePassword(SessionID, UserID, Utilitys.GetMd5Hash(txtOldPassword.Text), Utilitys.GetMd5Hash(txtNewPassword.Text)))
            {
                ShowMessage("Password Change", "Done", MessageBox.Icon.INFO, MessageBox.Button.OK);
                txtNewPassword.Text = "";
                txtOldPassword.Text = "";
                txtCNewPassword.Text = "";
            }
            else
            {
                ShowMessage("Password Change", "Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }

        [DirectMethod(ShowMask = true, CustomTarget = "winSettings")]
        public void ChangeEmail()
        {
            if (CourseMatesWS.ChangeEmail(SessionID, UserID, txtOldEmail.Text, txtNewEmail.Text))
            {
                ShowMessage("Email Change", "Done", MessageBox.Icon.INFO, MessageBox.Button.OK);
                txtNewEmail.Text = "";
                txtOldEmail.Text = "";
            }
            else
            {
                ShowMessage("Email Change", "Failed", MessageBox.Icon.ERROR, MessageBox.Button.OK);
            }
        }
        #endregion

        #region Private Methods
        private List<object> GetForumList(List<ForumItem> items, int level)
        {
            if (items == null)
            {
                return null;
            }
            List<object> obj = new List<object>();

            foreach (ForumItem item in items)
            {
                obj.Add(new
                {
                    ItemID = item.ID,
                    Title = item.Title,
                    Content = item.Content,
                    OwnerName = item.OwnerName,
                    TimeAdded = TimeAgo(item.TimeAdded),
                    Rate = GetPresentege(item.Rate),
                    Level = 50 * level
                });
                if (item.SubItems != null)
                    obj.AddRange(GetForumList(item.SubItems.ToList(), level + 1));
            }

            return obj;
        }

        private bool GetFileType(string fileName, out FileTypeE type)
        {
            string postFix = fileName.Split('.').Last();
            return Enum.TryParse<FileTypeE>(postFix.ToUpper(), out type);
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

        private FileItem GetFileItem(FileItem item, int fileId)
        {
            if (item == null)
                return null;
            if (item.ID == fileId)
                return item;
            if (item.SubItems != null)
            {
                foreach (var file in item.SubItems)
                {
                    FileItem f = GetFileItem(file, fileId);
                    if (f != null)
                    {
                        if (f.ID == fileId)
                            return f;
                    }
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

            if (fs.SubItems != null)
            {
                if (fs.ID == CourseFiles.RootFolder.ID)
                    root.Expanded = true;

                foreach (FileItem item in fs.SubItems)
                {
                    Node n = GetFileStructure(item);
                    if (n.Children.Count == 0)
                        n.Leaf = true;
                    root.Children.Add(n);
                }
            }
            else
                root.Leaf = true;
            return root;
        }

        private string GetFormatedSize(int size)
        {
            double s = (double)size / 1024;
            if (s > 999)
            {
                s = s / 1024;
                if (s > 999)
                {
                    s = s / 1024;
                    return string.Format("{0:0.0}", s) + " GB";
                }
                return string.Format("{0:0.0}", s) + " MB";
            }
            return string.Format("{0:0.0}", s) + " KB";
        }

        private void GetAllCourses()
        {
            Courses = new Dictionary<int, Course>();
            Course[] allCourses = CourseMatesWS.GetCoursesByUserId(SessionID, UserID.ToString());

            foreach (Course course in allCourses)
            {
                Courses.Add(course.ID, course);
            }
        }

        private void ReLoadCourseFiles(int courseId)
        {
            CourseFiles = CourseMatesWS.GetCourseFiles(SessionID, UserID, courseId);
                UpdateViewPanel(CourseFiles.RootFolder.ID);
            if (filesTreePanel.Root.Count > 0)
                filesTreePanel.Root.RemoveAt(0);
            filesTreePanel.SetRootNode(GetFileStructure(CourseFiles.RootFolder));

            CurrentCourse = courseId;
        }

        public string TimeAgo(DateTime date)
        {
            TimeSpan timeSince = DateTime.Now.Subtract(date);
            if (timeSince.TotalMilliseconds < 1) return "not yet";
            if (timeSince.TotalMinutes < 1) return "just now";
            if (timeSince.TotalMinutes < 2) return "1 minute ago";
            if (timeSince.TotalMinutes < 60) return string.Format("{0} minutes ago", timeSince.Minutes);
            if (timeSince.TotalMinutes < 120) return "1 hour ago";
            if (timeSince.TotalHours < 24) return string.Format("{0} hours ago", timeSince.Hours);
            if (timeSince.TotalDays < 2) return "yesterday";
            if (timeSince.TotalDays < 7) return string.Format("{0} days ago", timeSince.Days);
            if (timeSince.TotalDays < 14) return "last week";
            if (timeSince.TotalDays < 21) return "2 weeks ago";
            if (timeSince.TotalDays < 28) return "3 weeks ago";
            if (timeSince.TotalDays < 60) return "last month";
            if (timeSince.TotalDays < 365) return string.Format("{0} months ago", Math.Round(timeSince.TotalDays / 30));
            if (timeSince.TotalDays < 730) return "last year"; //last but not least...
            return string.Format("{0} years ago", Math.Round(timeSince.TotalDays / 365));
        }

        private string GetPresentege(double rate)
        {
            int pre = (int)(rate * 100);
            if (pre <= 0)
                return "Not rated item";
            return string.Format("Useful by {0}% of the users", pre);
        }

        private DateTime GetLastNotificationDate()
        {
            var noti = UserNotification.FirstOrDefault();
            if (noti == null)
            {
                return DateTime.Now.AddDays(-7);
            }
            return noti.CreatedTime.AddMinutes(1);
        }

        private void ShowNotification(CMwcf.Notification noti)
        {
            Ext.Net.Notification.Show(new NotificationConfig
            {
                Title = noti.Subject + " - " + noti.Owner,
                Html = "<div class=\"forumContent\" style=\"text-align:center;\">" + noti.Content.Replace("\r\n","<br>") + "</div>",
                Icon = Icon.Note,
                Height = 150,
                Width = 250,
                BodyStyle = "padding:10px",
                ShowFx = new SlideIn { Anchor = AnchorPoint.Right },
                HideFx = new SlideOut { Anchor = AnchorPoint.Right },
                BringToFront = true,
                ShowPin = true,
                HideDelay = 5000,
            });
        }
        #endregion
    }
}