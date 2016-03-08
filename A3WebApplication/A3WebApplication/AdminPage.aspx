<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="AdminPage.aspx.cs" Inherits="A3WebApplication.AdminPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <asp:Panel ID="pnlProductsView" runat="server">
        <asp:GridView ID="gvProducts" DataKeyNames="ProductID" runat="server" OnRowCommand="gvProducts_RowCommand">
            <Columns>
                <asp:ButtonField CommandName="del" Text="Delete" />
                <asp:ButtonField CommandName="upd" Text="Update" />
            </Columns>
        </asp:GridView>
        <asp:Button ID="btnInsert" runat="server" Text="Insert" OnClick="btnInsert_Click" />
        <br />
        <asp:Label ID="lblForeignKeyException" runat="server" Text=""></asp:Label>
    </asp:Panel>
    <asp:Panel ID="pnlEditProducts" Visible="false" runat="server">
        <table>
            <tr>
                <td>Product ID</td>
                <td>
                    <asp:TextBox ID="txtProductID" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Product Name</td>
                <td>
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Product Price</td>
                <td>
                    <asp:TextBox ID="txtProductPrice" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Category ID</td>
                <td>
                    <asp:TextBox ID="txtCategoryID" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Image</td>
                <td>
                    <asp:FileUpload ID="fuImage" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnSave" runat="server" Text="Save" Width="62px" OnClick="btnSave_Click" />
                </td>
                <td>
                    <asp:Button ID="btnUpdate" runat="server" Text="Update" Width="62px" OnClick="btnUpdate_Click" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <%--    17 MARKS TOTAL
    1 BONUS MARK TOTAL
    TODO:  Impliment CRUD operations for Product as an admin.
    - 2 MARKS: Display all products with all column information--%>
    <%--    - 1 MARK: Hide the ProductID column
    - 2 MARKS: Allow edit
    - 2 MARKS: Allow delete (BONUS 1 MARK: provided error message for FOREGIN KEY CONSTRAINT ISSUES)
    - 2 MARKS: Allow insert
    - 2 MARKS: Provide Validation for input when inserting
    - 1 MARK: Ensure Image Upload works for insert
    - 1 MARK: Ensure Image Upload works for update (default to old image value if no new image is provided)
    - 2 MARKS: Manual Sorting by one or more columns (you do not need to do all columns)
    - 2 MARKS: Manual Paging--%>
</asp:Content>
