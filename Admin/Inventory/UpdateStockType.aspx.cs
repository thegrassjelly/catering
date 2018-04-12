using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Inventory_UpdateStockType : System.Web.UI.Page
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
                GetStockDetails(stockid);
            }
        }
    }

    private void GetStockDetails(int stockid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT StockTypeID, StockTypeName,
                Status FROM StockType WHERE StockTypeID = @id";
            cmd.Parameters.AddWithValue("@id", stockid);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtID.Text = dr["StockTypeID"].ToString();
                        txtStockType.Text = dr["StockTypeName"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();
                    }
                }
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("ViewType.aspx");
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE StockType SET StockTypeName = @st,
                        Status = @status WHERE StockTypeID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@st", txtStockType.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("ViewType.aspx");
    }
}