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
using System.Web.Script.Serialization;

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

        public List<Course> GetCoursesByUserId(string sessionId, string userId)
        {
            int x;
            int.TryParse(userId, out x);
            return CMDal.GetCourseByUserId(sessionId, x);
        }

        public FileStructure GetCourseFiles(string sessionId, int userId, int courseId)
        {
            return CMDal.GetCourseFiles(sessionId, userId, courseId);
        }

        public void UploadFile(UploadFileMsg msg)
        {
            string name = null;
            if (!msg.IsFolder)
            {
                string p = msg.FileName.Split('.').Last();
                name = Utilitys.SaveFileOnServer(msg.FileStream, p);
            }
            FileItem fi = new FileItem()
            {
                FileName = msg.FileName,
                OwnerId = msg.UserId,
                PerantID = msg.ParentId,
                Rate=0,
                SubItems = null,
                Type = new FileType
                {
                    ID = (int)msg.TypeId
                },
                Size = msg.Size,
                IsFolder = msg.IsFolder
            };

            CMDal.AddNewFile(msg.SessionId, msg.UserId, name, msg.CourseId, fi);
        }

        public DeleteStatus DeleteFile(string sessionId, int userId, int fileId)
        {
            string physicalFile;
            DeleteStatus status = CMDal.DeleteFile(sessionId, userId, fileId, out physicalFile);

            if (status == DeleteStatus.Success)
                Utilitys.DeletePhysicalFile(physicalFile);
            
            return status;
        }

        public RemoteFileInfoMsg GetFile(DownloadRequestMsg req)
        {
            string fileName;
            Stream s = CMDal.GetFileStream(req.SessionId, req.UserId, req.FileId ,out fileName);

            RemoteFileInfoMsg result = new RemoteFileInfoMsg();
            result.FileStream = s;
            result.Size = (int) s.Length;
            result.FileName = fileName;

            return result;
        }
        
        public List<User> GetCoursePartisipant(string sessionId, int userId, int courseId)
        {
            return CMDal.GetCoursePartisipant(sessionId, userId, courseId);
        }

        public bool UpdateCourse(string sessionId, int userId, int courseId, string courseName, string iconCls)
        {
            return CMDal.UpdateCourse(sessionId, userId, courseId, courseName, iconCls);
        }

        public bool SetUserAsCourseAdmin(string sessionId, int userId, int courseId, int setUserId)
        {
            return CMDal.SetUserAsCourseAdmin(sessionId, userId, courseId, setUserId);
        }

        public bool DeleteCourse(string sessionId, int userId, int courseId)
        {
            List<string> paths = CMDal.GetAllPhysicalFiles(courseId);

            if (CMDal.DeleteCourse(sessionId, userId, courseId))
            {
                foreach (string path in paths)
                {
                    Utilitys.DeletePhysicalFile(path);
                }
                return true;
            }
            return false;
        }

        public bool RemoveUserFromCourse(string sessionId, int userId, int courseId, int deleteUserId)
        {
            return CMDal.RemoveUserFromCourse(sessionId, userId, courseId, deleteUserId);
        }

        public List<string> GetTop15Users(string search)
        {
            return CMDal.GetTop15Users(search);
        }
        
        public bool AddUserToCourse(string sessionId, int userId, int courseId, string userToAdd)
        {
            return CMDal.AddUserToCourse(sessionId, userId, courseId, userToAdd);
        }
        
        public Forum GetCourseForum(string sessionId, int userId, int courseId)
        {
            return CMDal.GetCourseForum(sessionId, userId, courseId);
        }
        
        public bool AddNewForumItem(string sessionId, int userId, ForumItem item)
        {
            return CMDal.AddNewForumItem(sessionId, userId, item);
        }
        public bool DeleteForumItem(string sessionId, int userId, int courseId, int itemId)
        {
            return CMDal.DeleteForumItem(sessionId, userId, courseId, itemId);
        }
        
        public bool ChangeEmail(string sessionId, int userId, string oldEmail, string newEmail)
        {
            return CMDal.ChangeEmail(sessionId, userId, oldEmail, newEmail);
        }

        public bool ChangePassword(string sessionId, int userId, string oldPass, string newPass)
        {
            return CMDal.ChangePassword(sessionId, userId, oldPass, newPass);
        }
        
        public bool RateFile(string sessionId, int userId, int fileId, int rate)
        {
            return CMDal.RateFile(sessionId, userId, fileId, rate);
        }

        public bool RateForumItem(string sessionId, int userId, int itemId, int rate)
        {
            return CMDal.RateForumItem(sessionId, userId, itemId, rate);
        }
        #endregion
        #region REST
        public string LoginREST(string userName, string password, out int id)
        {
            return Login(userName, password, out id);
        }

        public List<Course> GetCourseByUserIdREST(string sessionId, string userId)
        {
            return GetCoursesByUserId(sessionId, userId);
        }

        public bool RegisterREST(User user, out int userId, out string sessionId)
        {
            SQLStatus status = Register(user, out userId, out sessionId);

            if (status == SQLStatus.Succeeded)
                return true;

            return false;
        }
        #endregion








        
    }
}
