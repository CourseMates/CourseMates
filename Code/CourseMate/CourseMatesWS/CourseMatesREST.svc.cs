using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using CourseMatesWS.DAL.Objects;
using CourseMatesWS.BLL;
using CourseMatesWS.DAL;

namespace CourseMatesWS
{
    public class CourseMatesREST : ICourseMatesREST
    {
        public string LoginREST(string userName, string password, out int id)
        {
            return CMDal.LogIn(userName, password, out id);
        }

        public List<Course> GetCourseByUserIdREST(string sessionId, string userId)
        {
            int x;
            int.TryParse(userId, out x);
            return CMDal.GetCourseByUserId(sessionId, x);
        }

        public bool RegisterREST(User user, out int userId, out string sessionId)
        {
            sessionId = string.Empty;
            SQLStatus status = CMDal.RegisterNewUser(user, out userId);

            if (status == SQLStatus.Succeeded)
            {
                sessionId = CMDal.GetNewSession(userId);
                return true;
            }
            return false;
        }

        public FileStructure GetCourseFilesREST(string sessionId, string userId, string courseId)
        {
            int cid, uid;
            int.TryParse(courseId, out cid);
            int.TryParse(userId, out uid);
            return CMDal.GetCourseFiles(sessionId, uid, cid);
        }

        public List<User> GetCoursePartisipantREST(string sessionId, string userId, string courseId)
        {
            int cid, uid;
            int.TryParse(courseId, out cid);
            int.TryParse(userId, out uid);
            return CMDal.GetCoursePartisipant(sessionId, uid, cid);
        }

        public Forum GetCourseForumREST(string sessionId, string userId, string courseId)
        {
            int cid, uid;
            int.TryParse(courseId, out cid);
            int.TryParse(userId, out uid);
            return CMDal.GetCourseForum(sessionId, uid, cid);
        }
    }
}
