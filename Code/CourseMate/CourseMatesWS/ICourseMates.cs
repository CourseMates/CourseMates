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
        List<Course> GetCourseByUserId(string sessionId, int userId);
    }
}
