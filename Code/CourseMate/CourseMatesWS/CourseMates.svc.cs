using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.BLL;

namespace CourseMatesWS
{
    public class CourseMates : ICourseMates
    {
        public string GetData(int value)
        {
            Array t = Enum.GetValues(typeof(EmailType));
            foreach (EmailType item in t)
            {
                BLL.Utilitys.SendMail("ben.ohana1@gmail.com", item.ToString(), Utilitys.GetEmailTamplateByType(item));    
            }
            
            return string.Format("You entered: {0}", value);
        }
    }
}
