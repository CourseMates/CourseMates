<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="CourseMate.Web.ResetPassword" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script language="javascript">
    
    </script>
</head>
<body style="text-align:center; vertical-align:middle;width:80%; margin-left:10%; margin-right:10%">
    <form id="form1" runat="server" style="text-align:center; vertical-align:middle;width:80%; margin-left:10%; margin-right:10%">
        <div style="display:table-row; text-align:center; vertical-align:middle;">
            <div>
                <img src="Images/Logo.png" alt="Logo" />
            </div>
        </div>
        <div style="display:table-row; text-align:center; vertical-align:middle; border-bottom-color:Black; border-width:thick; font-size:x-large;  line-height:150%; padding:50px;">
            <div style="display:table; text-align:center; vertical-align:middle; width:70%; margin-left:15%; margin-right:15%">
                <table border="0">
                    <tr>    
                        <td>New Password:</td>
                        <td><asp:TextBox runat="server" TextMode="Password" Width="250" Height="30" ID="txtPassword" ></asp:TextBox></td>
                        <td><asp:Label ID="lblPassValid" runat="server" Text="* This filed is required." Font-Size="Large" ForeColor="Red" Visible="false"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>Confirm New Password:</td>
                        <td><asp:TextBox runat="server" TextMode="Password" Width="250" Height="30" ID="txtCPassword" ></asp:TextBox></td>
                        <td><asp:Label ID="lblCPassValid" runat="server" Text="* This filed is required." Font-Size="Large" ForeColor="Red" Visible="false"></asp:Label></td>
                    </tr>
                </table>
            </div>
            <div style="margin-top:30px">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" 
                    onclick="ChangePasswordClick" Enabled ="false" />
            </div>
        </div>
    </form>
</body>
</html>
