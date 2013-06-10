<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desktop.aspx.cs" Inherits="CourseMate.Web.Desktop" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="JS/Jquery-1.7.js" type="text/javascript"></script>
    <script src="JS/Main.js" type="text/javascript"></script>
    <script src="JS/Moment.js" type="text/javascript"></script>
    <link href="CSS/MainCss.css" rel="stylesheet" />
    <title>My Courses</title>
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
                <ext:DesktopModule ModuleID="mdlUserSettings" AutoRun="false">
                    <Window>
                        <ext:Window runat="server" ID="winSettings" Icon="Cog" Title="Settings" Resizable="false" Draggable="true"
                        Width="450" Hidden="true" CloseAction="Destroy" Closable="true" Height="320" Layout="FitLayout" Maximizable="false">
                            <Items>
                                <ext:Panel runat="server" Layout="BorderLayout" Border="false">
                                    <Items>
                                        <ext:FormPanel runat="server" Region="North" Border="false" Layout="FitLayout">
                                            <Items>
                                                <ext:FieldSet runat="server" Margin="5" Title="Change Email">
                                                    <Items>
                                                        <ext:TextField runat="server" ID="txtOldEmail" AllowBlank="false" MsgTarget="Side" FieldLabel="Old Email" AnchorHorizontal="100%" Vtype="email" />
                                                        <ext:TextField runat="server" ID="txtNewEmail" AllowBlank="false" MsgTarget="Side" FieldLabel="New Email" AnchorHorizontal="100%" Vtype="email" />
                                                        <ext:FieldContainer ID="FieldContainer2" runat="server" Layout="HBoxLayout" >
                                                            <Defaults>
                                                                <ext:Parameter Name="margins" Value="10 0 0 350" Mode="Value" />
                                                            </Defaults>
                                                            <Items>
                                                                <ext:Button runat="server" Icon="Disk" Text="Save" ID="btnChangeEmail" Disabled="true">
                                                                    <Listeners>
                                                                        <Click Handler="#{DirectMethods}.ChangeEmail();" />
                                                                    </Listeners>
                                                                </ext:Button>
                                                            </Items>
                                                        </ext:FieldContainer>
                                                    </Items>
                                                </ext:FieldSet>
                                            </Items>
                                            <Listeners>
                                                <ValidityChange Handler="#{btnChangeEmail}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                        <ext:FormPanel runat="server" Region="Center" Border="false" Layout="FitLayout">
                                            <Items>
                                                <ext:FieldSet runat="server" Margin="5" Title="Change Password">
                                                    <Items>
                                                        <ext:TextField ID="txtOldPassword" runat="server" InputType="Password" FieldLabel="Old Password" 
                                                            AllowBlank="false" Vtype="password"  MsgTarget="Side" AnchorHorizontal="100%" /> 
                                                        <ext:TextField ID="txtNewPassword" runat="server" InputType="Password" FieldLabel="New Password"  MsgTarget="Side" AnchorHorizontal="100%" 
                                                            AllowBlank="false" MinLength="8" MinLengthText="Password must be 8 character long"/>
                                                        <ext:TextField ID="txtCNewPassword" runat="server" InputType="Password" FieldLabel="Confirm Password" 
                                                            AllowBlank="false"  Vtype="password"  MsgTarget="Side" AnchorHorizontal="100%">
                                                            <CustomConfig>
                                                                <ext:ConfigItem Name="initialPassField" Value="txtNewPassword" Mode="Value" />
                                                            </CustomConfig>      
                                                        </ext:TextField>
                                                        <ext:FieldContainer ID="FieldContainer3" runat="server" Layout="HBoxLayout" >
                                                            <Defaults>
                                                                <ext:Parameter Name="margins" Value="10 0 0 350" Mode="Value" />
                                                            </Defaults>
                                                            <Items>
                                                                <ext:Button runat="server" Icon="Disk" Text="Save" ID="btnChangePass" Disabled="true">
                                                                    <Listeners>
                                                                        <Click Handler="#{DirectMethods}.ChangePassword();" />
                                                                    </Listeners>
                                                                </ext:Button>
                                                            </Items>
                                                        </ext:FieldContainer>
                                                    </Items>
                                                </ext:FieldSet>
                                            </Items>
                                            <Listeners>
                                                <ValidityChange Handler="#{btnChangePass}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Window>
                    </Window>
                    <Launcher Text="Settings" Icon="Cog" />
                </ext:DesktopModule>
                <ext:DesktopModule ModuleID="mdlContactUs" AutoRun="false">
                    <Window>
                        <ext:Window runat="server" ID="winContactUs" Icon="Email" Title="Contact Us" Resizable="false" Draggable="true"
                                Width="440" Hidden="true" CloseAction="Destroy" Closable="true" Height="500" Layout="FitLayout" Maximizable="false">
                            <Items>
                                <ext:Panel ID="Panel4" runat="server" Layout="BorderLayout" Border="false">
                                    <Items>
                                        <ext:Panel runat="server" Region="North" Border="false" Layout="FitLayout">
                                            <Items>
                                                <ext:FieldSet runat="server" Margin="5" Title="Contact details">
                                                    <Items>
                                                        <ext:DisplayField Margin="10" runat="server" FieldLabel="Address" Text="Sesame St 4/666', Stalingrad, MotherRussia" />
                                                        <ext:DisplayField Margin="10" runat="server" FieldLabel="Phone" Text="1-800-SASHAISBUSY" />
                                                        <ext:DisplayField Margin="10" runat="server" FieldLabel="Email" Text="CourseMates@gmail.com" />
                                                        <ext:DisplayField Margin="10" runat="server" FieldLabel="Fax" Text="1-800-BEEPBEEP" />
                                                    </Items>
                                                </ext:FieldSet>
                                            </Items>
                                        </ext:Panel>
                                        <ext:FormPanel runat="server" Region="Center" Border="false" Layout="FitLayout">
                                            <Items>
                                                <ext:FieldSet ID="FieldSet2" runat="server" Margin="5" Title="Email">
                                                    <Items>
                                                        <ext:DisplayField runat="server" Text="Subject:" Margin="10" />
                                                        <ext:TextField runat="server" ID="txtCUSubject" Width="350" Margin="15" AllowBlank="false" MsgTarget="Side" />
                                                        <ext:DisplayField runat="server" Text="Message:" Margin="10" />
                                                        <ext:TextArea runat="server" ID="taCUMessage" Margin="15" Width="350" Height="130" AllowBlank="false" MsgTarget="Side" />
                                                        <ext:FieldContainer runat="server" Layout="HBoxLayout" >
                                                            <Defaults>
                                                                <ext:Parameter Name="margins" Value="10 0 0 300" Mode="Value" />
                                                            </Defaults>
                                                            <Items>
                                                                <ext:Button runat="server" Icon="EmailGo" Text="Send" ID="btnCUSendMsg" Disabled="true">
                                                        
                                                                </ext:Button>
                                                            </Items>
                                                        </ext:FieldContainer>
                                                    </Items>
                                                 </ext:FieldSet>
                                            </Items>
                                            <Listeners>
                                                <ValidityChange Handler="#{btnCUSendMsg}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Window>
                    </Window>
                    <Launcher Text="Contact Us" Icon="Email" />
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
                            <ext:MenuItem Text="New Course" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Invite Users" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Add New File" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Ask/Answer Question" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Rate File" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Change Password" Icon="Film"></ext:MenuItem>
                            <ext:MenuItem Text="Change Email" Icon="Film"></ext:MenuItem>
                        </Items>
                    </Menu>
                </ext:MenuPanel>
                <ext:Panel ID="Panel1" runat="server" Frame="true" Region="Center" Layout="FitLayout">  
                    <Items>
                        <ext:FlashComponent runat="server"/>
                    </Items>
                </ext:Panel>    
            </Items>
        </ext:Window>
        <ext:Window ID="winCourse" runat="server" Closable="true" Resizable="false" Minimizable="true" Width="800" Height="600" Layout="FitLayout" Icon="BookOpen" Hidden="true">
            <Items>
                <ext:TabPanel ID="TabPanel1" runat="server" Layout="FitLayout">
                    <Items>
                        <ext:Panel ID="pnlFiles" runat="server" Title="Files" Frame="true" Layout="BorderLayout">
                            <Items>
                                <ext:Window ID="winUploadFile" runat="server" Closable="true" Icon="Add" Title="Add File" Resizable="false" Draggable="true" Minimizable="true" Width="400" Height="150" Layout="FitLayout" Hidden="true" CloseAction="Hide">
                                        <Items>
                                        <ext:FormPanel ID="FormPanel1" runat="server" Frame="true">
                                            <Items>
                                                <ext:TextField runat="server" Margin="5" ID="txtFolderName" FieldLabel="Folder Name" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side" />
                                                <ext:FileUploadField ID="uploadFiled" Margin="5" runat="server" EmptyText="Select File" FieldLabel="File" ButtonText="Browse..." AnchorHorizontal="100%" AllowBlank="false" MsgTarget="Side"/> 
                                            </Items>    
                                            <Buttons>
                                                <ext:Button ID="btnUpload" runat="server" Text="Add" Icon="Accept" Disabled="true">
                                                    <DirectEvents>
                                                        <Click OnEvent="UploadNewFile" Before="Ext.Msg.wait('Add new file...', 'Add File');" IsUpload="false" >
                                                            <ExtraParams>
                                                                <ext:Parameter Name="isFolder" Value="#{txtFolderName}.isVisible()" Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
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
                                                <ext:Button  ID="btnAddFolder" runat="server" Icon="FolderAdd" Text="Add Folder">
                                                    <Listeners>
                                                        <Click Handler="#{winUploadFile}.show(); 
                                                                        #{txtFolderName}.setVisible(true); 
                                                                        #{uploadFiled}.setVisible(false);
                                                                        #{txtFolderName}.allowBlank = false; 
                                                                        #{uploadFiled}.allowBlank = true;
                                                                        #{txtFolderName}.validate();" />                                
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button1" runat="server" Icon="Add" Text="Add File">
                                                    <Listeners>
                                                        <Click Handler="#{winUploadFile}.show(); 
                                                                        #{txtFolderName}.setVisible(false); 
                                                                        #{uploadFiled}.setVisible(true); 
                                                                        #{txtFolderName}.allowBlank = true; 
                                                                        #{uploadFiled}.allowBlank = false;
                                                                        #{uploadFiled}.validate();" />                                
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:ToolbarSeparator />
                                                <ext:Button ID="btnDeleteFile" runat="server" Icon="Delete" Text="Delete">
                                                    <DirectEvents>
                                                        <Click OnEvent="DeleteFile">
                                                            <EventMask ShowMask="true" Msg="Deleting..." />
                                                            <Confirmation ConfirmRequest="true" Title="Delete File" Message="This action will delete this item,<br>are you sure?" />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="FileID" Value="#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].FileID" Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                                <ext:ToolbarSeparator />
                                                <ext:Button ID="btnDownload" runat="server" Icon="PackageDown" Text="Download" Tooltip="Download">
                                                    <DirectEvents>
                                                        <Click OnEvent="DownloadFile" IsUpload="true">
                                                            <ExtraParams>
                                                                <ext:Parameter Name="FileID" Value="#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].FileID" Mode="Raw" />
                                                                <ext:Parameter Name="IsFolder" Value="#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].IsFolder" Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                                <ext:ToolbarFill />
                                                <ext:Button runat="server" ID="btnRateFileUp" ToolTip="Reload" Icon="ThumbUp" Disabled="true">
                                                    <Listeners>
                                                        <Click Handler="if(#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].IsFolder == false)
                                                                            #{DirectMethods}.RateFile(#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].FileID, 1);"/>
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button runat="server" ID="btnRateFileDown" ToolTip="Reload" Icon="ThumbDown" Disabled="true">
                                                    <Listeners>
                                                        <Click Handler="if(#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].IsFolder == false)
                                                                            #{DirectMethods}.RateFile(#{pnlFileView}.getRowsValues({ selectedOnly : true })[0].FileID, 0);"/>
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:ToolbarSeparator />
                                                <ext:Button runat="server" ID="btnReload" ToolTip="Reload" Icon="ArrowRefresh">
                                                    <Listeners>
                                                        <Click Handler="#{DirectMethods}.LoadFiles(-1);"/>
                                                    </Listeners>
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
                                                                        <ext:ModelField Name="Size" Type="String" />
                                                                        <ext:ModelField Name="LastModify" Type="String" />
                                                                        <ext:ModelField Name="Rate" Type="String" />
                                                                        <ext:ModelField Name="Type" Type="String" />
                                                                        <ext:ModelField Name="Owner" Type="String" />
                                                                        <ext:ModelField Name="IsFolder" Type="Boolean" />
                                                                        <ext:ModelField Name="OwnerID" Type="Int" />
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
                                                                    <span style="text-align:center; overflow:hidden; width:64px; text-overflow:ellipsis">{FileName}</span>
                                                                </div>
                                                            </tpl>
                                                        </Html>
                                                    </Tpl>
                                                    <Listeners>
                                                        <SelectionChange Handler="if(selections[0]){App.pnlItemInfo.loadRecord(selections[0])};
                                                                                  #{btnRateFileUp}.setDisabled(false);
                                                                                  #{btnRateFileDown}.setDisabled(false);" />
                                                        <Refresh Handler="this.el.select('.thumb-wrap').addClsOnOver('x-view-over');" Delay="100" />
                                                        <ItemDblClick Handler="#{DirectMethods}.UpdateViewPanel(this.store.getAt(index).data.FileID)" />                                                 
                                                    </Listeners>
                                                </ext:DataView>
                                            </Items>
                                        </ext:Panel>
                                        <ext:Panel ID="pnlItemInfo" runat="server" AnchorVertical="100%" Height="150" Region="South" Title="Item Info" Collapsed="false" Collapsible="true" Frame="false">
                                            <CustomConfig>
                                                <ext:ConfigItem Name="loadRecord" Value="function(file){
                                                    if(file.data.FileName != 'Go Back')
                                                    {
                                                        if(file.data.IsFolder == false)
                                                        {
                                                            this.body.hide();
                                                            this.tpl.overwrite(App.pnlItemInfo.body, file.data);
                                                            this.body.slideIn('t', {
                                                                duration: 250
                                                            });
                                                        }
                                                        else
                                                        {
                                                            this.body.hide();
                                                        }
                                                    }}" 
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
                                                                        <td>{Size}</td>
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
                        <ext:Panel ID="pnlFourm" runat="server" AutoScroll="true" Title="Forum">
                            <TopBar>
                                <ext:Toolbar ID="Toolbar3" runat="server">
                                    <Items>
                                        <ext:Button ID="Button3" runat="server" Icon="Add" Text="Add New">
                                            <Listeners>
                                                <Click Handler="#{winNewComment}.show();#{hiddenItemId}.setValue(-1);" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="btnAddComment" runat="server" Icon="CommentAdd" Text="Add Comment" Disabled="true">
                                            <Listeners>
                                                <Click Handler="#{winNewComment}.show();#{hiddenItemId}.setValue(#{forumItemView}.getRowsValues({ selectedOnly : true })[0].ItemID);" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="btnDeleteComment" runat="server" Icon="Delete" Text="Delete">
                                            <DirectEvents>
                                                <Click OnEvent="DeleteFourmItem">
                                                    <ExtraParams>
                                                        <ext:Parameter Name="ItemID" Value="#{forumItemView}.getRowsValues({ selectedOnly : true })[0].ItemID" Mode="Raw" />
                                                    </ExtraParams>
                                                    <Confirmation ConfirmRequest="true" Title="Delete Comment" Message="This action will delete this item and all his sub items<br>are you sure?" />
                                                    <EventMask ShowMask="true" Msg="Deleting..." Target="CustomTarget" CustomTarget="winCourse" />
                                                </Click>
                                            </DirectEvents>
                                        </ext:Button>
                                        <ext:ToolbarFill />
                                        <ext:Button runat="server" ID="btnRateCommentUp" ToolTip="Reload" Icon="ThumbUp" Disabled="true">
                                            <Listeners>
                                                <Click Handler="#{DirectMethods}.RateComment(#{forumItemView}.getRowsValues({ selectedOnly : true })[0].ItemID, 1);"/>
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button runat="server" ID="btnRateCommentDown" ToolTip="Reload" Icon="ThumbDown" Disabled="true">
                                            <Listeners>
                                                <Click Handler="#{DirectMethods}.RateComment(#{forumItemView}.getRowsValues({ selectedOnly : true })[0].ItemID, 0);"/>
                                            </Listeners>
                                        </ext:Button>
                                        <ext:ToolbarSeparator />
                                        <ext:Button ID="Button7" runat="server" Icon="ArrowRefresh">
                                            <Listeners>
                                                    <Click Handler="#{DirectMethods}.LoadForum();" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:Window ID="winNewComment" runat="server" Closable="true" Icon="CommentAdd" Title="Add Comment" Resizable="false" Draggable="true" Minimizable="true" Width="500" Height="250" Layout="FitLayout" Hidden="true" CloseAction="Hide">
                                        <Items>
                                        <ext:FormPanel ID="FormPanel3" runat="server" Frame="true">
                                            <Items>
                                                <ext:TextField runat="server" Margin="5" ID="txtTitle" FieldLabel="Title" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side" />
                                                <ext:TextArea runat="server" Margin="5" ID="taContent" FieldLabel="Content" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side"
                                                    AutoScroll="true" Height="150" />
                                                <ext:Hidden runat="server" ID="hiddenItemId" Name="ItemID" />
                                            </Items>    
                                            <Buttons>
                                                <ext:Button ID="btnAdd" runat="server" Text="Add" Icon="CommentAdd" Disabled="true">
                                                    <Listeners>
                                                        <Click Handler="#{DirectMethods}.AddNewFormItem();" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button9" runat="server" Text="Cancel" Icon="Cancel">
                                                    <Listeners>
                                                        <Click Handler="#{winNewComment}.hide();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Buttons>    
                                            <Listeners>
                                                <ValidityChange Handler="#{btnAdd}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Window>

                                <ext:DataView runat="server" SingleSelect="true" ItemSelector="div.thumb-wrap" Cls="img-chooser-view" AutoScroll="true" ID="forumItemView">
                                    <Store>
                                        <ext:Store runat="server" ID="storeQA">
                                            <Model>
                                                <ext:Model ID="Model4" runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="ItemID" Type="Int" /> 
                                                        <ext:ModelField Name="Title" Type="String" /> 
                                                        <ext:ModelField Name="Content" Type="String" /> 
                                                        <ext:ModelField Name="OwnerName" Type="String" />
                                                        <ext:ModelField Name="TimeAdded" Type="String" />
                                                        <ext:ModelField Name="Level" Type="Int" />
                                                        <ext:ModelField Name="Rate" Type="String" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Tpl ID="Tpl2" runat="server">
                                        <Html>
                                        <tpl for=".">
                                            <div class="thumb-wrap" style="margin-left:{Level}px">
                                                <p class="forumTitle"><img src="Images/post.gif" />{Title}</p>
                                                <div style="color:gray; margin-left:15px">By: {OwnerName}</div>
                                                <p class="forumContent">{Content}</p>
                                                <div style="text-align:right">{Rate}</div>
                                                <div style="color:gray;text-align:right">{TimeAdded}</div>
                                                <hr />
                                            </div>
                                            </tpl>
                                        </Html>
                                    </Tpl>
                                    <Listeners>
                                        <SelectionChange Handler="#{btnAddComment}.setDisabled(false);
                                                                  #{btnRateCommentUp}.setDisabled(false);
                                                                  #{btnRateCommentDown}.setDisabled(false);" />
                                        <Refresh Handler="this.el.select('thumb-wrap').addClsOnOver('forum-over');" Delay="100" />
                                    </Listeners>
                                </ext:DataView>
                            </Items>
                        </ext:Panel>
                        <ext:Panel ID="pnlUsers" runat="server" Title="Course User" Layout="BorderLayout">
                            <Items>
                                <ext:Window ID="winAddUser" runat="server" Closable="true" Icon="UserAdd" Title="Add User" Resizable="false" Draggable="true" Minimizable="true" Width="400" Height="150" Layout="FitLayout" Hidden="true" CloseAction="Hide">
                                        <Items>
                                        <ext:FormPanel ID="FormPanel2" runat="server" Frame="true">
                                            <Items>
                                                <ext:ComboBox runat="server" Margin="5" ID="cbAddUserName" FieldLabel="User Name" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side"
                                                              TriggerAction="Query" DisplayField="UserName" ValueField="UserName" TypeAhead="false" HideBaseTrigger="true"
                                                              MinChars="1" >
                                                    <ListConfig LoadingText="Searching...">
                                                        <ItemTpl runat="server">
                                                            <Html>
                                                                <div class="search-item">
							                                        <b>{UserName}</b>
						                                        </div>
                                                            </Html>
                                                        </ItemTpl>
                                                    </ListConfig>
                                                    <Store>
                                                        <ext:Store runat="server" ID="storeUserName">
                                                            <Proxy>
                                                                <ext:PageProxy DirectFn="App.direct.GetAllUsers" />
                                                            </Proxy>
                                                            <Model>
                                                                <ext:Model runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="UserName" Type="String" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                </ext:ComboBox>
                                            </Items>    
                                            <Buttons>
                                                <ext:Button ID="btnAddNewUser" runat="server" Text="Add" Icon="Accept" Disabled="true">
                                                    <Listeners>
                                                        <Click Handler="#{DirectMethods}.AddNewUserToCourse();" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button ID="Button5" runat="server" Text="Cancel" Icon="Cancel">
                                                    <Listeners>
                                                        <Click Handler="#{winAddUser}.hide();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Buttons>    
                                            <Listeners>
                                                <ValidityChange Handler="#{btnAddNewUser}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Window>
                                <ext:Panel runat="server" Region="Center">
                                    <TopBar>
                                        <ext:Toolbar runat="server">
                                            <Items>
                                                <ext:Button runat="server" Icon="UserAdd" Text="Add user">
                                                    <Listeners>
                                                        <Click Handler="#{winAddUser}.show();" />
                                                    </Listeners>
                                                </ext:Button>
                                                <ext:Button runat="server" Icon="UserDelete" Text="Remove user">
                                                    <DirectEvents>
                                                        <Click OnEvent="RemoveUserFromCourse">
                                                            <EventMask ShowMask="true" Msg="Removing..." />
                                                            <Confirmation ConfirmRequest="true" Title="Remove User" Message="This action will remove user from the course,<br>are you sure?" />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="UserID" Value="#{pnlUsersView}.getRowsValues({ selectedOnly : true })[0].UserID" Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                                <ext:Button runat="server" Icon="StarGold" Text="Make as admin" >
                                                    <DirectEvents>
                                                        <Click OnEvent="SetUserAsAbmin">
                                                            <EventMask ShowMask="true" Msg="Proccesing..." />
                                                            <Confirmation ConfirmRequest="true" Title="Remove User" Message="This user will be added as admin in this course,<br>are you sure?" />
                                                            <ExtraParams>
                                                                <ext:Parameter Name="UserID" Value="#{pnlUsersView}.getRowsValues({ selectedOnly : true })[0].UserID" Mode="Raw" />
                                                            </ExtraParams>
                                                        </Click>
                                                    </DirectEvents>
                                                </ext:Button>
                                                <ext:ToolbarFill />
                                                <ext:Button runat="server" Icon="ArrowRefresh">
                                                    <Listeners>
                                                        <Click Handler="#{DirectMethods}.LoadUsers();" />
                                                    </Listeners>
                                                </ext:Button>
                                            </Items>
                                        </ext:Toolbar>
                                    </TopBar>
                                    <Items>
                                        <ext:DataView runat="server" SingleSelect="true" ItemSelector="div.thumb-wrap" Cls="img-chooser-view" AutoScroll="true" ID="pnlUsersView" >
                                            <Store>
                                                <ext:Store runat="server" ID="storeUserView">
                                                    <Model>
                                                        <ext:Model ID="Model2" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="UserID" Type="Int" /> 
                                                                <ext:ModelField Name="UserName" Type="String" /> 
                                                                <ext:ModelField Name="FirstName" Type="String" /> 
                                                                <ext:ModelField Name="LastName" Type="String" />
                                                                <ext:ModelField Name="Email" Type="String" />
                                                                <ext:ModelField Name="IsAdmin" Type="Boolean" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <Tpl ID="Tpl1" runat="server">
                                                <Html>
                                                    <tpl for=".">
                                                        <div class="thumb-wrap">
                                                            <div class="thumb">
                                                                <tpl if="!Ext.isIE6">
                                                                    <tpl if="IsAdmin">
                                                                        <img src="Images/adminuser.png" height="64px" width="64px" />
                                                                    </tpl>
                                                                    <tpl if="!IsAdmin">
                                                                        <img src="Images/user.png" height="64px" width="64px" />
                                                                    </tpl>
                                                                </tpl>
                                                                <tpl if="Ext.isIE6">
                                                                    <tpl if="IsAdmin == true">
                                                                        <div style="width:64px;height:64px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="Images/adminuser.png")"></div>
                                                                    </tpl>
                                                                    <tpl if="IsAdmin == False">
                                                                        <div style="width:64px;height:64px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="Images/user.png")"></div>
                                                                    </tpl>
                                                                </tpl>                    
                                                            </div>
                                                            <span style="text-align:center; overflow:hidden; width:64px; text-overflow:ellipsis">{UserName}</span>
                                                        </div>
                                                    </tpl>
                                                </Html>
                                            </Tpl>
                                            <Listeners>
                                                <SelectionChange Handler="if(selections[0]){App.pnlUserDetails.loadUser(selections[0])}" />
                                                <Refresh Handler="this.el.select('.thumb-wrap').addClsOnOver('x-view-over');" Delay="100" />
                                            </Listeners>
                                        </ext:DataView>
                                    </Items>
                                </ext:Panel>
                                <ext:Panel runat="server" Region="East" ID="pnlUserDetails" Title="User Details" Width="180">
                                    <CustomConfig>
                                        <ext:ConfigItem Name="loadUser" Value="function(user){
                                                    this.body.hide();
                                                    this.tpl.overwrite(App.pnlUserDetails.body, user.data);
                                                    this.body.slideIn('l', {duration: 250});
                                            }" 
                                            Mode="Raw" />
                                    </CustomConfig>
                                    <Tpl runat="server">
                                        <Html>
                                            <div class="details">
                                                <tpl for=".">   
                                                    <div style="text-align: center;">
                                                        <tpl if="!Ext.isIE6">
                                                                    <tpl if="IsAdmin">
                                                                        <img src="Images/adminuser.png" height="90px" width="90px" />
                                                                    </tpl>
                                                                    <tpl if="!IsAdmin">
                                                                        <img src="Images/user.png" height="90px" width="90px" />
                                                                    </tpl>
                                                                </tpl>
                                                                <tpl if="Ext.isIE6">
                                                                    <tpl if="IsAdmin">
                                                                        <div style="width:90px;height:90px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="Images/adminuser.png")"></div>
                                                                    </tpl>
                                                                    <tpl if="!IsAdmin">
                                                                        <div style="width:90px;height:90px;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(src="Images/user.png")"></div>
                                                                    </tpl>
                                                                </tpl>
                                                    </div>
                                                    <hr />
                                                    <div class="details-info">
                                                        <b style="margin:15px;line-height:20px">First Name:</b></br>
                                                        <span style="margin:25px;line-height:20px">{FirstName}</span></br>
                                                        <b style="margin:15px;line-height:20px">Last Name:</b></br>
                                                        <span style="margin:25px;line-height:20px">{LastName}</span></br>
                                                        <b style="margin:15px;line-height:20px">User Name:</b></br>
                                                        <span style="margin:25px;line-height:20px">{UserName}</span></br>
                                                        <b style="margin:15px;line-height:20px">Email:</b></br>
                                                        <span style="margin:25px;line-height:20px">{Email}</span></br>
                                                    </div> 
                                                </tpl>
                                            </div>
                                        </Html>
                                    </Tpl>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>
                        <ext:Panel ID="pnlSettings" runat="server" Title="Course Settings" Layout="BorderLayout">
                            <Items>
                                <ext:Panel runat="server" Layout="BorderLayout" Border="false" Region="Center">
                                    <Items>
                                        <ext:FormPanel  runat="server" Layout="FitLayout" Border="false" Region="East">
                                            <Items>
                                                <ext:FieldSet Title="Add Message" runat="server" Collapsible="false" Margin="10">
                                                    <Items>
                                                        <ext:DisplayField runat="server" Text="Subject:" Margin="15" />
                                                        <ext:TextField runat="server" ID="txtCASubject" Width="300" Margin="15" AllowBlank="false" MsgTarget="Side" />
                                                        <ext:DisplayField runat="server" Text="Message:" Margin="15" />
                                                        <ext:TextArea runat="server" ID="taMessage" Margin="15" Width="300" Height="150" AllowBlank="false" MsgTarget="Side" />
                                                        <ext:FieldContainer ID="FieldContainer1" runat="server" Layout="HBoxLayout" >
                                                            <Defaults>
                                                                <ext:Parameter Name="margins" Value="20 0 0 260" Mode="Value" />
                                                            </Defaults>
                                                            <Items>
                                                                <ext:Button runat="server" Icon="EmailGo" Text="Send" ID="btnSendMsg" Disabled="true">
                                                        
                                                                </ext:Button>
                                                            </Items>
                                                        </ext:FieldContainer>
                                                    </Items>
                                                </ext:FieldSet>
                                            </Items>
                                            <Listeners>
                                                  <ValidityChange Handler="#{btnSendMsg}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                        <ext:FormPanel ID="Panel2" runat="server" Layout="FitLayout" Border="false" Region="Center">
                                            <Items>
                                                <ext:FieldSet ID="FieldSet1" Title="Course Details" runat="server" Collapsible="false" Margin="10" >
                                                    <Items>
                                                        <ext:TextField runat="server" FieldLabel="Course Name:" ID="txtCourseNameChange" Width="330" Margin="15" AllowBlank="false" />
                                                        <ext:ComboBox runat="server" ID="cmbFolderColor1" Editable="false" FieldLabel="Folder Color" Margin="15" AllowBlank="false"
                                                            Width="330" DisplayField="text" ValueField="iconCls">
                                                            <Store>
                                                                <ext:Store ID="storeFolderColors1" runat="server">
                                                                    <Model>
                                                                        <ext:Model ID="Model3" runat="server">
                                                                            <Fields>
                                                                                <ext:ModelField Name="text" />
                                                                                <ext:ModelField Name="iconCls" />
                                                                            </Fields>
                                                                        </ext:Model>
                                                                    </Model>            
                                                                </ext:Store>
                                                            </Store>
                                                            <ListConfig>
                                                                <ItemTpl ID="ItemTpl2" runat="server">
                                                                    <Html>
                                                                        <img src="Images/FolderIcons/{text}.png" width="20" style="text-align:center"> {text}</img>
                                                                    </Html>
                                                                </ItemTpl>
                                                            </ListConfig>
                                                        </ext:ComboBox>
                                                        <ext:FieldContainer ID="fcSaveChanges" runat="server" Layout="HBoxLayout">
                                                            <Defaults>
                                                                <ext:Parameter Name="margins" Value="20 0 0 290" Mode="Value" />
                                                            </Defaults>
                                                            <Items>
                                                                <ext:Button ID="btnSaveChanges" runat="server" Icon="Disk" Text="Save">
                                                                    <Listeners>
                                                                        <Click Handler="#{DirectMethods}.UpdateCourse();document.location.reload(true);" />
                                                                    </Listeners>
                                                                </ext:Button>
                                                            </Items>
                                                        </ext:FieldContainer>
                                                    </Items>
                                                 </ext:FieldSet>
                                            </Items>
                                            <Listeners>
                                                  <ValidityChange Handler="#{btnSaveChanges}.setDisabled(!valid);" />
                                            </Listeners>
                                        </ext:FormPanel>
                                    </Items>
                                </ext:Panel>
                                <ext:Panel runat="server" Layout="FitLayout" Border="false" Height="150" Region="South">
                                    <Items>
                                        <ext:FieldSet Title="Dangerous Area" runat="server" Collapsible="false" Margin="10">
                                            <Items>
                                                <ext:DisplayField runat="server" Text="<b>Delete this Course</b>" StyleHtmlContent="true"/>
                                                <ext:DisplayField ID="DisplayField1" runat="server" Text="Once you delete a course, there is no going back. (all files will be deleted)." Margin="10" />
                                                <ext:FieldContainer runat="server" Layout="HBoxLayout">
                                                    <Defaults>
                                                        <ext:Parameter Name="margins" Value="20 0 0 680" Mode="Value" />
                                                    </Defaults>
                                                    <Items>
                                                        <ext:Button runat="server" Icon="Delete" Text="Delete" ID="btnDeleteCourse">
                                                            <DirectEvents>
                                                                <Click OnEvent="DeleteCourse" After="document.location.reload(true);">
                                                                    <Confirmation ConfirmRequest="true" Title="Delete Course" Message="This operation can not be undo.<br>Do you want to proceed?" />
                                                                </Click>
                                                            </DirectEvents>
                                                        </ext:Button>
                                                    </Items>
                                                </ext:FieldContainer>
                                           </Items>
                                        </ext:FieldSet>
                                    </Items>
                                </ext:Panel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
