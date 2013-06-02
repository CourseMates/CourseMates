using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class FileType
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string Description { get; set; }
        [DataMember]
        public string ImageUrl { get; set; }
        [DataMember]
        public string Extension { get; set; }
    }
}