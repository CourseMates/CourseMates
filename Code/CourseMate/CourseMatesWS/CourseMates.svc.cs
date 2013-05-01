using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.BLL;
using CourseMatesWS.DAL.Objects;
using System.IO;
using CourseMatesWS.DAL;
using System.Reflection;

namespace CourseMatesWS
{
    public class CourseMates : ICourseMates
    {

        public string GetUrl()
        {
            User u = new User()
            {
                ID=5,
                Email = "ben.ohana1@gmail.com",
                UserName="benoh"
            };
            return Utilitys.GetUniqueEmail(LinkType.EmailVerify, u);

        }
    }
}
