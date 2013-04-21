using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CourseMatesWS.BLL.Objects
{
    public class Course
    {
        public int ID { get; set; }
        public string CourseName { get; set; }
        public List<FourmItem> FourmItems { get; set; }
        public List<User> Participants { get; set; }
        public List<File> Files { get; set; }
        public User CourseAdmin { get; set; }
    }
}