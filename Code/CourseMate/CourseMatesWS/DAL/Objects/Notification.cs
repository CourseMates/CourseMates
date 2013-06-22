using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class Notification
    {
        [DataMember]
        public string Subject { get; set; }
        [DataMember]
        public string Content { get; set; }
        [DataMember]
        public DateTime CreatedTime { get; set; }
        [DataMember]
        public string Owner { get; set; }
        [DataMember]
        public string CourseName { get; set; }
    }
}