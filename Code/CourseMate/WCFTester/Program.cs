using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Net;
using System.Security.Cryptography;


namespace WCFTester
{
    class Program
    {
        static void Main(string[] args)
        {
            //CourseMatesClient client = new CourseMatesClient();
            //string session;
            //int userId;
            //session = client.Login("boby", GetMd5Hash("12345678"), out userId);

            //int courseId = 21;


            //using (Stream s = client.GetFile(session, userId, courseId))
            //{
            //    using (FileStream fileStream = System.IO.File.Create(@"C:\Users\bohana\Desktop\123.pdf"))
            //    {
            //        int x;
            //        byte[] bytesInStream = new byte[65000];
            //        do
            //        {
            //            x = s.Read(bytesInStream, 0, (int)bytesInStream.Length);
            //            fileStream.Write(bytesInStream, 0, bytesInStream.Length);
            //        } while (x > 0);
            //    }
            //}            
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
