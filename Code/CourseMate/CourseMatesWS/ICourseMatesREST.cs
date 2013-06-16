using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;
using CourseMatesWS.DAL.Objects;

namespace CourseMatesWS
{
    [ServiceContract]
    public interface ICourseMatesREST
    {
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, RequestFormat = WebMessageFormat.Json, UriTemplate = "/login/{userName}/{password}", Method = "GET")]
        string LoginREST(string userName, string password, out int id);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCourseByUserId/{sessionId}/{userId}", Method = "GET")]
        List<Course> GetCourseByUserIdREST(string sessionId, string userId);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCourseFiles/{sessionId}/{userId}/{courseId}", Method = "GET")]
        FileStructure GetCourseFilesREST(string sessionId, string userId, string courseId);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCoursePartisipant/{sessionId}/{userId}/{courseId}", Method = "GET")]
        List<User> GetCoursePartisipantREST(string sessionId, string userId, string courseId);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCourseForum/{sessionId}/{userId}/{courseId}", Method = "GET")]
        Forum GetCourseForumREST(string sessionId, string userId, string courseId);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.WrappedResponse, RequestFormat = WebMessageFormat.Json, UriTemplate = "/Register", Method = "POST")]
        bool RegisterREST(User stream, out int userId, out string sessionId);
    }
}
