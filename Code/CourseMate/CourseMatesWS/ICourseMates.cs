using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.DAL.Objects;
using CourseMatesWS.BLL;
using System.IO;

namespace CourseMatesWS
{    
    [ServiceContract]
    public interface ICourseMates
    {
        [OperationContract]
        
        string Login(string userName, string password, out int id);
        [OperationContract]
        SQLStatus Register(User user, out int userId, out string sessionId);
        [OperationContract]
        bool SendRestorePassword(string toSend);
        [OperationContract]
        int CreateNewCourse(string sessionId, int userId, string courseName, string iconCls);
        [OperationContract]
        List<Course> GetCoursesByUserId(string sessionId, string userId);
        [OperationContract]
        void UploadFile(UploadFileMsg msg);
        [OperationContract]
        FileStructure GetCourseFiles(string sessionId, int userId, int courseId);
        [OperationContract]
        DeleteStatus DeleteFile(string sessionId, int userId, int fileId);
        [OperationContract]
        RemoteFileInfoMsg GetFile(DownloadRequestMsg req);
        [OperationContract]
        List<User> GetCoursePartisipant(string sessionId, int userId, int courseId);
        [OperationContract]
        bool UpdateCourse(string sessionId, int userId, int courseId, string courseName, string iconCls);
        [OperationContract]
        bool SetUserAsCourseAdmin(string sessionId, int userId, int courseId, int setUserId);
        [OperationContract]
        bool DeleteCourse(string sessionId, int userId, int courseId);
        [OperationContract]
        bool RemoveUserFromCourse(string sessionId, int userId, int courseId, int deleteUserId);
        [OperationContract]
        List<string> GetTop15Users(string search);
        [OperationContract]
        bool AddUserToCourse(string sessionId, int userId, int courseId, string userToAdd);
        [OperationContract]
        Forum GetCourseForum(string sessionId, int userId, int courseId);
        [OperationContract]
        bool AddNewForumItem(string sessionId, int userId, ForumItem item);
        [OperationContract]
        bool DeleteForumItem(string sessionId, int userId, int courseId, int itemId);
        [OperationContract]
        bool ChangeEmail(string sessionId, int userId, string oldEmail, string newEmail);
        [OperationContract]
        bool ChangePassword(string sessionId, int userId, string oldPass, string newPass);
        [OperationContract]
        bool RateFile(string sessionId, int userId, int fileId, int rate);
        [OperationContract]
        bool RateForumItem(string sessionId, int userId, int itemId, int rate);
    }
    [MessageContract]
    public class UploadFileMsg
    {
        [MessageHeader]
        public string SessionId { get; set; }
        [MessageHeader]
        public int UserId { get; set; }
        [MessageHeader]
        public int CourseId { get; set; }
        [MessageHeader]
        public string FileName { get; set; }
        [MessageHeader]
        public int ParentId { get; set; }
        [MessageHeader]
        public int Size { get; set; }
        [MessageHeader]
        public FileTypeE TypeId { get; set; }
        [MessageHeader]
        public bool IsFolder { get; set; }
        [MessageBodyMember]
        public Stream FileStream;
    }

    [MessageContract]
    public class RemoteFileInfoMsg
    {
        [MessageHeader]
        public string FileName { get; set; }
        [MessageHeader]
        public int Size { get; set; }
        [MessageBodyMember]
        public Stream FileStream;
    }

    [MessageContract]
    public class DownloadRequestMsg
    {
        [MessageHeader]
        public string SessionId { get; set; }
        [MessageHeader]
        public int UserId { get; set; }
        [MessageHeader]
        public int FileId { get; set; }
    }
}
