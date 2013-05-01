using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using CourseMatesWS.DAL.Objects;
using System.Data;
using CourseMatesWS.BLL;

namespace CourseMatesWS.DAL
{
    public class CMDal
    {
        public static readonly string ConnectionString = ConfigurationManager.ConnectionStrings["MainDB"].ToString();

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