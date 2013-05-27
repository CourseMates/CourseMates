<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desktop.aspx.cs" Inherits="CourseMate.Web.Desktop" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register TagName="CourseWindow" TagPrefix="mod" Src="~/CourseWindow.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <script type="text/javascript">
        var filterTree = function (tf, e) {
            var tree = App.filesTreePanel,
                text = tf.getRawValue();

            tree.clearFilter();

            if (Ext.isEmpty(text, false)) {
                return;
            }

            if (e.getKey() === Ext.EventObject.ESC) {
                clearFilter();
            } else {
                var re = new RegExp(".*" + text + ".*", "i");

                tree.filterBy(function (node) {
                    return re.test(node.data.text);
                });
            }
        };

        var clearFilter = function () {
            var field = App.TriggerField1,
                tree = App.filesTreePanel;

            field.setValue("");
            tree.clearFilter(true);
            tree.getView().focus();
        };
    </script>
    <title>My Courses</title>
    <style type="text/css">
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
            width:48px;
            height:48px;
        }
        .x-white-folder
        {
            background-image:url("Images/FolderIcons/white.png");
        }
        .x-folder-text
        {
            color:Black;
        }
        .img-chooser-dlg .details {
            text-align: center;
        }

        .img-chooser-dlg .details-info {
            border-top: 1px solid #cccccc;
            font: 11px Arial, Helvetica, sans-serif;
            margin-top: 5px;
            padding-top: 5px;
            text-align: left;
        }

        .img-chooser-dlg .details-info b {
            color: #555555;
            display: block;
            margin-bottom: 4px;
            margin-left: 5px;
        }

        .img-chooser-dlg .details-info span {
            display: block;
            margin-bottom: 5px;
            margin-left: 10px;
        }

        .img-chooser-view {
            background: white;
            font: 11px Arial, Helvetica, sans-serif;
        }

        .img-chooser-view .thumb {
            padding: 3px;
        }

        .img-chooser-view .thumb-wrap {
            float: left;
            margin: 4px;
            margin-right: 0;
            padding: 5px;
        }

        .img-chooser-view .thumb-wrap span {
            display: block;
            overflow: hidden;
            text-align: center;
        }

        .img-chooser-view .x-view-over {
            border:1px solid #dddddd;
            background-color: #efefef;
            padding: 4px;
        }

        .img-chooser-view .x-item-selected {
            background: #DFEDFF;
            border: 1px solid #6593cf;
            padding: 4px;
        }

        .img-chooser-view .x-item-selected .thumb {
            background:transparent;
        }

        .img-chooser-view .x-item-selected span {
            color:#1A4D8F;
        }

        .img-chooser-view .loading-indicator {
            font-size:11px;
            background-image :url(/extnet/resources/images/loading-gif/ext.axd) ;
            background-repeat: no-repeat;
            background-position: left;
            padding-left:20px;
            margin:10px;
        }
    </style>
