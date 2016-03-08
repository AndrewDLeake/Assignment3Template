using A3ClassLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A3WebApplication
{
    public partial class ProductsPage : System.Web.UI.Page
    {
        // 5 MARKS TOTAL
        // 1 BONUS MARK TOTAL
        protected void Page_Load(object sender, EventArgs e)
        {
            /* TODO:
                - 3 MARKS: grab CategoryID from QueryString and Populate the products based on the CategoryID
            */
            dlProducts.DataSource = Product.GetProductsByCategoryID(ToNullableInt32(Request.QueryString["CategoryID"]));
            dlProducts.DataBind();
        }

        public int? ToNullableInt32(string s)
        {
            int i;
            if (Int32.TryParse(s, out i)) return i;
            return null;
        }

        protected void dlProducts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            /* TODO: 
                - 1 MARK:  get the right ProductID based on which product was clicked
                - BONUS 1 MARK:  get the quantity from the drop down if you made one
                - 1 MARK: Use the SessionCart's Instance to add a new Cart Item to the ShoppingCart and redirect to the CartPage
            */
        }
    }
}