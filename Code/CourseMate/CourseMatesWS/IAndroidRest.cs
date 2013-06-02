using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Web;
using CourseMatesWS.DAL.Objects;
using System.IO;

namespace CourseMatesWS
{
    [ServiceContract]
    public interface IAndroidRest
    {
        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.Wrapped, RequestFormat = WebMessageFormat.Json, UriTemplate = "/login/{userName}/{password}", Method = "GET")]
        string LoginREST(string userName, string password, out int id);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, RequestFormat = WebMessageFormat.Json, UriTemplate = "/GetCourseByUserId/{sessionId}/{userId}", Method = "GET")]
        List<Course> GetCourseByUserIdREST(string sessionId, string userId);

        [OperationContract]
        [WebInvoke(ResponseFormat = WebMessageFormat.Json, BodyStyle = WebMessageBodyStyle.WrappedResponse, RequestFormat = WebMessageFormat.Json, UriTemplate = "/Register", Method = "POST")]
        bool RegisterREST(User stream, out int userId, out string sessionId);
    }
}