</head>
<body> 
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Desktop ID="MyDesktop" runat="server"> 
            <Modules>
                <ext:DesktopModule ModuleID="mdlNewCourse" AutoRun="false">
                    <Window>
                    <ext:Window runat="server" ID="winAddNewCourse" Icon="BookOpen" Title="Create New Course" Resizable="false" Draggable="true"
                        Width="350" Hidden="true" CloseAction="Destroy" Closable="true" Height="150" Layout="FitLayout">
                        <Items>
                            <ext:FormPanel runat="server" ID="pnlAddNewCourse" Frame="true" Border="false">
                                <Items>
                                    <ext:TextField runat="server" ID="txtCourseName" AllowBlank="false" FieldLabel="Course Name"
                                    BlankText="Course name is required." Margin="5" MsgTarget="Side" AnchorHorizontal="100%" />
                                    <ext:ComboBox runat="server" ID="cmbFolderColor" Editable="false" FieldLabel="Folder Color" 
                                    AnchorHorizontal="100%" Margin="5" DisplayField="text" ValueField="iconCls" AllowBlank="false">
                                        <Store>
                                            <ext:Store ID="storeFolderColors" runat="server">
                                                <Model>
                                                    <ext:Model ID="Model1" runat="server">
                                                        <Fields>
                                                            <ext:ModelField Name="text" />
                                                            <ext:ModelField Name="iconCls" />
                                                        </Fields>
                                                    </ext:Model>
                                                </Model>            
                                            </ext:Store>
                                        </Store>
                                        <ListConfig>
                                            <ItemTpl ID="ItemTpl1" runat="server">
                                                <Html>
                                                    <img src="Images/FolderIcons/{text}.png" width="20" style="text-align:center"> {text}</img>
                                                </Html>
                                            </ItemTpl>
                                        </ListConfig>
                                    </ext:ComboBox>
                                </Items>
                                <Listeners>
                                    <ValidityChange Handler="#{btnAddNewCourse}.setDisabled(!valid);" />
                                </Listeners>
                                <Buttons>
                                    <ext:Button ID="Button4" runat="server" Text="Cancel" Icon="Cancel">
                                        <Listeners>
                                            <Click Handler="#{winAddNEwCourse}.hide();" />
                                        </Listeners>
                                    </ext:Button>
                                    <ext:Button ID="btnAddNewCourse" runat="server" Text="Add" Icon="BookAdd" Disabled="true">
                                        <DirectEvents>
                                            <Click OnEvent="AddNewCourse_Click" />
                                        </DirectEvents>
                                    </ext:Button>
                                </Buttons>
                            </ext:FormPanel>
                        </Items>    
                    </ext:Window>
                </Window>
                    <Launcher Text="New Course" Icon="Add" />
                </ext:DesktopModule>
            </Modules>
            <StartMenu Title="Menu" Height="300" Icon="Application">
            <ToolConfig>
                <ext:Toolbar runat="server" Width="100">
                    <Items>
                        <ext:ToolbarFill />
                        <ext:ToolbarSeparator />
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
        <ext:Window ID="winCourse" runat="server" Closable="true" Resizable="true" Minimizable="true" Width="800" Height="600" Layout="FitLayout" Icon="BookOpen" Hidden="true">
            <Items>
                <ext:TabPanel ID="TabPanel1" runat="server" Layout="FitLayout">
                    <Items>
                        <ext:Panel ID="Panel2" runat="server" Title="Files" Frame="true" Layout="BorderLayout">
                            <Items>
                                <ext:Window ID="winUploadFile" runat="server" Closable="true" Icon="Add" Title="Add File" Resizable="false" Draggable="true" Minimizable="true" Width="400" Height="150" Layout="FitLayout" Hidden="true" CloseAction="Hide">
                                        <Items>
                                        <ext:FormPanel ID="FormPanel1" runat="server" Frame="true">
                                            <Items>
                                                <ext:TextField ID="txtDisplayName" runat="server" FieldLabel="Flie Name" Margin="5"  MsgTarget="Side" AnchorHorizontal="100%" AllowBlank="false"  />
                                                <ext:FileUploadField ID="uploadFiled" Margin="5" runat="server" EmptyText="Select File" FieldLabel="File" ButtonText="Browse..." AnchorHorizontal="100%" AllowBlank="false"/> 
                                            </Items>    
                                            <Buttons>
                
                                                <ext:Button ID="btnUpload" runat="server" Text="Upload" Icon="Accept" Disabled="true">
                                                    <DirectEvents>
                                                        <Click OnEvent="UploadClick" Before="Ext.Msg.wait('Uploading...', 'Uploading');" />
                                                    </DirectEvents>
                                                </ext:Button>
                                                <ext:Button ID="Button8" runat="server" Text="Cancel" Icon="Cancel">
                                                    <Listeners>
                                                        <Click Handler="#{winUploadFile}.hide();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Buttons>    
                                            <Listeners>
                                                <ValidityChange Handler="#{btnUpload}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Window>
                                <ext:TreePanel ID="filesTreePanel" runat="server" AutoScroll="true" Width="230" Animate="true" Region="West" Collapsible="true" Title="File Tree" UseArrows="true">           
                                    <TopBar>
                                        <ext:Toolbar ID="Toolbar1" runat="server">
                                            <Items>
                                                <ext:ToolbarTextItem ID="ToolbarTextItem1" runat="server" Text="Filter:" />
                                                <ext:ToolbarSpacer />
                                                <ext:TriggerField 
                                                    ID="TriggerField1" runat="server" EnableKeyEvents="true">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <KeyUp Fn="filterTree" Buffer="250" />
                                                        <TriggerClick Handler="clearFilter();" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Toolbar>
                                    </TopBar>   
                                    <DirectEvents>
                                        <CellDblClick OnEvent="FileItemClick">
                                            <ExtraParams>
                                                <ext:Parameter Name="nodeId" Value="record.data.id" Mode="Raw" />
                                            </ExtraParams>
                                        </CellDblClick>
                                    </DirectEvents>         
                                </ext:TreePanel>
                                <ext:Panel ID="Panel3" runat="server" Region="Center" AnchorVertical="100%" Layout="BorderLayout" >
                                    <TopBar>
                                         <ext:Toolbar ID="Toolbar2" runat="server">
                                            <Items>
                                              <ext:Button ID="Button1" runat="server" Icon="Add" Text="Add File">
                                                    <Listeners>
                                                    <Click Handler="#{winUploadFile}.show();" />                                
                                                    </Listeners>
                                                <ToolTips>
                                                    <ext:ToolTip ID="ToolTip1" runat="server" Html="Simple button" />
                                                </ToolTips>
                                            </ext:Button>
                                            <ext:Button ID="btnDeleteFile" runat="server" Icon="Delete" Text="Delete File">
                                            </ext:Button>
                                            <ext:ToolbarSeparator />
                                            <ext:Button  ID="btnAddFolder" runat="server" Icon="FolderAdd" Text="Add Folder">
                                            </ext:Button>
                                            <ext:Button ID="btnDeleteFolder" runat="server" Icon="FolderDelete" Text="Delete Folder">
                                            </ext:Button>
                                            <ext:ToolbarSeparator />
                                            <ext:Button ID="btnDownload" runat="server" Icon="PackageDown" Text="Download" Tooltip="Download">
                                            </ext:Button>
                                        </Items>
                                    </ext:Toolbar>
                                </TopBar>
                                    <Items>
                                        <ext:Panel runat="server" AnchorVertical="100%" Region="Center" AutoScroll="true">
                                            <Items>
                                                <ext:DataView runat="server" SingleSelect="true" ItemSelector="div.thumb-wrap" Cls="img-chooser-view" AutoScroll="true" ID="pnlFileView" >
                                                    <Store>
                                                        <ext:Store runat="server" ID="storeFiles">
                                                            <Model>
                                                                <ext:Model runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="FileID" Type="Int" /> 
                                                                        <ext:ModelField Name="FileName" Type="String" /> 
                                                                        <ext:ModelField Name="ImageUrl" Type="String" />
                                                                        <ext:ModelField Name="Size" Type="Float" />
                                                                        <ext:ModelField Name="LastModify" Type="Date" />
                                                                        <ext:ModelField Name="Rate" Type="Int" />
                                                                        <ext:ModelField Name="Type" Type="String" />
                                                                        <ext:ModelField Name="Owner" Type="String" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Tpl runat="server">
                                                        <Html>
                                                            <tpl for=".">
                                                                <div class="thumb-wrap">
                                                                    <div class="thumb">
                                                                        <tpl if="!Ext.isIE6">
                                                                            <img src="{ImageUrl}" height="64px" width="64px" />
                                                                        </tpl>
                                                                        <tpl if="Ext.isIE6">
                                                                            <div style="width:64px;height:64px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{ImageUrl}")"></div>
                                                                        </tpl>                    
                                                                    </div>
                                                                    <span style="text-align:center">{FileName}</span>
                                                                </div>
                                                            </tpl>
                                                        </Html>
                                                    </Tpl>
                                                    <Listeners>
                                                        <SelectionChange Handler="if(selections[0]){App.pnlItemInfo.loadRecord(selections[0])}" />
                                                        <Refresh Handler="this.el.select('.thumb-wrap').addClsOnOver('x-view-over');" Delay="100" />
                                                        <ItemDblClick Handler="#{DirectMethods}.UpdateViewPanel(this.store.getAt(index).data.FileID)" />                                                 
                                                    </Listeners>
                                                </ext:DataView>
                                            </Items>
                                        </ext:Panel>
                                        <ext:Panel ID="pnlItemInfo" runat="server" AnchorVertical="100%" Height="150" Region="South" Title="Item Info" Collapsed="false" Collapsible="true" Frame="false">
                                            <CustomConfig>
                                                <ext:ConfigItem Name="loadRecord" Value="function(file){
                                                    this.body.hide();
                                                    this.tpl.overwrite(App.pnlItemInfo.body, file.data);
                                                    this.body.slideIn('t', {
                                                        duration: 250
                                                    });}" 
                                                 Mode="Raw" />
                                            </CustomConfig>
                                            <Tpl runat="server">
                                                <Html>
                                                    <tpl for=".">   
                                                        <div style="display:table-row; height:auto" class="details">
                                                            <div style="display:table-cell; width:90px; float:left; margin-top:25px">
                                                                <tpl if="!Ext.isIE6">
                                                                    <img src="{ImageUrl}" height="64px" width="64px" />
                                                                </tpl>
                                                                <tpl if="Ext.isIE6">
                                                                    <div style="width:64px;height:64px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="{ImageUrl}")"></div>
                                                                </tpl> 
                                                            </div>
                                                            <div style="display:table-cell; width:auto; float:right" class="details-info">
                                                                <table width="100%">
                                                                    <tr style="height:20px;">
                                                                        <td style="width:120px;"><b>File Name:</b></td>
                                                                        <td>{FileName}</td>
                                                                    </tr>
                                                                    <tr style="height:20px;">
                                                                        <td><b>Size:</b></td>
                                                                        <td>{Size} MB</td>
                                                                    </tr>
                                                                    <tr style="height:20px;">
                                                                        <td><b>Last Modify:</b></td>
                                                                        <td>{LastModify}</td>
                                                                        
                                                                    </tr>
                                                                    <tr style="height:20px;">
                                                                        <td><b>Rate:</b></td>
                                                                        <td>{Rate}</td>
                                                                    </tr>
                                                                    <tr style="height:20px;">
                                                                        <td><b>Type:</b></td>
                                                                        <td>{Type}</td>
                                                                    </tr>
                                                                    <tr style="height:20px;">
                                                                        <td><b>Owner:</b></td>
                                                                        <td>{Owner}</td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </div>
                                                    </tpl>
                                                </Html>
                                            </Tpl>
                                        </ext:Panel>
                                    </Items>
                            </ext:Panel>
                            </Items>
                        </ext:Panel>
                        <ext:Panel ID="Panel5" runat="server" Title="Fourm">
                        </ext:Panel>
                        <ext:Panel ID="Panel6" runat="server" Title="Course User">
                        </ext:Panel>
                        <ext:Panel ID="Panel7" runat="server" Title="Course Settings">
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
