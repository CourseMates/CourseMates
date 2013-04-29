using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.BLL.Objects
{
    [DataContract]
    public class FourmItem : IComparable
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string Title { get; set; }
        [DataMember]
        public string Content { get; set; }
        [DataMember]
        public int Rate { get; set; }
        [DataMember]
        public User Owner { get; set; }
        [DataMember]
        public int PerentId { get; set; }

        public int CompareTo(object obj)
        {
            FourmItem fi = obj as FourmItem;

            return this.ID.CompareTo(fi.ID);
        }
    }
}