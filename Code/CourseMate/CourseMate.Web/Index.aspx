<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="CourseMate.Web.WebForm1" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        
        <ext:Window ID="loggInWin" runat="server" Closable="false" Resizable="false" Height="180" Icon="Lock" 
            Title="Login" Draggable="false" Width="350" Modal="true" BodyPadding="5" Layout="FitLayout">
            <Items>
                <ext:FormPanel runat="server" Frame="true" Layout="FormLayout" Border="false" >
                <Items>
                    <ext:TextField ID="txtUsername" runat="server" FieldLabel="User Name" AllowBlank="false"
                        BlankText="Your username is required." Margin="5"/>
                    <ext:TextField ID="txtPassword" runat="server" InputType="Password" FieldLabel="Password" 
                        AllowBlank="false" BlankText="Your password is required." Margin="5"/>
                </Items>
                <Buttons>
                    <ext:Button ID="btnRegister" runat="server" Text="Register" Icon="Pencil">
                    </ext:Button>
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
    </div>
    </form>
</body>
</html>
