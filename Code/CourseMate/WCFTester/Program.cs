using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using System.Security.Cryptography;
using WCFTester.ServiceReference1;


namespace WCFTester
{
    class Program
    {
        static void Main(string[] args)
        {
            CourseMatesClient client = new CourseMatesClient();
            string session;
            int userId;
            session = client.Login("boby", GetMd5Hash("12345678"), out userId);
            object o =client.GetCourseFiles(session, userId, 20);          
        }

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
