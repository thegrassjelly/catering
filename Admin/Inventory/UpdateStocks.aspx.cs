using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Inventory_UpdateStocks : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int stockid = 0;
        bool validStock = int.TryParse(Request.QueryString["ID"], out stockid);

        if (validStock)
        {
            if (!IsPostBack)
            {
                GetStockTypes();
                GetStockDetail(stockid);
            }
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

    private void GetStockDetail(int stockid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT StockID, StockTypeName,
                StockName, StockDescription, Qty, 
                Stocks.Status FROM Stocks 
                INNER JOIN StockType ON Stocks.StockTypeID = StockType.StockTypeID
                WHERE StockID = @id";
            cmd.Parameters.AddWithValue("@id", stockid);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtID.Text = dr["StockID"].ToString();
                        ddlStockType.SelectedItem.Text = dr["StockTypeName"].ToString();
                        txtStockName.Text = dr["StockName"].ToString();
                        txtStockDesc.Text = dr["StockDescription"].ToString();
                        txtQty.Text = dr["Qty"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();
                    }
                }
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Stocks SET StockTypeID = @stid,
                        StockName = @sname, StockDescription = @sd,
                        Status = @status, DateModified = @dmod
                        WHERE StockID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@stid", ddlStockType.SelectedValue);
            cmd.Parameters.AddWithValue("@sname", txtStockName.Text);
            cmd.Parameters.AddWithValue("@sd", txtStockDesc.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("View.aspx");
    }
}