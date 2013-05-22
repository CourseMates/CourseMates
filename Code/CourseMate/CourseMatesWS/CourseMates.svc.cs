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
    }
}
