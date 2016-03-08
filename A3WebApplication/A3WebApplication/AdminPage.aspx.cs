using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DAL_Project;
using System.Configuration;
using A3ClassLibrary;

namespace A3WebApplication
{
    public partial class AdminPage : System.Web.UI.Page
    {
        string conn = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
        string updateID = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadProducts();
            }
        }
        private void LoadProducts()
        {
            DAL d = new DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            gvProducts.DataSource = d.ExecuteProcedure("spGetProductByID");
            gvProducts.DataBind();
        }
        private void DeleteProduct(string ProductID)
        {
            Product p = new Product();
            p.ProductID = Convert.ToInt32(ProductID);
            p.DeleteProduct();
            LoadProducts();
        }
        private void UpdateProduct(string ProductID)
        {
            Product p = new Product();
            p.ProductID = Convert.ToInt32(ProductID);
            p.Name = txtName.Text;
            p.Price = Convert.ToDouble(txtProductPrice.Text);
            p.PrimaryImagePath = fuImage.ToString();
        }
        public void InsertProduct()
        {
            Product p = new Product();
            p.CategoryID = Convert.ToInt32(txtCategoryID.Text);
            p.Name = txtName.Text;
            p.Price = Convert.ToInt32(txtProductPrice.Text);
            p.PrimaryImagePath = fuImage.ToString();
        }
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "del":
                    gvProducts.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
                    string ProductID = gvProducts.SelectedValue.ToString();
                    DeleteProduct(ProductID);
                    LoadProducts();
                    break;
                case "upd":
                    gvProducts.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
                    updateID = gvProducts.SelectedValue.ToString();
                    pnlEditProducts.Visible = true;
                    txtProductID.Text = updateID;
                    btnSave.Visible = false;
                    btnUpdate.Visible = true;

                    break;
                default:
                    break;
            }
        }
        private string uploadImage()
        {
            string fileName = fuImage.FileName;
            if (fileName != "")
            {
                string serverPath = Server.MapPath(".") + "\\Images\\";
                string pathAndFile = serverPath + fileName;
                fuImage.PostedFile.SaveAs(pathAndFile);
            }

            return fileName;
        }

        protected void btnInsert_Click(object sender, EventArgs e)
        {
            pnlEditProducts.Visible = true;
            btnSave.Visible = true;
            btnUpdate.Visible = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            InsertProduct();
            LoadProducts();
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            UpdateProduct(updateID);
            LoadProducts();
        }
    }
}