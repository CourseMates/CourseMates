﻿using System;
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
    public enum FileType
    {
        Unknown = 0, Word = 1, Excel = 2, PowerPoint = 3, Image = 4, PDF = 5, Text = 6
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