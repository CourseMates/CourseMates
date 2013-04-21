using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CourseMatesWS.BLL.Objects
{
    public class FourmItem
    {
        public int ID { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int Rate { get; set; }
        public User Owner { get; set; }
        public FourmItem PerentItem { get; set; }
    }
}