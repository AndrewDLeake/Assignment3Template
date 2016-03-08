<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="CartPage.aspx.cs" Inherits="A3WebApplication.CartPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <%--17 MARKS TOTAL
    1 BONUS MARK TOTAL
    TODO:
    - 2 MARKS: Show a GridView of the ShoppingCart CartItems.
    - BONUS 1 MARK: Show images on each row
    - 5 MARKS: Add functionality to Update the quantity of an item or all items in cart
    - 5 MARKS: Add functionality to Remove an item from the cart
    - 3 MARKS: Add Functionality to remove ALL items from the cart at once
    - 2 MARKS: Add functionality to check out (no need for payment page, assume they already have put in proper payment, just save to database that the order is complete!)--%>
    <asp:GridView ID="gvShoppingCart" OnRowCommand="gvShoppingCart_RowCommand" runat="server">
        <Columns>
            <asp:ButtonField CommandName="remove" Text="Remove" />
        </Columns>
    </asp:GridView>
    <asp:Button ID="btnRemoveAll" runat="server" Text="Remove All" />
    <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" />
</asp:Content>
