using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace CourseMatesWS.BLL
{
    public enum EmailType
    {
        Verify, NewFile, FileUpdate, QAndA, ApproveRequest, Invitation, ResetPassword
    }
    public enum FileTypeE
    {
        Unknown = 0,
        Folder = 1,
        Word2003 = 2,
        Word2007 = 3,
        Excel2003 = 4,
        Excel2007 = 5,
        PowerPoint2003 = 6,
        PowerPoint2007 = 7,
        AcrobatReader = 8,
        JPG = 9,
        PNG = 10,
        GIF = 11,
        BMP = 12
    }
    public enum LinkType
    {
        ResetPassword=1, JoinCourse=2, EmailVerify=3
    }
    [DataContract(Name = "SQLStatus")]
    public enum SQLStatus
    {
        [EnumMember]
        Succeeded,
        [EnumMember]
        Failed,
        [EnumMember]
        UserExists,
        [EnumMember]
        EmailExists
    }
}