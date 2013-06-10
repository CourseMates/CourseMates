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
        public double Rate { get; set; }
        [DataMember]
        public int OwnerId { get; set; }
        [DataMember]
        public string OwnerName { get; set; }
        [DataMember]
        public bool IsFolder { get; set; }
        [DataMember]
        public int PerantID { get; set; }
        [DataMember]
        public List<FileItem> SubItems { get; set; }
        [DataMember]
        public DateTime LastModify { get; set; }
        [DataMember]
        public int Size { get; set; }

        public int CompareTo(object obj)
        {
            FileItem f = obj as FileItem;

            return this.ID.CompareTo(f.ID);
        }
    }
}