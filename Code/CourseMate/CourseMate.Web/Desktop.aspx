<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desktop.aspx.cs" Inherits="CourseMate.Web.Desktop" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <title>My Courses</title>
    <style type="text/css" title="My Courses">
        .ux-wallpaper {
            background-color:White !important;
            background-image:url(Images/Logo.png) !important;
            background-position:center !important;
            background-repeat:no-repeat !important;
        }
        .x-beige-folder
        {
            background-image:url("Images/FolderIcons/beige.png");
        }
        .x-black-folder
        {
            background-image:url("Images/FolderIcons/black.png");
        }
        .x-blue-folder
        {
            background-image:url("Images/FolderIcons/blue.png");
        }
        .x-green-folder
        {
            background-image:url("Images/FolderIcons/green.png");
        }
        .x-lila-folder
        {
            background-image:url("Images/FolderIcons/lila.png");
        }
        .x-orange-folder
        {
            background-image:url("Images/FolderIcons/orange.png");
        }
        .x-pink-folder
        {
            background-image:url("Images/FolderIcons/pink.png");
        }
        .x-white-folder
        {
            background-image:url("Images/FolderIcons/white.png");
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
                                <ext:Button ID="Button3" runat="server" Text="New Course" Icon="Add" TextAlign="Left">
                                    <Listeners>
                                        <Click Handler="#{winAddNEwCourse}.show();" />
                                    </Listeners>
                                </ext:Button>    
                                <ext:ToolbarFill />
                                <ext:ToolbarSeparator />
                                <ext:Button ID="Button1" runat="server" Text="Settings" Icon="Cog" TextAlign="Left" />
                                <ext:Button ID="Button2" runat="server" Text="Logout" Icon="Key" TextAlign="Left">
                                    <DirectEvents>
                                        <Click OnEvent="Logout_Click">
                                            <EventMask ShowMask="true" Msg="Login out..." MinDelay="1500" />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </ToolConfig>
                </StartMenu>
                <TaskBar TrayWidth="80">
                    <QuickStart>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" Icon="Help">
                                    <QTipCfg Text="Help" />
                                    <Listeners>
                                        <Click Handler="#{winHelp}.show();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </QuickStart>
                </TaskBar>
            </ext:Desktop>

            <ext:Window runat="server" ID="winAddNEwCourse" Icon="BookOpen" Title="Create New Course" Resizable="false" Draggable="true"
                Width="350" Hidden="false" CloseAction="Hide" HideMode="Offsets" Closable="true" Height="200">
                <Items>
                    <ext:FormPanel runat="server" ID="pnlAddNewCourse" Frame="true" Border="false">
                        <Items>
                            <ext:TextArea runat="server" ID="txtCourseName" AllowBlank="false" FieldLabel="Course Name"
                            BlankText="Course name is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%" />
                            <ext:ComboBox runat="server" ID="cmbFolderColor" Editable="false" FieldLabel="Folder Color" AnchorHorizontal="100%">
                                <Items>
                                    <ext:ListItem Text="Black" Value=".x-black-folder" />
                                </Items>
                                <BeforeLabelTextTpl runat="server">
                                    <Html>
                                        <img src="Images/FolderIcons/{Text}.png" width="20" aling="left" />
                                    </Html>
                                </BeforeLabelTextTpl>
                            </ext:ComboBox>
                        </Items>
                        <Buttons>
                            <ext:Button runat="server" Text="Cancel" Icon="Cancel">
                                <Listeners>
                                    <Click Handler="#{winAddNEwCourse}.hide();" />
                                </Listeners>
                            </ext:Button>
                            <ext:Button  runat="server" Text="Add" Icon="BookAdd">
                                <DirectEvents>
                                    <Click OnEvent="AddNewCourse_Click" />
                                </DirectEvents>
                            </ext:Button>
                        </Buttons>
                    </ext:FormPanel>
                </Items>    
            </ext:Window>

            <ext:Window runat="server" ID="winHelp" Icon="Help" Title="Help" Resizable="false" Draggable="true"
                Width="900" Height="550" Closable="true" HideMode="Offsets" CloseAction="Hide" Hidden="true"> 
                <LayoutConfig>
                    <ext:BorderLayoutConfig />
                </LayoutConfig>
                <Items>

                    <ext:MenuPanel ID="MenuPanel1" runat="server" Width="200" Region="West" Collapsed="false" Collapsible="true" Title="Help Topics">
                        <Menu ID="Menu1" runat="server">
                            <Items>
                                <ext:MenuItem Text="New Course" Icon="Camera"></ext:MenuItem>
                                <ext:MenuItem Text="Invite Users" Icon="Camera"></ext:MenuItem>
                                <ext:MenuItem Text="Add New File" Icon="Camera"></ext:MenuItem>
                                <ext:MenuItem Text="Ask/Answer Question" Icon="Camera"></ext:MenuItem>
                                <ext:MenuItem Text="Rate File" Icon="Camera"></ext:MenuItem>
                            </Items>
                        </Menu>
                    </ext:MenuPanel>
                    <ext:Panel ID="Panel1" runat="server" Frame="true" Region="Center" Layout="FitLayout">  
                        <Items>
                            <ext:FlashComponent runat="server" />
                        </Items>
                    </ext:Panel>    
                </Items>
            </ext:Window>
        </div>
    </form>
</body>
</html>
