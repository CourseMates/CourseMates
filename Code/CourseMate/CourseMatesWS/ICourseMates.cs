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
        [WebInvoke(ResponseFormat= WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, 
            RequestFormat= WebMessageFormat.Json,UriTemplate="/login/{userName}/{password}", Method="GET" )]
        string Login(string userName, string password, out int id);
        [OperationContract]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.Wrapped)]
        SQLStatus Register(User user, out int userId, out string sessionId);
        [OperationContract]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.Wrapped)]
        bool SendRestorePassword(string toSend);
        [OperationContract]
        [WebInvoke(BodyStyle = WebMessageBodyStyle.Wrapped)]
        int CreateNewCourse(string sessionId, int userId, string courseName, string iconCls);
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, 
            RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCourseByUserId/{sessionId}/{userId}", Method = "GET")]
        List<Course> GetCourseByUserId(string sessionId, string userId);
    }
}
