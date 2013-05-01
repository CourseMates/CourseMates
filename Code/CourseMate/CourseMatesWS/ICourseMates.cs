using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;
using CourseMatesWS.DAL.Objects;
using CourseMatesWS.BLL;
using System.IO;

namespace CourseMatesWS
{    
    [ServiceContract]
    public interface ICourseMates
    {
        [OperationContract]
        string GetUrl();
    }
}
