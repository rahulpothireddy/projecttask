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
    public partial class ChildItems : System.Web.UI.Page
    {

        protected string _title;
        protected string[] _priorityUrls = { "down.png", "nothing.png", "up.png" };
        protected int itemid = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            int query = 2;

            string queryStr1 = Request.Params["ItemID"];
            string ItemID = queryStr1;
            if (queryStr1 != null)
                query = Int32.Parse(queryStr1);
            if (ItemID != null)
                itemid = Int32.Parse(ItemID);

            // Save state for use in post back	
            ViewState["query"] = query;

            if (IsPostBack)
            {
                query = (int)ViewState["query"];
            }
            else
            {

            }
            asub.HRef = "SubItem.aspx?id=" + itemid;
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
                    sql = "select * from ChildItems where ItemID = " + itemid + "  order by priority desc";

                    bcOpened = new BoundColumn();
                    bcOpened.HeaderText = "Opened";
                    bcOpened.DataField = "Opened";
                    ToDoDataGrid.Columns.Add(bcOpened);
                    break;

                case 1:
                    qryTitle = "All Closed Items";
                    sql = "SELECT * FROM ChildItems where ItemID = " + itemid + " AND Closed Is Not Null order by priority desc";

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
                    sql = "SELECT * FROM ChildItems WHERE ItemID = " + itemid + " AND  Closed Is Null order by priority desc";

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
            if (itemid != null)
            {
                string queryStr = "select * from Items where id=" + itemid;
                SqlDataAdapter adapter1 = new SqlDataAdapter(queryStr, connStr);

                DataSet ds1 = new DataSet();

                adapter1.Fill(ds1);

                DataTable tbl = ds1.Tables[0];

                if (tbl.Rows.Count > 0)
                {
                    DataRow row = tbl.Rows[0];

                    lblDescription.Text = row["Description"].ToString();
                }
            }
        }

        public void ToDoDataGrid_Command(Object sender, DataGridCommandEventArgs e)
        {
            TableCell idCell = e.Item.Cells[0];
            string idStr = idCell.Text;
            string cmdStr = ((LinkButton)e.CommandSource).CommandName;

            if (cmdStr == "EditToDo")
            {
                Response.Redirect("Subitem.aspx?id=" + itemid + "&childid=" + idStr);
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
                            sql = "DELETE FROM ChildItems WHERE ID=" + idStr;
                            conn.Open();

                            SqlCommand cmd = new SqlCommand(sql, conn);
                            cmd.CommandTimeout = 90;

                            cmd.ExecuteNonQuery();
                            break;
                        }

                    case "ReopenToDo":
                        {
                            sql = "UPDATE ChildItems SET Closed = Null WHERE ID=" + idStr;
                            conn.Open();

                            SqlCommand cmd = new SqlCommand(sql, conn);
                            cmd.CommandTimeout = 90;

                            cmd.ExecuteNonQuery();
                            break;
                        }

                    default:
                        {
                            sql = "EXEC SP_UPSERT_ITEMS_CHILEDITEMS @CHILDID =" + idStr;
                            SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                            da.SelectCommand.CommandTimeout = 90; // Will allow the Data set to be filled in 90 Secs
                            DataSet ds = new DataSet();
                            da.Fill(ds, "Table");
                            break;
                        }
                }




            }
            finally
            {
                conn.Close();
            }

            // Cause the page to be refreshed
            Response.Redirect(Request.FilePath + "?query=" + ViewState["query"].ToString());
        }
    }
}