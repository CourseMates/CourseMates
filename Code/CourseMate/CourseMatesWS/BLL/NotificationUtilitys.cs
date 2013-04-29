using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Xml;
using CourseMatesWS.DAL.Objects;
using System.Net;

namespace CourseMatesWS.BLL
{
    public class NotificationUtilitys
    {
        private static void SendMail(string to, string subject, string body)
        {
            try
            {
                const string fromPassword = "jcese123@";
                string mailFrom = "coursemates1@gmail.com";
                string smtpStr = "smtp.gmail.com";

                AlternateView view = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                LinkedResource img = new LinkedResource(@"C:\Users\bohana\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\Images\Logo.png", "image/jpg");
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

        private static string GetEmailTamplateByType(EmailType type)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(@"C:\Users\bohana\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\EmailsTemplate.xml");
                string mainTemplate = doc.GetElementsByTagName("MainTemplate")[0].InnerText;
                string content = doc.GetElementsByTagName(type.ToString())[0].InnerText;

                return string.Format(mainTemplate, content);
            }
            catch (Exception)
            {

            }
            return string.Empty;
        }

        public static void SendCourseInvitaions(List<User> sendTo, string courseName, string link)
        {
            foreach (User user in sendTo)
            {
                string template = GetEmailTamplateByType(EmailType.Invitation);
                template = string.Format(template, user.UserName, courseName, link);
                SendMail(user.Email, "You Have Invited to " + courseName, template);
            }
        }

        public static void SendVerifyMail(User sendTo, string link)
        {
            string template = GetEmailTamplateByType(EmailType.Verify);
            template = string.Format(template, sendTo.UserName, link);
            SendMail(sendTo.Email, "Verify Your Email", template);
        }

        public static void SendAddNewFileNotification(List<User> sendTo, FileItem file, string courseName)
        {
            foreach (User user in sendTo)
            {
                string template = GetEmailTamplateByType(EmailType.NewFile);
                template = string.Format(template, user.UserName, file.Owner.UserName, courseName, file.FileName);
                SendMail(user.Email, "New File Added to " + courseName, template);
            }
        }

        public static void SendUpdateFileNotification(List<User> sendTo, FileItem file, string courseName)
        {
            foreach (User user in sendTo)
            {
                string template = GetEmailTamplateByType(EmailType.FileUpdate);
                template = string.Format(template, user.UserName, file.Owner.UserName, courseName, file.FileName);
                SendMail(user.Email, "File Updated on " + courseName, template);
            }
        }

        public static void SendApproveRequest(User courseOwner, string courseName, User requestBy)
        {
            string template = GetEmailTamplateByType(EmailType.ApproveRequest);
            template = string.Format(template, courseOwner.UserName,requestBy.UserName, courseName);
            SendMail(courseOwner.Email, "Your Action Is Required", template);
        }

        public static void SendQandANotification(List<User> sendTo, FourmItem fi, string courseName)
        {
            foreach (User user in sendTo)
            {
                string template = GetEmailTamplateByType(EmailType.QAndA);
                template = string.Format(template, user.UserName, fi.Owner.UserName, courseName, fi.Title, fi.Content);
                SendMail(user.Email, "Fourm update at " + courseName, template);
            }
        }
    }
}