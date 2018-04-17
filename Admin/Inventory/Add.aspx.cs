using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Inventory_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetStockTypes();
        }
    }

    private void GetStockTypes()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT StockTypeID, StockTypeName FROM StockType " +
                              "WHERE Status = 'Active'";
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                ddlStockType.DataSource = dr;
                ddlStockType.DataTextField = "StockTypeName";
                ddlStockType.DataValueField = "StockTypeID";
                ddlStockType.DataBind();
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Stocks
                            (StockTypeID, StockName, StockDescription, Qty, Status, DateAdded) 
                            VALUES
                            (@sti, @sname, @sdesc, @qty, @status, @dadded)";
            cmd.Parameters.AddWithValue("@sti", ddlStockType.SelectedValue);
            cmd.Parameters.AddWithValue("@sname", txtStockName.Text);
            cmd.Parameters.AddWithValue("@sdesc", txtStockDesc.Text);
            cmd.Parameters.AddWithValue("@qty", txtQty.Text);
            cmd.Parameters.AddWithValue("@status", "Active");
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Helper.Log("Add Stock",
                "Added new stock: " + txtStockName.Text, txtStockDesc.Text, Session["userid"].ToString());

            Response.Redirect("View.aspx");
        }
    }
}