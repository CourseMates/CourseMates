using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class SessionObj
    {
        [DataMember]
        public int UserID { get; set; }
        [DataMember]
        public string SessionID { get; set; }
        [DataMember]
        public DateTime ExpTime { get; set; }
    }
}