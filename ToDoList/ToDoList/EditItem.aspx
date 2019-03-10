<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditItem.aspx.cs" Inherits="ToDoList.EditItem" MasterPageFile="~/Site.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
    <html>
    <head>
        <title></title>
        <meta content="Microsoft Visual Studio 7.0" name="GENERATOR">
        <meta content="C#" name="CODE_LANGUAGE">
        <meta content="JavaScript" name="vs_defaultClientScript">
        <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">

        <style type="text/css">
            H1 {
                FONT-SIZE: 12pt;
                LINE-HEIGHT: 2pt;
                FONT-FAMILY: Verdana
            }

            BODY {
                FONT-SIZE: 8pt;
                FONT-FAMILY: Verdana
            }

            A {
                COLOR: blue
            }

                A:visited {
                    COLOR: blue
                }
        </style>
        <script>
            function CLICK() {
                debugger
                if (($('#MainContent_DescriptionTextBox').val() == "" || $('#MainContent_DescriptionTextBox').val() == 'undefined') && ($('#MainContent_txtLastDate').val() == "" || $('#MainContent_txtLastDate').val() == 'undefined')) {
                    debugger
                    alert('Please enter All Fields');
                    $('#MainContent_DescriptionTextBox').focus();

                    return false;
                }
            }


        </script>
    </head>
    <body>
        <script for="window" event="onload">
            window.document.forms["EditItemForm"].children["DescriptionTextBox"].focus();
        </script>
        <h1><%=_title%></h1>
        <br />
        <div class="row">
            <div class="col-md-3">
                <div class="form-group">
                    <label for="DescriptionTextBox">Description:</label>
                    <asp:TextBox ID="DescriptionTextBox" runat="server" CssClass="form-control" Font-Name="Verdana" Font-Size="8pt" Width="100%"></asp:TextBox>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="PriorityList">Priority:</label>
                    <asp:DropDownList ID="PriorityList" CssClass="form-control" Font-Name="Verdana" Font-Size="8pt" runat="server"></asp:DropDownList>
                </div>
            </div>
            <div class="col-md-3">
                <div class="form-group">
                    <label for="PriorityList">TaskLastDate:</label>
                    <asp:TextBox ID="txtLastDate" runat="server" CssClass="form-control" Font-Name="Verdana" Font-Size="8pt" Width="100%"></asp:TextBox>
                </div>
            </div>

            <div class="col-md-1">
                <div style="height: 19px;"></div>

                <asp:LinkButton ID="SaveButton" OnClick="SaveButton_Click" Text="Save Changes" class="btn btn-primary" OnClientClick="return CLICK();" runat="server"></asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <h3 style="color: red; display: none;" id="warning">text area is empty</h3>
        </div>


        <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

        <script>
            $(function () {
                $("#MainContent_txtLastDate").datepicker({ minDate: new Date() });
            });
        </script>

    </body>
    </html>
</asp:Content>
