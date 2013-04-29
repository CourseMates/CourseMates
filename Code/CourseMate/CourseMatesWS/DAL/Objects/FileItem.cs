using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
using CourseMatesWS.BLL;

namespace CourseMatesWS.DAL.Objects
{
    [DataContract]
    public class FileItem :IComparable
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string FileName { get; set; }
        [DataMember]
        public FileType Type { get; set; }
        [DataMember]
        public int Rate { get; set; }
        [DataMember]
        public string LogicalPath { get; set; }
        [DataMember]
        public User Owner { get; set; }

        public int CompareTo(object obj)
        {
            FileItem f = obj as FileItem;

            return this.ID.CompareTo(f.ID);
        }
    }
}