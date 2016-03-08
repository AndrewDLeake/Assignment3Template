<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="A3WebApplication.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <%--    7 MARKS TOTAL
    TODO: 
    - Create a login page with username/password (2 MARKS)
    - redirect to an Admin page if they're an Admin (1 MARK)
    - redirect to CategoriesPage if successful login and not Admin (1 MARK)
    - Provide an error message if incorrect (1 MARK)
    - Ensure proper validation is on the screen (no blank username/password) (2 MARKS)--%>
    <table>
        <tr>
            <td>User Name</td>
            <td>
                <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvUserName" ControlToValidate="txtUserName" EnableClientScript="false" runat="server" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>Password</td>
            <td>
                <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" EnableClientScript="false" runat="server" ErrorMessage="Required Field"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            </td>
            <td>
                <asp:Label ID="lblResult" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>
