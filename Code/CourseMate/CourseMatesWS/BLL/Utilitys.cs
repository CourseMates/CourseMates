using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security;
using System.Web;

namespace CourseMatesWS.BLL
{
    public class Utilitys
    {
        public static void SendMail(string to, string subject, string content)
        {
            try
            {
                const string fromPassword = "P@ssw0rd";
                string mailFrom = "ben.ohana1@gmail.com";
                string smtpStr = "smtp.gmail.com";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(mailFrom);
                string[] toList = to.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);
                foreach (string tos in toList)
                {
                    mail.To.Add(new MailAddress(tos));   
                }
                
                mail.Subject = subject;
                mail.Body = content;
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
    }
}