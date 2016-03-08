using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using A3ClassLibrary;

namespace A3WebApplication
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO: must use the Security Class to login and to check for access level (admin or not)

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Security.Login(txtUserName.Text, txtPassword.Text);

            if (Security.IsCustomerLoggedIn())
            {
                if (Security.IsCustomerAdmin())
                {
                    Response.Redirect("AdminPage.aspx");
                }
                else
                {
                    Response.Redirect("CategoriesPage.aspx");
                }

            }
            else
            {
                lblResult.Text = "Invalid Login Information";
            }
        }
    }
}