<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubItem.aspx.cs" Inherits="ToDoList.SubItem" MasterPageFile="~/Site.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
        <script>
            function CLICK() {
                debugger
                if ($('#MainContent_DescriptionTextBox').val() == "" || $('#MainContent_DescriptionTextBox').val() == 'undefined') {
                    debugger
                    alert('Please enter Description');
                    $('#MainContent_DescriptionTextBox').focus();

                    return false;
                }
            }
        </script>
    </head>
    <body>
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

            <div class="col-md-1">
                <div style="height: 19px;"></div>

                <asp:LinkButton ID="SaveButton" OnClick="SaveButton_Click" OnClientClick="return CLICK();" Text="Save Changes" class="btn btn-primary" runat="server"></asp:LinkButton>
            </div>
        </div>
        <div class="row">
            <asp:Label ID="ErrorLabel" runat="server" Text="" Visible="False" ForeColor="Red"></asp:Label>
        </div>
    </body>
    </html>
</asp:Content>
