using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ToDoList
{
    public partial class SubItem : System.Web.UI.Page
    {
        protected static string[] _priorities = { "Low", "Medium", "High" };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (string s in _priorities)
                    PriorityList.Items.Add(s);
                string idStr = Request.Params["id"];
                string childid = Request.Params["childid"];
                if (childid != null)
                    Binddata(Convert.ToInt32(childid));


            }
        }
        public void SaveButton_Click(object sender, System.EventArgs e)
        {
            OnSubmit();
        }

        protected void Binddata(int childid)
        {
            string query = "Select * from ChildItems WHERE ID =" + childid;
            string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                conn.Open();

                SqlDataAdapter cmd = new SqlDataAdapter(query, conn);
                DataSet DS = new DataSet();
                cmd.Fill(DS);
                DataTable tbl = DS.Tables[0];

                if (tbl.Rows.Count > 0)
                {
                    DataRow row = tbl.Rows[0];

                    DescriptionTextBox.Text = row["Description"].ToString();
                    PriorityList.SelectedIndex = (int)row["Priority"] - 1;
                }

            }
            catch (SqlException e)
            {
                ErrorLabel.Text = e.Message;
                ErrorLabel.Visible = true;
                return;
            }
            finally
            {
                conn.Close();
            }

        }

        protected void OnSubmit()
        {
            string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
            string sql;
            string idStr = Request.Params["id"];
            string childid = Request.Params["childid"];
            string desc = DescriptionTextBox.Text.Replace("'", "''");
            int priority = PriorityList.SelectedIndex + 1;


            if (childid == null)
                sql = "INSERT INTO ChildItems (ItemID,Description, Priority) VALUES ('" + idStr + "','" + desc + "', " + priority + ")";
            else
                sql = "UPDATE ChildItems SET Description = '" + desc + "', Priority=" + priority + " WHERE ID=" + childid;


            SqlConnection conn = new SqlConnection(connStr);

            try
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.ExecuteNonQuery();
            }
            catch (SqlException e)
            {
                ErrorLabel.Text = e.Message;
                ErrorLabel.Visible = true;
                return;
            }
            finally
            {
                conn.Close();
            }

            Response.Redirect("childitems.aspx?ItemID=" + idStr);
        }
    }
}