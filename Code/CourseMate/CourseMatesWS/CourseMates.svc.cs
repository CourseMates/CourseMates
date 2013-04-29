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

namespace CourseMatesWS
{
    public class CourseMates : ICourseMates
    {
        #region Done
        /// <summary>
        /// 
        /// </summary>
        /// <param name="userName"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        public SessionObj LogIn(string userName, string password)
        {
            string link = "http://www.google.com";
            User u1 = new User() 
            { 
                UserName="Benoh1",
                Email = "ben.ohana1@gmail.com",
            };
            User u2 = new User()
            {
                UserName = "Bohana",
                Email = "ben.ohana1@gmail.com",
            };
            Course c1 = new Course()
            {
                CourseName = "Sofware Engeneering",
                CourseAdmin = u1,
            };
            FourmItem fi = new FourmItem()
            {
                Title = "I Need Help....",
                Content = "i need the answer to question nubmer 3 in the latest ex.....please help me.....",
                Owner = u2
            };
            FileItem f = new FileItem()
            {
                FileName="Last Year Notes.PDF",
                Owner = u1,
                Type = FileType.PDF
            };

            NotificationUtilitys.SendAddNewFileNotification(new List<User> { u1 }, f, c1.CourseName);
            NotificationUtilitys.SendApproveRequest(u1, c1.CourseName, u2);
            NotificationUtilitys.SendCourseInvitaions(new List<User> { u2 }, c1.CourseName, link);
            NotificationUtilitys.SendQandANotification(new List<User> { u1 }, fi, c1.CourseName);
            NotificationUtilitys.SendUpdateFileNotification(new List<User> { u2 }, f, c1.CourseName);
            NotificationUtilitys.SendVerifyMail(u2, link);

            return null;// CMDal.GetNewSession(userName, password);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="newUser"></param>
        /// <returns></returns>
        public int Register(User newUser)
        {
            return CMDal.CreateNewUser(newUser);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<FileItem> GetFilesByCourseID(string sessionId, int id)
        {
            return CMDal.GetFilesByCourseID(sessionId, id);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<FourmItem> GetFourmItemByCourseID(string sessionId, int id)
        {
            return CMDal.GetFourmItemByCourseID(sessionId, id);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public List<Course> GetCoursesByUserID(string sessionId, int id)
        {
            return CMDal.GetCoursesByUserID(sessionId, id);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="searchStr"></param>
        /// <returns></returns>
        public List<User> GetUsers(string sessionId, string searchStr)
        {
            return CMDal.GetUsers(sessionId, searchStr);
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="searchStr"></param>
        /// <returns></returns>
        public List<Course> GetCourses(string sessionId, string searchStr)
        {
            return CMDal.GetCourses(sessionId, searchStr);
        }
        #endregion 
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="course"></param>
        /// <returns></returns>
        public bool UpdateCourse(string sessionId, Course course)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="courseName"></param>
        /// <param name="ownerId"></param>
        /// <returns></returns>
        public int CreateNewCourse(string sessionId, string courseName, int ownerId)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="courseId"></param>
        /// <param name="usersEmails"></param>
        /// <returns></returns>
        public bool SendInvitations(string sessionId, int courseId, List<int> usersId)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="courseId"></param>
        /// <param name="userId"></param>
        /// <returns></returns>
        public bool RequestJoinCourse(string sessionId, int courseId, int userId)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="toApprove"></param>
        /// <param name="isApprove"></param>
        /// <returns></returns>
        public bool ApproveRequest(string sessionId, int toApprove, bool isApprove)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="courseId"></param>
        /// <param name="ownerId"></param>
        /// <returns></returns>
        public bool DeleteCourse(string sessionId, int courseId, int ownerId)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fileName"></param>
        /// <param name="type"></param>
        /// <param name="logicalPath"></param>
        /// <param name="file"></param>
        /// <returns></returns>
        //public bool AddNewFile(string sessionId, string fileName, FileType type, string logicalPath, Stream file)
        //{
        //    throw new NotImplementedException();
        //}
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fileId"></param>
        /// <returns></returns>
        public Stream GetFile(string sessionId, int fileId)
        {

            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fileId"></param>
        /// <param name="rateing"></param>
        /// <returns></returns>
        public bool RateFile(string sessionId, int fileId, int rateing)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fileId"></param>
        /// <param name="updatedFile"></param>
        /// <param name="type"></param>
        /// <returns></returns>
        //public bool UpdateFile(string sessionId, int fileId, Stream updatedFile, FileType type)
        //{
    
        //    throw new NotImplementedException();
        //}
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fileId"></param>
        /// <param name="ownerId"></param>
        /// <returns></returns>
        public bool DeleteFile(string sessionId, int fileId, int ownerId)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="item"></param>
        /// <returns></returns>
        public bool SubmitFourmItem(string sessionId, FourmItem item)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fourmItemId"></param>
        /// <param name="rateing"></param>
        /// <returns></returns>
        public bool RateFourmItem(string sessionId, int fourmItemId, int rateing)
        {
            throw new NotImplementedException();
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="sessionId"></param>
        /// <param name="fourmItemId"></param>
        /// <param name="ownerId"></param>
        /// <returns></returns>
        public bool DeleteFourmItem(string sessionId, int fourmItemId, int ownerId)
        {
            throw new NotImplementedException();
        }
    }
}
