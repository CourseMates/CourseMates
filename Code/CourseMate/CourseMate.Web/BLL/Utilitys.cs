using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace CourseMate.Web.BLL
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
    }
}