<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="CourseMate.Web.WebForm1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <script src="JS/Main.js" type="text/javascript"></script>
    <title>CourseMates</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

         <ext:Viewport ID="Viewport1" runat="server" Frame="false" >
            <LayoutConfig>
                <ext:FitLayoutConfig />
            </LayoutConfig>
            <Items>
                <ext:Panel ID="Panel1" runat="server" Frame="false">
                    <LayoutConfig>
                        <ext:HBoxLayoutConfig Align="Top" Pack="Center" />
                    </LayoutConfig>
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
                        <ext:Image Align="Middle" runat="server" ImageUrl="Images/wellcom.png" Height="575" Width="700" />
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
        
        <ext:Window ID="loggInWin" runat="server" Closable="true" Resizable="false" Height="150" Icon="Lock"  
            Title="Login" Width="350" BodyPadding="5" Layout="FitLayout" Hidden="true" >
            <Items>
                <ext:FormPanel runat="server" Frame="true" Border="false" >
                    <Items>
                        <ext:TextField ID="txtUsername" runat="server" FieldLabel="User Name" AllowBlank="false"
                            BlankText="Your username is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%"/>
                        <ext:TextField ID="txtPassword" runat="server" InputType="Password" FieldLabel="Password" 
                            AllowBlank="false" BlankText="Your password is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%"/>
                        
                    </Items>
                    <Buttons>
                        <ext:LinkButton ID="LinkButton1" runat="server"  Text="Forget Password?">
                            <Listeners>
                                <Click Handler="#{winForgetPass}.show();" />
                            </Listeners>
                        </ext:LinkButton>
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

        <ext:Window ID="winForgetPass" runat="server" Closable="true" Resizable="false" Height="130" Icon="LockBreak"  
            Title="Login" Width="300" BodyPadding="5" Layout="FitLayout" Hidden="true" >
            <Items>
                <ext:FormPanel ID="pnlRestorPass" runat="server" Frame="true" Border="false" ButtonAlign="Center">
                    <Items>
                        <ext:TextField ID="txtFPEmail" runat="server" FieldLabel="Email" AllowBlank="false"
                            BlankText="Email is required." Margin="5" LabelWidth="50" MsgTarget="Side" AnchorHorizontal="100%"/>
                    </Items>
                    <Buttons>
                        <ext:Button runat="server" ID="btnPassReset" Text="Send" Icon="EmailGo" Disabled="true">
                            <DirectEvents>
                                <Click OnEvent="SendEmail_Click">
                                    <EventMask ShowMask="true" Msg="Sending Email..." Target="CustomTarget" CustomTarget="pnlRestorPass" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <ValidityChange Handler="#{btnPassReset}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
        </ext:Window>

        <ext:Window ID="winRegister" runat="server" Closable="true" Resizable="false" Height="310" Icon="Pencil"  
            Title="Register" Width="350" BodyPadding="5" Layout="FitLayout" Hidden="true">
            <Items>
                <ext:FormPanel ID="pnlRegister" runat="server" Frame="true" Border="false" >
                    <Items>
                        <ext:TextField ID="txtRFName" runat="server" FieldLabel="First Name" AllowBlank="false"
                            BlankText="First name is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%" />
                        <ext:TextField ID="txtRLName" runat="server" FieldLabel="Last Name" AllowBlank="false"
                            BlankText="Last name is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%"/>
                        <ext:TextField ID="txtRUsername" runat="server" FieldLabel="User Name" AllowBlank="false"
                            BlankText="Uset name is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%"/>
                        <ext:TextField ID="txtREmail" runat="server" InputType="Email" FieldLabel="Email" Vtype="email"
                            AllowBlank="false" BlankText="Email is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%"/>
                        <ext:TextField ID="txtRPassword" runat="server" InputType="Password" FieldLabel="Password"  MsgTarget="Side" AnchorHorizontal="100%" 
                            AllowBlank="false" BlankText="Password is required." Margin="5" MinLength="8" MinLengthText="Password must be 8 character long"/>
                        <ext:TextField ID="txtRCPassword" runat="server" InputType="Password" FieldLabel="Confirm Password" 
                            AllowBlank="false" BlankText="Confirm password is required." Margin="5" Vtype="password"  MsgTarget="Side" AnchorHorizontal="100%">
                            <CustomConfig>
                                <ext:ConfigItem Name="initialPassField" Value="txtRPassword" Mode="Value" />
                            </CustomConfig>      
                        </ext:TextField>
                    </Items>
                    <Buttons>
                        <ext:Button ID="Button2" runat="server" Text="Cancel" Icon="Delete">
                            <Listeners>
                                <Click Handler="#{winRegister}.hide();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="btnRegisterOk" runat="server" Text="Ok" Icon="Accept" Disabled="true">
                            <DirectEvents>
                                <Click OnEvent="Register_Click" >
                                    <EventMask ShowMask="true" Msg="Create New User..." Target="CustomTarget" CustomTarget="pnlRegister" /> />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <ValidityChange Handler="#{btnRegisterOk}.setDisabled(!valid);" />
                    </Listeners>
                    </ext:FormPanel>
            </Items>
       </ext:Window>
    </div>
    </form>
</body>
</html>
