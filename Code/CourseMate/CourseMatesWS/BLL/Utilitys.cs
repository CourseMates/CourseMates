using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security;
using System.Web;
using System.Xml;
using System.IO;


namespace CourseMatesWS.BLL
{
    public class Utilitys
    {
        public static void SendMail(string to, string subject, EmailType content)
        {
            try
            {
                const string fromPassword = "P@ssw0rd";
                string mailFrom = "ben.ohana1@gmail.com";
                string smtpStr = "smtp.gmail.com";
                string body = GetEmailByType(content);

                AlternateView view = AlternateView.CreateAlternateViewFromString(body, null, "text/html");
                LinkedResource img = new LinkedResource(@"C:\Users\Ben\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\Images\Logo.png", "image/jpg");
                img.ContentId = "logo";
                img.TransferEncoding = System.Net.Mime.TransferEncoding.Base64;
                view.LinkedResources.Add(img);

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(mailFrom);
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
            catch (Exception e)
            {
                
            }
        }

        private static string GetEmailByType(EmailType type)
        {
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(@"C:\Users\Ben\Documents\GitHub\CourseMates\Code\CourseMate\CourseMatesWS\EmailsTemplate.xml");
                string template = doc.GetElementsByTagName("Template")[0].InnerText;
                string title, subTitle, content;
                title = subTitle = content = string.Empty;
                foreach (XmlNode node in doc.GetElementsByTagName("Email"))
                {
                    if (node.Attributes[0].Name == "id" && node.Attributes[0].Value == type.ToString())
                    {

                        title = node.ChildNodes[0].InnerText;
                        subTitle = node.ChildNodes[1].InnerText;
                        content = node.ChildNodes[2].InnerText;
                    }
                }
                return string.Format(template, title, subTitle, content);
            }
            catch (Exception e)
            {
                
            }
            return string.Empty;
        }
    }
}