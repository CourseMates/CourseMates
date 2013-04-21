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
        Word, Excel, PowerPoint, Image, PDF, Text
    }
}