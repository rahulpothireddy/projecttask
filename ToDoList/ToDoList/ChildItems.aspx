<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChildItems.aspx.cs" Inherits="ToDoList.ChildItems" MasterPageFile="~/Site.Master" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title></title>
    </head>
    <body>
        <div>
            <asp:Label runat="server" ID="lblDescription"></asp:Label>
        </div>
        <div class="inline">
            <a id="asub" runat="server" class="btn btn-primary">Add New Sub-Task</a>
            <a href="ChildItems.aspx?query=0" class="btn btn-primary">Show All Items</a>
            <a href="ChildItems.aspx?query=1" class="btn btn-primary">Show All Closed Items</a>
            <a href="ChildItems.aspx?query=2" class="btn btn-primary">Show All Open Items</a>
        </div>
        <p>
            <asp:DataGrid ID="ToDoDataGrid" runat="server" OnItemCommand="ToDoDataGrid_Command" Width="100%" Class="table" GridLines="Vertical" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundColumn Visible="false" DataField="ID" />
                    <asp:TemplateColumn ItemStyle-Width="12">
                        <ItemTemplate>
                            <img src='<%# _priorityUrls[(int)DataBinder.Eval(Container.DataItem, "Priority") - 1] %>' />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <%--<asp:TemplateColumn ItemStyle-Width="" HeaderText="Description">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkReceiveItem" Text='<%# String.Format("{0}",DataBinder.Eval(Container.DataItem, "Description").ToString()) %>' ForeColor="#3399ff" CssClass="ButEmpty" NavigateUrl='<%# String.Format("~/ChildItems.aspx?id={0}",DataBinder.Eval(Container.DataItem, "ID").ToString()) %>' Font-Underline="false" runat="server"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateColumn>--%>

                    <asp:BoundColumn HeaderText="Description" DataField="Description" />
                </Columns>
                <HeaderStyle BackColor="teal" ForeColor="white" Font-Bold="true" />
                <ItemStyle BackColor="white" ForeColor="darkblue" />
                <AlternatingItemStyle BackColor="beige" ForeColor="darkblue" />
            </asp:DataGrid>
        </p>
    </body>
    </html>
</asp:Content>
