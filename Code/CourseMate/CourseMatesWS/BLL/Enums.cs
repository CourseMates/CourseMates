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
    
    public enum LinkType
    {
        ResetPassword=1, JoinCourse=2, EmailVerify=3
    }

    [DataContract(Name = "SQLStatus")]
    public enum SQLStatus
    {
        [EnumMember]
        Succeeded = 0,
        [EnumMember]
        Failed = 1,
        [EnumMember]
        UserExists = 2,
        [EnumMember]
        EmailExists = 3
    }
    
    [DataContract(Name = "FileTypeE")]
    public enum FileTypeE
    {
        [EnumMember]
        Unknown = 0,
        [EnumMember]
        Folder = 1,
        [EnumMember]
        DOC = 2,
        [EnumMember]
        DOCX = 3,
        [EnumMember]
        XLS = 4,
        [EnumMember]
        XLSX = 5,
        [EnumMember]
        PPT = 6,
        [EnumMember]
        PPTX = 7,
        [EnumMember]
        PDF = 8,
        [EnumMember]
        JPG = 9,
        [EnumMember]
        PNG = 10,
        [EnumMember]
        GIF = 11,
        [EnumMember]
        BMP = 12,
        [EnumMember]
        TXT = 13,
    }

    [DataContract(Name = "DeleteStatus")]
    public enum DeleteStatus
    {
        [EnumMember]
        Success = 1,
        [EnumMember]
        Failed = 2,
        [EnumMember]
        Authorized= 3,
        [EnumMember]
        FullFolder = 4
    }
}