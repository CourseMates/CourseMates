using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class Course : IComparable
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string CourseName { get; set; }
        [DataMember]
        public List<FourmItem> FourmItems { get; set; }
        [DataMember]
        public List<User> Participants { get; set; }
        [DataMember]
        public List<FileItem> Files { get; set; }
        [DataMember]
        public User CourseAdmin { get; set; }

        public int CompareTo(object obj)
        {
            Course c = obj as Course;

            return this.ID.CompareTo(c.ID);
        }
    }
}