using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.BLL;
using CourseMatesWS.DAL.Objects;
using System.IO;
using CourseMatesWS.DAL;
using System.Reflection;

namespace CourseMatesWS
{
    public class CourseMates : ICourseMates, IAndroidRest
    {
        #region SOAP
        public string Login(string userName, string password, out int id)
        {
            return CMDal.LogIn(userName, password, out id);
        }

        public SQLStatus Register(User user, out int userId, out string sessionId)
        {
            sessionId = string.Empty;
            SQLStatus status = CMDal.RegisterNewUser(user, out userId);
            if (status == SQLStatus.Succeeded)
                sessionId = CMDal.GetNewSession(userId);
            return status;
        }

        public bool SendRestorePassword(string toSend)
        {
            User user = CMDal.GetUserBy("Email", toSend);
            if (user == null)
            {
                return false;
            }
            CMDal.InsertNewAction(user.ID, (int)LinkType.ResetPassword);
            NotificationUtilitys.SendResetPasswordEmail(user);
            return true;
        }

        public int CreateNewCourse(string sessionId, int userId, string courseName, string iconCls)
        {
            return CMDal.CreateNewCourse(sessionId, userId, courseName, iconCls);
        }

        public List<Course> GetCourseByUserId(string sessionId, string userId)
        {
            int x;
            int.TryParse(userId, out x);
            return CMDal.GetCourseByUserId(sessionId, x);
        }
        
        public FileStructure GetCourseFiles(int courseId)
        {
            return CreateNewStaticStructure();
        }

        public void UploadFile(UploadFileMsg msg)
        {
            try
            {
                using (FileStream outfile = new FileStream(@"C:\Users\bohana\Desktop\FileTransferService\" + msg.FileName, FileMode.Create))
                {
                    const int bufferSize = 65536; // 64K

                    Byte[] buffer = new Byte[bufferSize];
                    int bytesRead = msg.FileStream.Read(buffer, 0, bufferSize);

                    while (bytesRead > 0)
                    {
                        outfile.Write(buffer, 0, bytesRead);
                        bytesRead = msg.FileStream.Read(buffer, 0, bufferSize);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
        }
        #endregion
        #region REST
        public string LoginREST(string userName, string password, out int id)
        {
            return Login(userName, password, out id);
        }

        public List<Course> GetCourseByUserIdREST(string sessionId, string userId)
        {
            return GetCourseByUserId(sessionId, userId);
        }
        #endregion



        private static int item;
        private static FileStructure CreateNewStaticStructure()
        {
            item = 1;
            FileType t = new FileType
            {
                ID = 1,
                IconClass = @"Images\FileType\folder.png",
                Exstention = null,
                Description = "Folder"
            };

            FileItem fi = new FileItem
            {
                FileName = "Root",
                ID = 0,
                IsFolder = true,
                OwnerId = 1,
                PerantID = -1,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };
            List<FileItem> folders = new List<FileItem>();
            for (int i = 0; i < 10; i++)
            {
                folders.Add(GetNewFolder(false, -1));
            }
            List<FileItem> files = new List<FileItem>();
            for (int i = 0; i < 13; i++)
            {
                files.Add(GetNewFile(false, -1));
            }
            //root
            AddToFolder(fi, folders[0]);
            AddToFolder(folders[0], folders[1]);
            AddToFolder(folders[1], folders[2]);
            AddToFolder(folders[2], folders[3]);
            AddToFolder(folders[3], files[0]);
            AddToFolder(fi, folders[4]);
            AddToFolder(folders[4], folders[5]);
            AddToFolder(folders[4], files[1]);
            AddToFolder(fi, folders[6]);
            AddToFolder(folders[6], files[2]);
            AddToFolder(folders[6], files[3]);
            AddToFolder(folders[6], files[4]);
            AddToFolder(fi, folders[7]);
            AddToFolder(folders[7], folders[8]);
            AddToFolder(folders[8], files[5]);
            AddToFolder(folders[8], files[6]);
            AddToFolder(folders[7], files[7]);
            AddToFolder(fi, folders[9]);
            AddToFolder(folders[9], files[8]);
            AddToFolder(folders[9], files[9]);
            AddToFolder(folders[9], files[10]);
            AddToFolder(fi, files[11]);
            AddToFolder(fi, files[12]);
            return new FileStructure(fi);
        }
        private static void AddToFolder(FileItem addTo, FileItem toAdd)
        {
            addTo.SubItems.Add(toAdd);
            toAdd.PerantID = addTo.ID;
        }
        private static FileItem GetNewFile(bool isNull, int PerantId)
        {
            if (isNull)
                return null;
            FileType t = new FileType
            {
                ID = 2,
                IconClass = @"Images\FileType\docx.png",
                Exstention = "doc",
                Description = "Word 2003 file"
            };

            FileItem fi = new FileItem
            {
                FileName = "file" + item + ".doc",
                ID = item,
                IsFolder = false,
                OwnerId = 1,
                PerantID = PerantId,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };

            item++;
            return fi;
        }
        private static FileItem GetNewFolder(bool isNull, int PerantId)
        {
            if (isNull)
                return null;
            FileType t = new FileType
            {
                ID = 1,
                IconClass = @"Images\FileType\folder.png",
                Exstention = null,
                Description = "Folder"
            };

            FileItem fi = new FileItem
            {
                FileName = "folder" + item,
                ID = item,
                IsFolder = true,
                OwnerId = 1,
                PerantID = PerantId,
                Rate = 0,
                SubItems = new List<FileItem>(),
                Type = t
            };

            item++;
            return fi;
        } 
        
    }
}
