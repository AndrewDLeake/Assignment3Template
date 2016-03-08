using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A3ClassLibrary
{
    // 6 MARKS TOTAL
    public class Product
    {
        public int ProductID { get; set; }
        public int CategoryID { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string PrimaryImagePath { get; set; }

        /// <summary>
        /// Returns a List populated with Product objects based on a categoryID. 
        /// Note that if null is passed, ALL products are returned
        /// </summary>
        public static List<Product> GetProductsByCategoryID(int? categoryID)
        {
            List<Product> listResult = new List<Product>();

            DAL_Project.DAL d = new DAL_Project.DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);

            if (categoryID != null)
            {
                d.AddParam("CategoryID", categoryID);
            }

            DataSet ds = d.ExecuteProcedure("spGetProductsByCategoryID");

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                listResult.Add(GetProductFromDataRow(row));
            }

            return listResult;
        }
        
        public static Product GetProductByID(int productID)
        {
            Product result = null;
            DAL_Project.DAL d = new DAL_Project.DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            d.AddParam("ProductID", productID);
            DataRow row = d.ExecuteProcedure("spGetProductByID").Tables[0].Rows[0];
            result = GetProductFromDataRow(row);
            return result;
        }
        
        private static Product GetProductFromDataRow(DataRow row)
        {
            Product p = new Product();
            p.ProductID = int.Parse(row["ProductID"].ToString());
            p.CategoryID = int.Parse(row["CategoryID"].ToString());
            p.Name = row["Name"].ToString();
            p.Price = double.Parse(row["Price"].ToString());
            p.PrimaryImagePath = row["PrimaryImagePath"].ToString();
            return p;
        }
        
        // TODO 
        // 2 MARKS: write a method which impliments spInsertProduct
        public void InsertProduct()
        {
            DAL_Project.DAL d = new DAL_Project.DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            d.AddParam("Name", this.Name);
            d.AddParam("Price", this.Price);
            d.AddParam("CategoryID", this.CategoryID);
            d.AddParam("ImagePath", this.PrimaryImagePath);
            d.ExecuteProcedure("spInsertProduct");
        }
        // 2 MARKS: write a method which impliments spDeleteProduct
        public void DeleteProduct()
        {

                DAL_Project.DAL d = new DAL_Project.DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
                d.AddParam("ProductID", this.ProductID);
                d.ExecuteProcedure("spDeleteProduct");

        }
        // 2 MARKS: write a method which impliments spUpdateProduct
        public void UpdateProduct()
        {
            DAL_Project.DAL d = new DAL_Project.DAL(ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString);
            d.AddParam("ProductID", this.ProductID);
            d.AddParam("Name", this.Name);
            d.AddParam("Price", this.Price);
            d.AddParam("CategoryID", this.CategoryID);
            d.AddParam("ImagePath", this.PrimaryImagePath);
            d.ExecuteProcedure("spUpdateProduct");
        }
    }
}
