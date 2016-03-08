using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using A3ClassLibrary;
using DAL_Project;
using System.Configuration;

namespace A3WebApplication
{
    public partial class CategoriesPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }
        public void LoadCategories()
        {
            DAL d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            dlCategories.DataSource = d.ExecuteProcedure("spGetCategoryByID");
            dlCategories.DataBind();

        }
        
        protected void dlCategories_ItemCommand(object source, DataListCommandEventArgs e)
        {
            string catID = e.CommandArgument.ToString();
            Response.Redirect("ProductsPage.aspx?CategoryID=" + catID);
        }
    }
}