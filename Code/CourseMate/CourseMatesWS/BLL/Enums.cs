using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CourseMatesWS.BLL
{
    public enum EmailType
    {
        Verify, NewFile, FileUpdate, QAndA, ApproveRequest, Invitation
    }
    public enum FileType
    {
        Unknown = 0, Word = 1, Excel = 2, PowerPoint = 3, Image = 4, PDF = 5, Text = 6
    }
}