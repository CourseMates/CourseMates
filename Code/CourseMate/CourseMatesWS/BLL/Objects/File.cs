using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CourseMatesWS.BLL.Objects
{
    public class File
    {
        public int ID { get; set; }
        public string FileName { get; set; }
        public FileType Type { get; set; }
        public int Rate { get; set; }
        public string LogicalPath { get; set; }
    }
}