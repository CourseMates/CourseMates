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

<ext:ResourceManager runat="server" />
<ext:Window ID="winCourse" runat="server" Closable="true" Resizable="false" Minimizable="true" Width="800" Height="600" Layout="FitLayout">
    <TopBar>

    </TopBar> 
    <Items>
        <ext:TabPanel runat="server" Layout="FitLayout">
            <Items>
                <ext:Panel runat="server" Title="Files" Frame="true" AutoHeight="true" Layout="BorderLayout">
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
                                    <ext:ToolbarFill />
                                    <ext:Button ID="btnAddNewFolder" Icon="FolderAdd" runat="server">
                                    
                                    </ext:Button>
                                </Items>
                            </ext:Toolbar>
                        </TopBar>            
                    </ext:TreePanel>
                    <ext:Panel runat="server" Region="Center" AnchorVertical="100%" >
                    </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Title="Fourm">
                </ext:Panel>
                <ext:Panel runat="server" Title="Course User">
                </ext:Panel>
                <ext:Panel runat="server" Title="Course Settings">
                </ext:Panel>
            </Items>
        </ext:TabPanel>
        
    </Items>
</ext:Window>
