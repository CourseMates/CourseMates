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
        List<Course> GetCourseByUserId(string sessionId, string userId);
        [OperationContract]
        void UploadFile(UploadFileMsg msg);
        [OperationContract]
        FileStructure GetCourseFiles(int courseId);
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
        public int TypeId { get; set; }
        [MessageBodyMember]
        public Stream FileStream;
    }
}
