using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class ForumItem : IComparable
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
        public string OwnerName { get; set; }
        [DataMember]
        public int PerentId { get; set; }
        [DataMember]
        public List<ForumItem> SubItems { get; set; }
        [DataMember]
        public int CourseId { get; set; }
        [DataMember]
        public DateTime TimeAdded { get; set; }
        [DataMember]
        public int OwnerId { get; set; }
        
        public int CompareTo(object obj)
        {
            ForumItem fi = obj as ForumItem;

            return this.ID.CompareTo(fi.ID);
        }

        
    }
}