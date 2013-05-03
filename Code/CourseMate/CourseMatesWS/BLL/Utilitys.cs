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


namespace CourseMatesWS.BLL
{
    public class Utilitys
    {
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
    }
}