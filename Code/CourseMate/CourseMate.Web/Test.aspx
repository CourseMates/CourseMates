<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="CourseMate.Web.Test" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="CSS/MainCss.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <ext:ResourceManager runat="server" />
        <ext:Window ID="winCourse" runat="server" Closable="true" Resizable="false" Minimizable="true" Width="800" Height="600" Layout="FitLayout" Icon="BookOpen" Hidden="false">
            <Items>
        <ext:Panel ID="pnlFourm" runat="server" AutoScroll="true">
                            <TopBar>
                                <ext:Toolbar ID="Toolbar1" runat="server">
                                    <Items>
                                        <ext:Button ID="Button1" runat="server" Icon="Add" Text="Add New">
                                            <Listeners>
                                                <Click Handler="#{winNewComment}.show();#{hiddenItemId}.setValue(0);" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="btnAddComment" runat="server" Icon="CommentAdd" Text="Add Comment" Disabled="true">
                                            <Listeners>
                                                <Click Handler="#{winNewComment}.show();#{hiddenItemId}.setValue(#{forumItemView}.getRowsValues({ selectedOnly : true })[0].ItemID);" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button ID="Button3" runat="server" Icon="Delete" Text="Delete">
                                        </ext:Button>
                                        <ext:ToolbarFill />
                                        <ext:Button ID="Button4" runat="server" Icon="ArrowRefresh">
                                            <Listeners>
                                                    <Click Handler="#{DirectMethods}.Refresh();" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:Window ID="winNewComment" runat="server" Closable="true" Icon="CommentAdd" Title="Add Comment" Resizable="false" Draggable="true" Minimizable="true" Width="500" Height="250" Layout="FitLayout" Hidden="true" CloseAction="Hide">
                                        <Items>
                                        <ext:FormPanel ID="FormPanel1" runat="server" Frame="true">
                                            <Items>
                                                <ext:TextField runat="server" Margin="5" ID="txtTitle" FieldLabel="Title" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side" />
                                                <ext:TextArea runat="server" Margin="5" ID="taContent" FieldLabel="Content" AllowBlank="false" AnchorHorizontal="100%" MsgTarget="Side"
                                                    AutoScroll="true" Height="150" />
                                                <ext:Hidden runat="server" ID="hiddenItemId" Name="ItemID" />
                                            </Items>    
                                            <Buttons>
                                                <ext:Button ID="btnAdd" runat="server" Text="Add" Icon="CommentAdd" Disabled="true">
                                                </ext:Button>
                                                <ext:Button ID="Button8" runat="server" Text="Cancel" Icon="Cancel">
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
                                                                <ext:ModelField Name="Owner" Type="String" />
                                                                <ext:ModelField Name="Date" Type="Date" />
                                                                <ext:ModelField Name="Level" Type="Int" />
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
                                                        <div style="color:gray; margin-left:15px">By: {Owner}</div>
                                                        <p class="forumContent">{Content}</p>
                                                        <div style="color:gray;text-align:right">{Date}</div>
                                                        <hr />
                                                    </div>
                                                    </tpl>
                                                </Html>
                                            </Tpl>
                                            <Listeners>
                                                <SelectionChange Handler="#{btnAddComment}.setDisabled(false);" />
                                                <Refresh Handler="this.el.select('thumb-wrap').addClsOnOver('forum-over');" Delay="100" />
                                            </Listeners>
                                        </ext:DataView>
                            </Items>
                        </ext:Panel>
                        </Items>
                        </ext:Window>   
    </div>
    </form>
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