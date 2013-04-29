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


namespace CourseMatesWS.BLL
{
    public class Utilitys
    {
        public static void SendMail(string to, string subject, string body)
        {
            try
            {
                const string fromPassword = "jcese123@";
                string mailFrom = "coursemates1@gmail.com";
                string smtpStr = "smtp.gmail.com";

                AlternateView view = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                LinkedResource img = new LinkedResource(@"C:\Users\Ben\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\Images\Logo.png", "image/jpg");
                img.ContentId = "logo";
                img.TransferEncoding = System.Net.Mime.TransferEncoding.Base64;
                view.LinkedResources.Add(img);

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(mailFrom, "CourseMates");
                string[] toList = to.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string tos in toList)
                {
                    mail.To.Add(new MailAddress(tos));
                }

                mail.AlternateViews.Add(view);
                mail.Subject = subject;
                SmtpClient smtp = new SmtpClient(smtpStr);
                smtp.Credentials = new NetworkCredential(mailFrom, fromPassword);
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.Port = 587;
                smtp.EnableSsl = true;
                smtp.Send(mail);
                smtp.Dispose();
            }
            catch (Exception)
            {

            }
        }

        public static string GetEmailTamplateByType(EmailType type)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(@"C:\Users\Ben\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\EmailsTemplate.xml");
                string mainTemplate = doc.GetElementsByTagName("MainTemplate")[0].InnerText;
                string content = doc.GetElementsByTagName(type.ToString())[0].InnerText;

                return string.Format(mainTemplate, content);
            }
            catch (Exception)
            {

            }
            return string.Empty;
        }    
    }
}