using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using CourseMatesWS.BLL.Objects;
using System.Data;
using CourseMatesWS.BLL;

namespace CourseMatesWS.DAL
{
    public class CMDal
    {
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["MainDB"].ToString();

        public static SessionObj GetNewSession(string name, string password)
        {
            string guid = Guid.NewGuid().ToString();
            SessionObj toReturn = new SessionObj() { UserID = -1, SessionID = null };
            DataTable table =  new DataAccess(ConnectionString).ExecuteQuerySP("LogIn", "@userName",name,"@password",password,"@guid",guid);
            if (table != null && table.Rows.Count > 0)
            {
                string id = table.Rows[0]["Id"].ToString();
                if (id != "-1")
                {
                    int iId = -1;
                    if (int.TryParse(id, out iId))
                    {
                        toReturn.UserID = iId;
                        toReturn.SessionID = guid;
                    }
                }
            }
            return toReturn;
        }

        public static int CreateNewUser(User newUser)
        {
            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("InsertNewUser",
                "@firstName", newUser.FirstName,
                "@lastName", newUser.LastName,
                "@email", newUser.Email,
                "@userName", newUser.UserName,
                "@password", newUser.Password,
                "@GCMId", newUser.GCMId);
            if (table != null && table.Rows.Count > 0)
            {
                int id = ParseCellDataToInt(table.Rows[0]["id"]);
                return id;
            }
            return -1;
        }

        public static List<FileItem> GetFilesByCourseID(string sessionId, int id)
        {
            List<FileItem> files = new List<FileItem>();
            
            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetFilesByCourseID",
                "@sessionId", sessionId,
                "@courseId", id);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    FileItem f = new FileItem();
                    User u = new User();

                    f.FileName = ParseCellDataToString(row["FileName"]);
                    f.ID = ParseCellDataToInt(row["FileId"]);
                    f.LogicalPath = ParseCellDataToString(row["LogicalPath"]);
                    f.Rate = ParseCellDataToInt(row["Rate"]);
                    f.Type = ParseCellDataToFileType(row["FileType"]);

                    u.ID = ParseCellDataToInt(row["OwnerId"]);
                    u.FirstName = ParseCellDataToString(row["OwnerFirstName"]);
                    u.LastName = ParseCellDataToString(row["OwnerLastName"]);
                    u.UserName = ParseCellDataToString(row["OwnerUserName"]);
                    u.Email = ParseCellDataToString(row["OwnerEmail"]);
                    u.GCMId = ParseCellDataToString(row["OwnerGCMId"]);
                    f.Owner = u;

