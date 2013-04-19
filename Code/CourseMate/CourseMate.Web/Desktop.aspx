<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desktop.aspx.cs" Inherits="CourseMate.Web.Desktop" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <title></title>
    <style type="text/css">
        .ux-wallpaper {
            background-color:White;
            background-image:url(Images/Logo.png);
            background-position:center;
            background-repeat:no-repeat;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <ext:ResourceManager ID="ResourceManager1" runat="server" />
            <ext:Desktop ID="MyDesktop" runat="server" >
                <StartMenu Title="Menu" Height="300" Icon="Application">
                    <ToolConfig>
                        <ext:Toolbar runat="server" Width="100">
                            <Items>
                                <ext:Button ID="Button3" runat="server" Text="New Course" Icon="Add" TextAlign="Left" />
                                <ext:ToolbarFill />
                                <ext:ToolbarSeparator />
                                <ext:Button ID="Button1" runat="server" Text="Settings" Icon="Cog" TextAlign="Left" />
                                <ext:Button ID="Button2" runat="server" Text="Logout" Icon="Key" TextAlign="Left" />
                            </Items>
                        </ext:Toolbar>
                    </ToolConfig>
                </StartMenu>
                
            </ext:Desktop>
        </div>
    </form>
</body>
</html>
