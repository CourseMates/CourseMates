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
            
            BLL.Utilitys.SendMail("ben.ohana1@gmail.com;eliranyehezkel@gmail.com", "CourseMates", EmailType.Verify);
            return string.Format("You entered: {0}", value);
        }
    }
}
