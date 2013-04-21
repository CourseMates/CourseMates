using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CourseMatesWS.BLL.Objects
{
    public class User
    {
        public int ID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string UserName { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public List<File> Files { get; set; }
        public List<Course> Courses { get; set; }
        public List<FourmItem> FourmItems { get; set; }
    }
}