using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class MainMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // NOTE: You will need to use the Security Class to determine if logged in or not
            btnLogout.Visible = Security.IsCustomerLoggedIn();
            hlLogin.Visible = !Security.IsCustomerLoggedIn();
            hlAdmin.Visible = Security.IsCustomerAdmin();

        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Security.LogOut();
            Response.Redirect("Categories.aspx");
        }
    }
}