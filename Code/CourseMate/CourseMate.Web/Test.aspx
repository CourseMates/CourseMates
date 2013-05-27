<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="CourseMate.Web.Test" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<%@ Register Src="~/CourseWindow.ascx" TagPrefix="mod" TagName="CourseWindow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        tr
        {
            height:30px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="display:table-row; height:auto">
        <div style="display:table-cell; width:64px; float:left">
            
        </div>
        <div style="display:table-cell; width:auto; float:right">
            <table width="100%">
                <tr>
                    <td>File Name:</td>
                    <td>{FileName}</td>
                    <td>Size:</td>
                    <td>{Size}</td>
                </tr>
                <tr>
                    <td>Last Modify:</td>
                    <td>{LastModify}</td>
                    <td>Rate:</td>
                    <td>{Rate}</td>
                </tr>
                <tr>
                    <td>Type:</td>
                    <td>{Type}</td>
                    <td>Owner:</td>
                    <td>{Owner}</td>
                </tr>
            </table>
        </div>
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