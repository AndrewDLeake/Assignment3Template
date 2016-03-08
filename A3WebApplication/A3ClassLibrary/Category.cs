using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace A3ClassLibrary
{
    public class Category
    {
        public int CategoryID { get; set; }
        public string Name { get; set; }
        public string ImagePath { get; set; }

        // TODO (2 MARKS)
        // Create a method for creating a new Category based on a CategoryID passed
        // Example: CategoryID 3 is passed, 3 is used as an SQL Param to retrieve a matching row in the database with CategoryID 3
        // populate a new Category instance with the values returned from the database
        public void CreateCategory()
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("CategoryID", CategoryID);
        }
        public static void GetCategory(int CategoryID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            d.AddParam("CategoryID", CategoryID);
            DataSet ds = d.ExecuteProcedure("spGetCategories");
        }
        // BONUS 1 MARK: write method which impliments spInsertCategory
        // BONUS 1 MARK: write method which impliments spDeleteCategory
        // BONUS 1 MARK: write method which impliments spUpdateCategory

        public static List<Category> GetAllCategories()
        {
            List<Category> resultList = new List<Category>();

            string connStr = ConfigurationManager.ConnectionStrings["dbA3ConnStr"].ConnectionString;
            DAL_Project.DAL d = new DAL_Project.DAL(connStr);
            DataSet ds = d.ExecuteProcedure("spGetCategories");

            foreach (DataRow category in ds.Tables[0].Rows)
            {
                Category newCategory = new Category()
                {
                    CategoryID = int.Parse(category["CategoryID"].ToString()),
                    Name = category["Name"].ToString(),
                    ImagePath = category["ImagePath"].ToString()
                };

                resultList.Add(newCategory);
            }
            return resultList;
        }
    }
}
