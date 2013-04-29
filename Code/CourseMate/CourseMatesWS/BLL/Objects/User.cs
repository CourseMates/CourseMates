using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.BLL.Objects
{
    [DataContract]
    public class User :IComparable
    {
        [DataMember]
        public int ID { get; set; }
        [DataMember]
        public string FirstName { get; set; }
        [DataMember]
        public string LastName { get; set; }
        [DataMember]
        public string UserName { get; set; }
        [DataMember]
        public string Email { get; set; }
        [DataMember]
        public string Password { get; set; }
        [DataMember]
        public string GCMId { get; set; }

        public int CompareTo(object obj)
        {
            User u = obj as User;

            return this.ID.CompareTo(u.ID);
        }
    }
}