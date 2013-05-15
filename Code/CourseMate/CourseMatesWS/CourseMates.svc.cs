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
    public class CourseMates : ICourseMates
    {
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


        public List<Course> GetCourseByUserId(string sessionId,int userId)
        {
            return CMDal.GetCourseByUserId(sessionId, userId);
        }
    }
}