                    files.Add(f);
                }
            }

            return files;
        }

        public static List<FourmItem> GetFourmItemByCourseID(string sessionId, int id)
        {
            List<FourmItem> fourmItem = new List<FourmItem>();

            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetFourmItemByCourseID",
                "@sessionId", sessionId,
                "@fourmItemId", id);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    FourmItem f = new FourmItem();
                    User u = new User();

                    f.ID = ParseCellDataToInt(row["FileId"]);
                    f.Title = ParseCellDataToString(row["Title"]);
                    f.Content = ParseCellDataToString(row["Content"]);
                    f.PerentId = ParseCellDataToInt(row["PerentId"]);
                    f.Rate = ParseCellDataToInt(row["Rate"]);

                    u.ID = ParseCellDataToInt(row["OwnerId"]);
                    u.FirstName = ParseCellDataToString(row["OwnerFirstName"]);
                    u.LastName = ParseCellDataToString(row["OwnerLastName"]);
                    u.UserName = ParseCellDataToString(row["OwnerUserName"]);
                    u.Email = ParseCellDataToString(row["OwnerEmail"]);
                    u.GCMId = ParseCellDataToString(row["OwnerGCMId"]);
                    f.Owner = u;

                    fourmItem.Add(f);
                }
            }

            return fourmItem;
        }

        public static List<Course> GetCoursesByUserID(string sessionId, int id)
        {
            List<Course> courses = new List<Course>();

            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetCoursesByUserID",
                "@sessionId", sessionId,
                "@userId", id);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    Course c = new Course();
                    User u = new User();

                    c.ID = ParseCellDataToInt(row["FileId"]);
                    c.CourseName = ParseCellDataToString(row["CourseName"]);
                    c.Files = GetFilesByCourseID(sessionId, c.ID);
                    c.FourmItems = GetFourmItemByCourseID(sessionId, c.ID);
                    c.Participants = GetCourseParticipants(c.ID);

                    u.ID = ParseCellDataToInt(row["OwnerId"]);
                    u.FirstName = ParseCellDataToString(row["OwnerFirstName"]);
                    u.LastName = ParseCellDataToString(row["OwnerLastName"]);
                    u.UserName = ParseCellDataToString(row["OwnerUserName"]);
                    u.Email = ParseCellDataToString(row["OwnerEmail"]);
                    u.GCMId = ParseCellDataToString(row["OwnerGCMId"]);
                    c.CourseAdmin = u;

                    courses.Add(c);
                }
            }

            return courses;
        }
        
        public static List<User> GetUsers(string sessionId, string searchStr)
        {
            List<User> users = new List<User>();

            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetUsersBySearchString",
                "@searchStr", searchStr);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    User u = new User();
                    u.ID = ParseCellDataToInt(row["Id"]);
                    u.FirstName = ParseCellDataToString(row["FirstName"]);
                    u.LastName = ParseCellDataToString(row["LastName"]);
                    u.UserName = ParseCellDataToString(row["UserName"]);
                    u.Email = ParseCellDataToString(row["Email"]);
                    u.GCMId = ParseCellDataToString(row["GCMId"]);

                    users.Add(u);
                }
            }

            return users;
        }
        
        public static List<Course> GetCourses(string sessionId, string searchStr)
        {
            List<Course> courses = new List<Course>();

            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetCoursesBySearchString",
                "@searchStr", searchStr);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    Course c = new Course();
                    c.ID = ParseCellDataToInt(row["Id"]);
                    c.CourseName = ParseCellDataToString(row["CourseName"]);
                    
                    courses.Add(c);
                }
            }

            return courses;
        }
        
        private static List<User> GetCourseParticipants(int id)
        {
            List<User> participants = new List<User>();

            DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("GetCourseParticipants",
                "@id", id);

            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    User u = new User();
                    u.ID = ParseCellDataToInt(row["Id"]);
                    u.FirstName = ParseCellDataToString(row["FirstName"]);
                    u.LastName = ParseCellDataToString(row["LastName"]);
                    u.UserName = ParseCellDataToString(row["UserName"]);
                    u.Email = ParseCellDataToString(row["Email"]);
                    u.GCMId = ParseCellDataToString(row["GCMId"]);

                    participants.Add(u);
                }
            }

            return participants;
        }
        #region Parssing Methods
        private static int ParseCellDataToInt(object toConvert)
        {
            if (toConvert == null)
                return -1;

            int x;
            if (int.TryParse(toConvert.ToString(), out x))
                return x;
            return -1;
        }
        private static string ParseCellDataToString(object toConvert)
        {
            if (toConvert == null)
                return null;

            return toConvert.ToString();
        }
        private static DateTime? ParseCellDataToDateTime(object toConvert)
        {
            if (toConvert == null)
                return null;

            DateTime t;
            if (DateTime.TryParse(toConvert.ToString(), out t))
                return t;
            return null;
        }
        private static FileType ParseCellDataToFileType(object toConvert)
        {
            if (toConvert == null)
                return FileType.Unknown;

            FileType ft;
            if (Enum.TryParse(toConvert.ToString(), out ft))
                return ft;
            return FileType.Unknown;
        }
        #endregion
    }
    
    
}