<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JoinCourse.aspx.cs" Inherits="CourseMate.Web.JoinCourse" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body style="text-align:center; vertical-align:middle;width:80%; margin-left:10%; margin-right:10%">
    <form id="form1" runat="server" style="text-align:center; vertical-align:middle;width:80%; margin-left:10%; margin-right:10%">
    <div style="display:table-row; text-align:center; vertical-align:middle;">
        <div style="display:table-row; text-align:center">
            <img src="Images/Logo.png" alt="Logo" />
        </div>
    
        <div style="display:table-row; text-align:center; font-size:x-large; margin-top:50px; line-height:150%">
            <i><%=CourseName %></i> is added to your courses list,<br />
            go to your <a href="Desktop.aspx">desktop</a> and start sharing.
        </div>
    </div>
    </form>
</body>
</html>
