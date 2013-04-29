using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.BLL.Objects;
using CourseMatesWS.BLL;
using System.IO;

namespace CourseMatesWS
{    
    [ServiceContract]
    public interface ICourseMates
    {
        [OperationContract]
        SessionObj LogIn(string userName, string password);
        [OperationContract]
        int Register(User newUser);
        [OperationContract]
        List<Course> GetCoursesByUserID(string sessionId, int id);
        [OperationContract]
        List<BLL.Objects.FileItem> GetFilesByCourseID(string sessionId, int id);
        [OperationContract]
        List<FourmItem> GetFourmItemByCourseID(string sessionId, int id);
        [OperationContract]
        List<User> GetUsers(string sessionId, string searchStr);

        [OperationContract]
        List<Course> GetCourses(string sessionId, string searchStr);
        [OperationContract]
        bool UpdateCourse(string sessionId, Course course);
        [OperationContract]
        int CreateNewCourse(string sessionId, string courseName, int ownerId);
        [OperationContract]
        bool SendInvitations(string sessionId, int courseId, List<string> usersEmails);
        [OperationContract]
        bool RequestJoinCourse(string sessionId, int courseId, int userId);
        [OperationContract]
        bool ApproveRequest(string sessionId, int toApprove, bool isApprove);
        [OperationContract]
        bool DeleteCourse(string sessionId, int courseId, int ownerId);

        [OperationContract]
        bool AddNewFile(string sessionId, string fileName, FileType type, string logicalPath, Stream file);
        [OperationContract]
        Stream GetFile(string sessionId, int fileId);
        [OperationContract]
        bool RateFile(string sessionId, int fileId, int rateing);
        [OperationContract]
        bool UpdateFile(string sessionId, int fileId, Stream updatedFile, FileType type);
        [OperationContract]
        bool DeleteFile(string sessionId, int fileId, int ownerId);

        [OperationContract]
        bool SubmitFourmItem(string sessionId, FourmItem item);
        [OperationContract]
        bool RateFourmItem(string sessionId, int fourmItemId, int rateing);
        [OperationContract]
        bool DeleteFourmItem(string sessionId, int fourmItemId, int ownerId);
    }
}
