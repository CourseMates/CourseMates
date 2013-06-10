<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="CourseMate.Web.Test" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head  runat="server">
    <title>Ext.NET Examples</title>
     <script type="text/javascript">
        var tile = function () {
            //Ext.net.Desktop.tileWindows();
        };

        var cascade = function () {
            //Ext.net.Desktop.cascadeWindows();
        };

        var initSlidePanel = function () {
            this.setHeight(Ext.getBody().getHeight());

            if (!this.windowListen) {
                this.windowListen = true;

                this.el.alignTo(Ext.getBody(), 'tl-tr', [0, 0]);
                Ext.EventManager.onWindowResize(initSlidePanel, this);
            }
        };
    </script>
</head>
<body>
        <ext:ResourceManager ID="ResourceManager1" runat="server">
            <Listeners>
                <WindowResize Handler="Ext.net.Bus.publish('App.Desktop.ready');" Buffer="500" />
            </Listeners>
        </ext:ResourceManager>

        <ext:Desktop ID="Desktop1" runat="server">            


            <DesktopConfig ShortcutDragSelector="true">

                <Content>
                   <ext:DisplayField ID="DisplayField2" runat="server" Text="Move mouse to the right edge -->" FieldStyle="color:white;font-size:24px;" StyleSpec="position:absolute;right:50px;top:50px;"/> 

                   <ext:Toolbar ID="Toolbar1" runat="server" Width="320" Floating="true" ClassicButtonStyle="true" Flat="true" Border="false" Shadow="false">                       
                        <MessageBusListeners>
                            <ext:MessageBusListener Name="App.Desktop.ready" Handler="this.el.anchorTo(Ext.getBody(), 'c-b', [0, -50]);" />
                        </MessageBusListeners>
                    </ext:Toolbar>                    
                </Content>
            </DesktopConfig>

            <StartMenu Title="Ext.Net Desktop" Icon="Application" Height="300">
                <ToolConfig>
                    <ext:Toolbar ID="Toolbar2" runat="server" Width="100">
                        <Items>
                            <ext:Button ID="Button6" runat="server" Text="Settings" Icon="Cog" />
                            <ext:Button ID="Button7" runat="server" Text="Logout" Icon="Key">
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </ToolConfig>
            </StartMenu>

            <TaskBar TrayWidth="100">
                <QuickStart>
                    <ext:Toolbar ID="Toolbar3" runat="server">
                        <Items>
                            <ext:Button ID="Button8" runat="server" Handler="tile" Icon="ApplicationTileVertical">
                                <QTipCfg Text="Tile windows" />
                            </ext:Button>

                            <ext:Button ID="Button9" runat="server" Handler="cascade" Icon="ApplicationCascade">
                                <QTipCfg Text="Cascade windows" />
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </QuickStart>

                <Tray>
                    <ext:Toolbar ID="Toolbar4" runat="server">
                        <Items>
                            <ext:Button ID="LangButton" runat="server" Text="EN" MenuArrow="false" Cls="x-bold-text" MenuAlign="br-tr">
                                <Menu>
                                    <ext:Menu ID="Menu2" runat="server">
                                        <Items>
                                            <ext:CheckMenuItem ID="CheckMenuItem1" runat="server" Group="lang" Text="English" Checked="true" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('EN');}" />
                                            <ext:CheckMenuItem ID="CheckMenuItem2" runat="server" Group="lang" Text="French" CheckHandler="function(item, checked) {checked && #{LangButton}.setText('FR');}" />
                                            <ext:MenuSeparator ID="MenuSeparator2" runat="server" />
                                            <ext:MenuItem ID="MenuItem4" runat="server" Text="Show the Language Bar" />
                                        </Items>
                                    </ext:Menu>
                                </Menu>
                            </ext:Button>
                            <ext:ToolbarFill ID="ToolbarFill1" runat="server" />
                        </Items>
                    </ext:Toolbar>
                </Tray>
            </TaskBar>
            <Listeners>
                <Ready BroadcastOnBus="App.Desktop.ready" />
            </Listeners>
        </ext:Desktop>

        <ext:Panel ID="Panel1" runat="server" Title="Notificaions" Frame="true" Width="250"  Floating="true" Shadow="false">
            <Items>
            </Items>
            <MessageBusListeners>
                <ext:MessageBusListener Name="App.Desktop.ready" Fn="initSlidePanel" />
            </MessageBusListeners>
            <Plugins>
                <ext:MouseDistanceSensor ID="MouseDistanceSensor1" runat="server" Opacity="false" Threshold="25">
                    <Listeners>
                        <Near Handler="this.component.el.alignTo(Ext.getBody(), 'tr-tr', [0, 0], true);" />
                        <Far Handler="this.component.el.alignTo(Ext.getBody(), 'tl-tr', [0, 0], true);" />
                    </Listeners>
                </ext:MouseDistanceSensor>
            </Plugins>
        </ext:Panel>
</body>
</html>
<%--<ext:ModelField Name="FileID" Type="Int" /> 
<ext:ModelField Name="FileName" Type="String" /> 
<ext:ModelField Name="ImageUrl" Type="String" />
<ext:ModelField Name="Size" Type="Float" />
<ext:ModelField Name="LastModify" Type="Date" />
<ext:ModelField Name="Rate" Type="Int" />
<ext:ModelField Name="Type" Type="String" />
<ext:ModelField Name="Owner" --%>