using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace CourseMatesWS
{
    public class CourseMates : ICourseMates
    {
        public string GetData(int value)
        {
            BLL.Utilitys.SendMail("ben.ohana1@gmail.com", "Test Mail", "test test test....");
            return string.Format("You entered: {0}", value);
        }
    }
}
