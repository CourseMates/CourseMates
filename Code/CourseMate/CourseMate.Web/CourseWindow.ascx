<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CourseWindow.ascx.cs" Inherits="CourseMate.Web.CourseWindow" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<script type="text/javascript">
    var filterTree = function (tf, e) {
        var tree = App.TreePanel1,
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
                tree = App.TreePanel1;

        field.setValue("");
        tree.clearFilter(true);
        tree.getView().focus();
    };
</script>

<ext:ResourceManager ID="ResourceManager1" runat="server" />
<ext:Window ID="winCourse" runat="server" Closable="true" Resizable="false" Minimizable="true" Width="800" Height="600" Layout="FitLayout">
    <TopBar>

    </TopBar> 
    <Items>
        <ext:TabPanel ID="TabPanel1" runat="server" Layout="FitLayout">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Title="Files" Frame="true" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:TreePanel ID="TreePanel1" runat="server" AutoScroll="true" Width="230" Animate="true" Region="West">           
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
                    </ext:TreePanel>
                    <ext:Panel ID="Panel2" runat="server" Region="Center" AnchorVertical="100%" >
                        <TopBar>
                            <ext:Toolbar ID="Toolbar2" runat="server">
                                <Items>
                                    <ext:Button ID="Button1" runat="server" Icon="Add" Text="Add File">
                                         <Listeners>
                                            <Click Handler="Ext.Msg.alert('Add File','Click on Add');" />                                
                                         </Listeners>
                                        <ToolTips>
                                            <ext:ToolTip ID="ToolTip1" runat="server" Html="Simple button" />
                                        </ToolTips>

                                    </ext:Button>
                                    <ext:Button ID="Button2" runat="server" Icon="Delete" Text="Delete File">
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button  ID="Button3" runat="server" Icon="FolderAdd" Text="Add Folder">
                                    </ext:Button>
                                    <ext:Button ID="Button4" runat="server" Icon="FolderDelete" Text="Delete Folder">
                                    </ext:Button>
                                    <ext:ToolbarSeparator />
                                    <ext:Button ID="Button5" runat="server" Icon="PackageDown" Text="Download" Tooltip="Download">
                                    </ext:Button>
                                    <ext:ToolbarFill />
                                    <ext:Button ID="Button6" runat="server" Icon="ThumbUp">
                                    </ext:Button>
                                    <ext:Button ID="Button7" runat="server" Icon="ThumbDown">
                                    </ext:Button>
                                    <ext:Label ID="Label1" runat="server" Text="5"/>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>
                    </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel3" runat="server" Title="Fourm">
                </ext:Panel>
                <ext:Panel ID="Panel4" runat="server" Title="Course User">
                </ext:Panel>
                <ext:Panel ID="Panel5" runat="server" Title="Course Settings">
                </ext:Panel>
            </Items>
        </ext:TabPanel>
            
    </Items>
</ext:Window>
<ext:Window ID="Window1" runat="server" Closable="true" Icon="Add" Title="Add File" Resizable="false" Draggable="true" Minimizable="true" Width="400" Height="150" Layout="FitLayout">
     <Items>
        <ext:FormPanel ID="FormPanel1" runat="server" Frame="true">
            <Items>
                <ext:TextField ID="Name" runat="server" FieldLabel="Flie Name" Margin="5"  MsgTarget="Side" AnchorHorizontal="100%"  />
                <ext:FileUploadField ID="FileUploadField1" Margin="5" runat="server" EmptyText="Select File" FieldLabel="File" ButtonText="Browse..." AnchorHorizontal="100%" /> 
            </Items>        
        </ext:FormPanel>
    </Items>
    <Buttons>
        <ext:Button ID="Button8" runat="server" Text="Cancel" Icon="Cancel">
            <Listeners>
                <Click Handler="#{winAddNEwCourse}.hide();" />
            </Listeners>
        </ext:Button>
        <ext:Button ID="Button9" runat="server" Text="Upload" Icon="Accept">
            <DirectEvents>
                <Click OnEvent="UploadClick" Before="Ext.Msg.wait('Uploading...', 'Uploading');" />
            </DirectEvents>
        </ext:Button>

    </Buttons>
</ext:Window>
