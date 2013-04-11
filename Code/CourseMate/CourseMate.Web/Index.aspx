<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="CourseMate.Web.WebForm1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

         <ext:Viewport ID="Viewport1" runat="server" Frame="false">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
            </LayoutConfig>
            <Items>
                <ext:Panel ID="Panel1" runat="server" Height="600" Frame="false" Width="800">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbLogin" Border="false" >
                            <Items>
                                <ext:ToolbarFill />
                                <ext:Button runat="server" ID="btnOpenRegister" Text="Register" Icon="Pencil">
                                    <Listeners>
                                        <Click Handler="#{winRegister}.show();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnOpenLogin" Text="Login" Icon="Lock">
                                    <Listeners>
                                        <Click Handler="#{loggInWin}.show();" />
                                    </Listeners>
                                </ext:Button>
                                
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Image Align="Middle" runat="server" ImageUrl="Images/Logo.png" />
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
        
        <ext:Window ID="loggInWin" runat="server" Closable="true" Resizable="false" Height="180" Icon="Lock"  
            Title="Login" Width="300" BodyPadding="5" Layout="FitLayout" Hidden="true" >
            <Items>
                <ext:FormPanel runat="server" Frame="true" Border="false" >
                <Items>
                    <ext:TextField ID="txtUsername" runat="server" FieldLabel="User Name" AllowBlank="false"
                        BlankText="Your username is required." Margin="5"/>
                    <ext:TextField ID="txtPassword" runat="server" InputType="Password" FieldLabel="Password" 
                        AllowBlank="false" BlankText="Your password is required." Margin="5"/>
                </Items>
                <Buttons>
                    <ext:Button ID="btnLogIn" runat="server" Text="Login" Icon="Accept" Disabled="true">
                        <DirectEvents>
                            <Click OnEvent="Login_Click">
                                <EventMask ShowMask="true" Msg="Verifying..." />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <ValidityChange Handler="#{btnLogIn}.setDisabled(!valid);" />
                </Listeners>
                </ext:FormPanel>
            </Items>
        </ext:Window>
        <ext:Window ID="winRegister" runat="server" Closable="true" Resizable="false" Height="310" Icon="Pencil"  
            Title="Register" Width="300" BodyPadding="5" Layout="FitLayout" Hidden="true">
            <Items>
                <ext:FormPanel ID="FormPanel1" runat="server" Frame="true" Border="false" >
                    <Items>
                        <ext:TextField ID="txtFName" runat="server" FieldLabel="First Name" AllowBlank="false"
                            BlankText="First name is required." Margin="5"/>
                        <ext:TextField ID="txtLName" runat="server" FieldLabel="Last Name" AllowBlank="false"
                            BlankText="Last name is required." Margin="5"/>
                        <ext:TextField ID="txtUser" runat="server" FieldLabel="User Name" AllowBlank="false"
                            BlankText="Uset name is required." Margin="5"/>
                        <ext:TextField ID="txtEmail" runat="server" InputType="Email" FieldLabel="Email" 
                            AllowBlank="false" BlankText="Email is required." Margin="5"/>
                        <ext:TextField ID="txtPass" runat="server" InputType="Password" FieldLabel="Password" 
                            AllowBlank="false" BlankText="Password is required." Margin="5"/>
                        <ext:TextField ID="txtCPass" runat="server" InputType="Password" FieldLabel="Confirm Password" 
                            AllowBlank="false" BlankText="Confirm password is required." Margin="5"/>
                    </Items>
                    <Buttons>
                        
                        <ext:Button ID="Button2" runat="server" Text="Cancel" Icon="Delete">
                            <Listeners>
                                <Click Handler="#{winRegister}.hide();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button1" runat="server" Text="Ok" Icon="Accept" Disabled="true">
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <ValidityChange Handler="#{btnLogIn}.setDisabled(!valid);" />
                    </Listeners>
                    </ext:FormPanel>
            </Items>
       </ext:Window>
    </div>
    </form>
</body>
</html>
