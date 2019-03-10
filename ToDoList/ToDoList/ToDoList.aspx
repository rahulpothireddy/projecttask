<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ToDoList.aspx.cs" Inherits="ToDoList.ToDoList" MasterPageFile="~/Site.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <!DOCTYPE html>

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
                COLOR: navy
            }
        </style>

    </head>
    <body>
        <br />
        <div class="alert alert-success">
            <strong><%=_title %></strong>
        </div>
        <div class="inline">
            <a href="EditItem.aspx" class="btn btn-primary">Add New Item</a>
            <a href="ToDoList.aspx?query=0" class="btn btn-primary">Show All Items</a>
            <a href="ToDoList.aspx?query=1" class="btn btn-primary">Show All Closed Items</a>
            <a href="ToDoList.aspx?query=2" class="btn btn-primary">Show All Open Items</a>
        </div>
        <p>
            <asp:DataGrid ID="ToDoDataGrid" runat="server" OnItemCommand="ToDoDataGrid_Command" Width="100%" GridLines="Vertical" Class="table" AutoGenerateColumns="False" OnItemDataBound="ToDoDataGrid_ItemDataBound">
                <Columns>
                    <asp:BoundColumn Visible="false" DataField="ID" />
                    <asp:TemplateColumn ItemStyle-Width="12">
                        <ItemTemplate>
                            <img src='<%# _priorityUrls[(int)DataBinder.Eval(Container.DataItem, "Priority") - 1] %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn ItemStyle-Width="" HeaderText="Description">
                        <ItemTemplate>
                            <asp:HyperLink ID="lnkReceiveItem" Text='<%# String.Format("{0}",DataBinder.Eval(Container.DataItem, "Description").ToString()) %>' ForeColor="Black" NavigateUrl='<%# String.Format("~/ChildItems.aspx?ItemID={0}",DataBinder.Eval(Container.DataItem, "ID").ToString()) %>' Font-Underline="false" runat="server"></asp:HyperLink>
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:BoundColumn HeaderText="EndDate" DataField="EndDate" />
                </Columns>
                <HeaderStyle BackColor="teal" ForeColor="white" Font-Bold="true" />
                <ItemStyle BackColor="white" ForeColor="darkblue" />
                <AlternatingItemStyle BackColor="beige" ForeColor="darkblue" />
            </asp:DataGrid>
        </p>
        <p></p>
    </body>
    </html>
</asp:Content>
