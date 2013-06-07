using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Mail;
using System.Xml;
using CourseMatesWS.DAL.Objects;
using System.Net;
using CourseMatesWS.DAL;

namespace CourseMatesWS.BLL
{
    /// <summary>
    /// Handle CourseMates notification.
    /// </summary>
    public class NotificationUtilitys
    {
        /// <summary>
        /// Send email with html body.
        /// The email send by Gmail SMTP.
        /// </summary>
        /// <param name="to">Emails sperated with ';' that the mail will send to.</param>
        /// <param name="subject">The subject of the email.</param>
        /// <param name="body">The HTML content of the email.</param>
        public static void SendMail(string to, string subject, string body)
        {
            try
            {
                const string fromPassword = "jcese123@";
                string mailFrom = "coursemates1@gmail.com";
                string smtpStr = "smtp.gmail.com";

                AlternateView view = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                string path = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath;
                LinkedResource img = new LinkedResource(path + @"\Images\Logo.png", "image/jpg");
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
        /// <summary>
        /// Get CourseMate email tamplate.
        /// </summary>
        /// <param name="type">Enumartion of all avalible email tamplate.</param>
        /// <returns>HTML email template.</returns>
        private static string GetEmailTamplateByType(EmailType type)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                string path = System.Web.Hosting.HostingEnvironment.ApplicationPhysicalPath;
                doc.Load(path + @"\EmailsTemplate.xml");
                string mainTemplate = doc.GetElementsByTagName("MainTemplate")[0].InnerText;
                string content = doc.GetElementsByTagName(type.ToString())[0].InnerText;

                return string.Format(mainTemplate, content);
            }
            catch (Exception)
            {

            }
            return string.Empty;
        }
        /// <summary>
        /// Send course invitaion.
        /// </summary>
        /// <param name="sendTo">The user you want to send to</param>
        /// <param name="courseName">The course name the user invite to.</param>
        public static void SendCourseInvitaions(List<User> sendTo, string courseName)
        {
            foreach (User user in sendTo)
            {
                if (user != null)
                {
                    string template = GetEmailTamplateByType(EmailType.Invitation);
                    template = string.Format(template, user.UserName, courseName, Utilitys.GetUniqueEmail(LinkType.JoinCourse, user));
                    SendMail(user.Email, "You Have Invited to " + courseName, template); 
                }
            }
        }
        /// <summary>
        /// Send verification email to user.
        /// </summary>
        /// <param name="sendTo">The user that the email send to.</param>
        public static void SendVerifyMail(User sendTo)
        {
            if (sendTo == null)
                return;
            string template = GetEmailTamplateByType(EmailType.Verify);
            template = string.Format(template, sendTo.UserName, Utilitys.GetUniqueEmail(LinkType.EmailVerify, sendTo));
            SendMail(sendTo.Email, "Verify Your Email", template);
        }
        /// <summary>
        /// Send add new file email notification to list of users
        /// </summary>
        /// <param name="sendTo">The lise of user this mail will be send to.</param>
        /// <param name="file">The new file properties/</param>
        /// <param name="courseName">The course name that the file added.</param>
        public static void SendAddNewFileNotification(List<User> sendTo, FileItem file, string courseName)
        {
            if (file == null)
                return;
            foreach (User user in sendTo)
            {
                if (user != null)
                {
                    User owner = CMDal.GetUserBy("Id", file.OwnerId);
                    string template = GetEmailTamplateByType(EmailType.NewFile);
                    template = string.Format(template, user.UserName, owner.UserName, courseName, file.FileName);
                    SendMail(user.Email, "New File Added to " + courseName, template); 
                }
            }
        }
        /// <summary>
        /// Send notification email that a given file was updated to a list of user.
        /// </summary>
        /// <param name="sendTo">The list of user that the email send to.</param>
        /// <param name="file">The new file properties</param>
        /// <param name="courseName">The course name that the file updated</param>
        public static void SendUpdateFileNotification(List<User> sendTo, FileItem file, string courseName)
        {
            if (file == null)
                return;
            foreach (User user in sendTo)
            {
                if (user != null)
                {
                    User owner = CMDal.GetUserBy("Id", file.OwnerId);
                    string template = GetEmailTamplateByType(EmailType.FileUpdate);
                    template = string.Format(template, user.UserName, owner.UserName, courseName, file.FileName);
                    SendMail(user.Email, "File Updated on " + courseName, template); 
                }
            }
        }
        /// <summary>
        /// Send course owner request for join his course.
        /// </summary>
        /// <param name="course">The course details.</param>
        /// <param name="requestBy">the user that request join the course.</param>
        public static void SendApproveRequest(Course course, User requestBy)
        {
            if (course == null || requestBy == null)
                return;
            User user = CMDal.GetUserBy("Id", course.CourseAdminID);
            string template = GetEmailTamplateByType(EmailType.ApproveRequest);
            template = string.Format(template, user.UserName,requestBy.UserName, course.CourseName);
            SendMail(user.Email, "Your Action Is Required", template);
        }
        /// <summary>
        /// Send email notification when new fourm item submited.
        /// </summary>
        /// <param name="sendTo">The user list that will get the email.</param>
        /// <param name="fi">the FourmItem propertise</param>
        /// <param name="courseName">The course name that the FourmItem was submited.</param>
        public static void SendQandANotification(List<User> sendTo, ForumItem fi, string courseName)
        {
            if (fi == null)
                return;
            foreach (User user in sendTo)
            {
                if (user != null)
                {
                    string template = GetEmailTamplateByType(EmailType.QAndA);
                    template = string.Format(template, user.UserName, fi.OwnerName, courseName, fi.Title, fi.Content);
                    SendMail(user.Email, "Fourm update at " + courseName, template); 
                }
            }
        }
        /// <summary>
        /// Send reset passowrd email.
        /// </summary>
        /// <param name="user">The user need password reset.</param>
        public static void SendResetPasswordEmail(User sendTo)
        {
            if (sendTo == null)
                return;
            string template = GetEmailTamplateByType(EmailType.ResetPassword);
            template = string.Format(template, sendTo.UserName, Utilitys.GetUniqueEmail(LinkType.ResetPassword, sendTo));
            SendMail(sendTo.Email, "Reset Password", template);
        }
    }
}