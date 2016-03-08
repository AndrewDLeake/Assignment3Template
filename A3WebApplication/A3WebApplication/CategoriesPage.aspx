<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="CategoriesPage.aspx.cs" Inherits="A3WebApplication.CategoriesPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
<%--    TODO: 
    - Show the categories in a DataList (2 MARKS)
    - Make each category a clickable link (2 MARKS) 
        (should redirect to the ProductsPage with a query string of the CategoryID clicked on.
        Example: If you click on Category 2, redirect to ProductsPage.aspx?CategoryID=2)
    - Show each category as an image (1 MARK)--%>
    <asp:DataList ID="dlCategories" DataKeyField="CategoryID" runat="server" OnItemCommand="dlCategories_ItemCommand">
        <ItemTemplate>
            <div>
                <b>Name: </b><%#Eval("Name") %>
                <br />
                <asp:ImageButton ID="CategoryID" runat="server" CommandArgument='<%#Eval("CategoryID") %>' 
                   ImageUrl='<%#"/Images/" + Eval("ImagePath") %>' Height="150px" Width="150px" CommandName="ProductsClick" />
                <br />
            </div>
        </ItemTemplate>
    </asp:DataList>
</asp:Content>
