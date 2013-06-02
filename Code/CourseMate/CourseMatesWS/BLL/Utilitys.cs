using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security;
using System.Web;
using System.Xml;
using System.IO;
using System.Threading;
using CourseMatesWS.DAL.Objects;
using CourseMatesWS.DAL;
using System.Security.Cryptography;
using System.Text;
using System.Configuration;


namespace CourseMatesWS.BLL
{
    public class Utilitys
    {
        //TODO - add file path.
        private static readonly string CourseFilesPath = ConfigurationManager.AppSettings["FilesFolder"];

        public static string GetMd5Hash(string pass)
        {
            try
            {
                MD5 md5Hash = MD5.Create();
                byte[] b = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(pass));

                StringBuilder sb = new StringBuilder();

                foreach (byte item in b)
                {
                    sb.Append(item.ToString("x2"));
                }
                md5Hash.Dispose();
                return sb.ToString();
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        public static string GetUniqueEmail(LinkType type, User user, int courseId = -1)
        {
            string url = "http://coursemate.mooo.com/{0}.aspx?c={1}i={2}&u={3}";
            string unique = GetMd5Hash(user.Email);
            url = string.Format(url, type.ToString(), courseId, user.ID, unique);
            return url;
        }

        public static string SaveFileOnServer(Stream stream, string postFix)
        {
            try
            {
                string fileName = GetNewFileName();
                using (FileStream outfile = new FileStream(CourseFilesPath + fileName, FileMode.Create))
                {
                    const int bufferSize = 65536;

                    Byte[] buffer = new Byte[bufferSize];
                    int bytesRead = stream.Read(buffer, 0, bufferSize);

                    while (bytesRead > 0)
                    {
                        outfile.Write(buffer, 0, bytesRead);
                        bytesRead = stream.Read(buffer, 0, bufferSize);
                    }
                }
                return fileName;
            }
            catch (Exception)
            {
                return null;
            }
        }

        private static string GetNewFileName()
        {
            string fileName = Guid.NewGuid().ToString();

            while (File.Exists(CourseFilesPath + fileName))
            {
                fileName = Guid.NewGuid().ToString();
            }

            return fileName;
        }

        public static void DeletePhysicalFile(string physicalFile)
        {
            try
            {
                if (File.Exists(CourseFilesPath + physicalFile))
                    File.Delete(CourseFilesPath + physicalFile);
            }
            catch (Exception)
            {
            }
        }
    }
}