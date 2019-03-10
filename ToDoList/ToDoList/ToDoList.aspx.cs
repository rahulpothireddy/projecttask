using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ToDoList
{
    public partial class ToDoList : System.Web.UI.Page
    {

        protected string _title;
        protected string[] _priorityUrls = { "down.png", "nothing.png", "up.png" };

        private void Page_Load(object sender, System.EventArgs e)
        {
            int query = 2;

            if (IsPostBack)
            {
                query = (int)ViewState["query"];
            }
            else
            {
                string queryStr = Request.Params["query"];

                if (queryStr != null)
                    query = Int32.Parse(queryStr);

                // Save state for use in post back	
                ViewState["query"] = query;
            }

            string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
            string sql;
            string qryTitle;

            ButtonColumn bcDone;
            ButtonColumn bcEdit;
            ButtonColumn bcDelete;
            ButtonColumn bcReopen;
            BoundColumn bcOpened;
            BoundColumn bcClosed;

            switch (query)
            {
                case 0:
                    qryTitle = "All Items";
                    sql = "select ID, Description, Opened, Closed, Priority,FORMAT(EndDate,'dd/MM/yyyy') as EndDate from items order by priority desc";

                    bcOpened = new BoundColumn();
                    bcOpened.HeaderText = "Opened";
                    bcOpened.DataField = "Opened";
                    ToDoDataGrid.Columns.Add(bcOpened);
                    break;

                case 1:
                    qryTitle = "All Closed Items";
                    sql = "select ID, Description, Opened, Closed, Priority,FORMAT(EndDate,'dd/MM/yyyy') as EndDate from items WHERE Closed Is Not Null order by priority desc";

                    bcClosed = new BoundColumn();
                    bcClosed.HeaderText = "Closed";
                    bcClosed.DataField = "Closed";
                    ToDoDataGrid.Columns.Add(bcClosed);

                    bcReopen = new ButtonColumn();
                    bcReopen.Text = "Reopen";
                    bcReopen.CommandName = "ReopenToDo";
                    ToDoDataGrid.Columns.Add(bcReopen);

                    bcDelete = new ButtonColumn();
                    bcDelete.Text = "Delete";
                    bcDelete.CommandName = "DeleteToDo";
                    ToDoDataGrid.Columns.Add(bcDelete);
                    break;

                default:
                case 2:
                    qryTitle = "All Open Items";
                    sql = "select ID, Description, Opened, Closed, Priority,FORMAT(EndDate,'dd/MM/yyyy') as EndDate from items WHERE Closed Is Null order by priority desc";

                    bcDone = new ButtonColumn();
                    bcDone.Text = "Done";
                    bcDone.CommandName = "DoneToDo";
                    ToDoDataGrid.Columns.Add(bcDone);

                    bcEdit = new ButtonColumn();
                    bcEdit.Text = "Edit";
                    bcEdit.CommandName = "EditToDo";
                    ToDoDataGrid.Columns.Add(bcEdit);

                    bcDelete = new ButtonColumn();
                    bcDelete.Text = "Delete";
                    bcDelete.CommandName = "DeleteToDo";
                    ToDoDataGrid.Columns.Add(bcDelete);
                    break;
            }

            _title = "To Do List - " + qryTitle;

            SqlConnection dbconn = new SqlConnection(connStr);


            dbconn.Open();
            //SqlCommand cmd = new SqlCommand(Sql, dbconn);
            SqlDataAdapter adapter = new SqlDataAdapter(sql, connStr);

            DataSet ds = new DataSet();

            adapter.Fill(ds);
            ToDoDataGrid.DataSource = ds;
            ToDoDataGrid.DataBind();
        }

        public void ToDoDataGrid_Command(Object sender, DataGridCommandEventArgs e)
        {
            TableCell idCell = e.Item.Cells[0];
            string idStr = idCell.Text;
            string cmdStr = ((LinkButton)e.CommandSource).CommandName;
            TableCell EndDateCell = e.Item.Cells[3];
            string strEndDate = EndDateCell.Text;
            DateTime dt = Convert.ToDateTime(DateTime.Now.ToString());
            string currentDate = dt.ToString("dd/MM/yyyy");
            //EndDateCell.BackColor

            if (cmdStr == "EditToDo")
            {
                Response.Redirect("EditItem.aspx?id=" + idStr);
            }

            string connStr = ConfigurationSettings.AppSettings["ConnectionString"];
            string sql;
            SqlConnection conn = new SqlConnection(connStr);


            try
            {


                switch (cmdStr)
                {
                    case "DeleteToDo":
                        {
                            sql = "DELETE FROM Items WHERE ID=" + idStr;
                            conn.Open();

                            SqlCommand cmd = new SqlCommand(sql, conn);

                            cmd.ExecuteNonQuery();
                            break;
                        }

                    case "ReopenToDo":
                        {
                            sql = "UPDATE Items SET Closed = Null WHERE ID=" + idStr;
                            conn.Open();

                            SqlCommand cmd = new SqlCommand(sql, conn);

                            cmd.ExecuteNonQuery();
                            break;
                        }

                    default:
                        {
                            sql = "EXEC SP_UPSERT_ITEMS_CHILEDITEMS @ITEMID =" + idStr;
                            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                            da.SelectCommand.CommandTimeout = 90; // Will allow the Data set to be filled in 90 Secs
                            DataSet ds = new DataSet();
                            da.Fill(ds, "Table");
                            break;
                        }
                }
            }
            catch (Exception)
            {

                throw;
            }

            // Cause the page to be refreshed
            // Response.Redirect(Request.FilePath + "?query=" + ViewState["query"].ToString());
        }

        protected void ToDoDataGrid_ItemDataBound(object sender, DataGridItemEventArgs e)
        {
            TableCell idCell = e.Item.Cells[3];
            string idStr = idCell.Text;
            DateTime dateTime;
            if (DateTime.TryParseExact(idStr, "dd/MM/yyyy", System.Globalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.NoCurrentDateDefault, out dateTime))
            {
                string date = Convert.ToDateTime(idStr).ToString("dd/MM/yyyy");
                string currentDate = DateTime.Now.ToString("dd/MM/yyyy");
                DateTime celDate = Convert.ToDateTime(date);
                DateTime cDate = Convert.ToDateTime(currentDate);
                if (celDate > cDate)
                {
                    e.Item.Cells[3].BackColor = Color.Red;
                    e.Item.Cells[3].ForeColor = Color.White;
                }
            }
            else
                Console.WriteLine("Invalid");


            //if (e.Item.Cells[0] == DataControlRowType.DataRow)
            //{
            //    //If Salary is less than 10000 than set the row Background Color to Cyan  
            //    if (Convert.ToInt32(e.Row.Cells[3].Text) < 10000)
            //    {
            //        e.Row.BackColor = Color.Cyan;
            //    }
            //}

        }
    }
}