using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using CourseMatesWS.DAL.Objects;
using System.Data;
using CourseMatesWS.BLL;
using System.Text;

namespace CourseMatesWS.DAL
{
    public class CMDal
    {
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["MainDB"].ToString();

        #region Parssing Methods
        private static bool ParseCellDataToInt(object toConvert, out int toParse)
        {
            toParse = -1;
            if (toConvert == null)
                return false;

            int x;
            if (int.TryParse(toConvert.ToString(), out x))
                toParse = x;
            else
                return false;
            return true;
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

        private static int GetUserID(string userName, string password)
        {
            try
            {
                DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("SP_GetUserID",
                        "@UserName", userName,
                        "@Password", password);
               if (table == null || table.Rows.Count == 0)
                    return -1;

                int id;
                ParseCellDataToInt(table.Rows[0]["UserId"], out id);
                return id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public static string GetNewSession(int userId)
        {
            try
            {
                string sessionID = Guid.NewGuid().ToString();
                new DataAccess(ConnectionString).ExecuteQuerySP("SP_AddSession",
                    "@UserID", userId,
                    "@SessionID", sessionID);

                return sessionID;
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        public static string LogIn(string userName, string password, out int id)
        {
            id = GetUserID(userName, password);
            if (id > 0)
            {
                InsertNewAction(id, (int)LinkType.EmailVerify);
                NotificationUtilitys.SendVerifyMail(GetUserBy("Id", id));
                return GetNewSession(id);
            }

            return string.Empty;
        }

        public static SQLStatus RegisterNewUser(User user, out int userId)
        {
            userId = -1;
            try
            {
                DataTable table = new DataAccess(ConnectionString).ExecuteQuerySP("SP_Register",
                        "@FirstName", user.FirstName,
                        "@LastName", user.LastName,
                        "@Email", user.Email,
                        "@Password", user.Password,
                        "@GCMid", user.GCMId,
                        "@UserName", user.UserName);
                if (table == null || table.Rows.Count == 0)
                    return SQLStatus.Failed;

                if (!ParseCellDataToInt(table.Rows[0]["UserID"], out userId))
                    return SQLStatus.Failed;
                switch (userId)
                {
                    case -1:
                        return SQLStatus.UserExists;
                    case -2:
                        return SQLStatus.EmailExists;
                    default:
                        return SQLStatus.Succeeded;
                }
            }
            catch (Exception)
            {
                return SQLStatus.Failed;
            }
        }

        public static bool InsertNewAction(int userId, int actionId)
        {
            try
            {
                int x = new DataAccess(ConnectionString).ExecuteNonQuerySP("SP_InsertAction",
                        "@UserID", userId,
                        "@ActioID", actionId);

                return x > 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static User GetUserBy(params object[] parameters)
        {
            StringBuilder query = new StringBuilder("SELECT * FROM tblUser");
            if (parameters.Length < 2)
                return null;

            query.Append(" WHERE ");

            for (int i = 0; i < parameters.Length-1; i++)
            {
                query.Append(parameters[i] + "='" + parameters[i + 1]+"'");
            }

            DataTable table = new DataAccess(ConnectionString).ExecuteQueryDS(query.ToString());
            if (table == null || table.Rows.Count == 0)
                return null;

            int id;
            ParseCellDataToInt(table.Rows[0]["Id"], out id);

            User toReturn = new User()
            {
                ID=id,
                Email =ParseCellDataToString(table.Rows[0]["Email"]),
                FirstName=ParseCellDataToString(table.Rows[0]["FirstName"]),
                LastName = ParseCellDataToString(table.Rows[0]["LastName"]),
                UserName = ParseCellDataToString(table.Rows[0]["UserName"]),
                GCMId = ParseCellDataToString(table.Rows[0]["GCMId"]),
                Password = ParseCellDataToString(table.Rows[0]["Password"])
            };

            return toReturn;
        }
    }
}