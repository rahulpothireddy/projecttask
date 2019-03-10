using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ToDoList
{
    public partial class EditItem : System.Web.UI.Page
    {
        //protected System.Web.UI.WebControls.LinkButton SaveButton;
        //protected System.Web.UI.WebControls.TextBox DescriptionTextBox;
        //protected System.Web.UI.WebControls.Label ErrorLabel;
        //protected System.Web.UI.WebControls.DropDownList PriorityList;

        protected string _title;
        protected System.Web.UI.WebControls.LinkButton Save;
        protected static string[] _priorities = { "Low", "Medium", "High" };

        private void Page_Load(object sender, System.EventArgs e)
        {
            string idStr = Request.Params["id"];

            _title = (idStr == null ? "New" : "Edit") + " To Do List Item";

            if (!IsPostBack)
            {
                foreach (string s in _priorities)
                    PriorityList.Items.Add(s);

                if (idStr != null)
                {
                    string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
                    string queryStr = "select * from Items where id=" + idStr;
                    SqlConnection dbconn = new SqlConnection(connStr);
                    SqlDataAdapter adapter = new SqlDataAdapter(queryStr, connStr);

                    DataSet ds = new DataSet();

                    adapter.Fill(ds);

                    DataTable tbl = ds.Tables[0];

                    if (tbl.Rows.Count > 0)
                    {
                        DataRow row = tbl.Rows[0];

                        DescriptionTextBox.Text = row["Description"].ToString();
                        PriorityList.SelectedIndex = (int)row["Priority"] - 1;
                        DateTime dt = Convert.ToDateTime(row["EndDate"].ToString());
                        txtLastDate.Text = dt.ToString("dd/MM/yyyy");
                    }
                }

            }
            else
            {
                OnSubmit();
            }
        }

        public void SaveButton_Click(object sender, System.EventArgs e)
        {
            OnSubmit();
        }

        protected void OnSubmit()
        {
            string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
            string sql;
            string idStr = Request.Params["id"];
            string desc = DescriptionTextBox.Text.Replace("'", "''");
            int priority = PriorityList.SelectedIndex + 1;
            string strEndDate = txtLastDate.Text;
            //DateTime strEndDate = DateTime.ParseExact(txtLastDate.Text, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            if (idStr == null)
                sql = "INSERT INTO Items (Description, Priority, EndDate) VALUES ('" + desc + "', " + priority + ",'" + strEndDate + "')";
            else
                sql = "UPDATE Items SET Description = '" + desc + "', Priority=" +
                    priority + "',EndDate='" + strEndDate + "' WHERE ID=" + idStr;

            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.ExecuteNonQuery();
            }
            catch (SqlException e)
            {
                return;
                return;
            }
            finally
            {
                conn.Close();
            }

            Response.Redirect("ToDoList.aspx");
        }
    }
}