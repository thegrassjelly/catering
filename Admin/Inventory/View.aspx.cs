using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Inventory_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetStockTypes();
            GetStocks(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    void GetStockTypes()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT DISTINCT StockTypeName FROM StockType WHERE Status = 'Active'";
            SqlDataReader dr = cmd.ExecuteReader();
            ddlType.DataSource = dr;
            ddlType.DataTextField = "StockTypeName";
            ddlType.DataValueField = "StockTypeName";
            ddlType.DataBind();
            ddlType.Items.Insert(0, "All Stock Types");
        }
    }

    private void GetStocks(string txtSearchText)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (ddlType.SelectedValue == "All Stock Types")
            {
                cmd.CommandText = @"SELECT StockID, StockTypeName, StockName, StockDescription,
                            Qty, Stocks.Status, DateModified
                            FROM Stocks
                            INNER JOIN StockType ON Stocks.StockTypeID = StockType.StockTypeID
                            WHERE (StockID LIKE @keyword OR 
                            StockTypeName LIKE @keyword OR 
                            StockName LIKE @keyword) 
                            AND Stocks.Status = @status ORDER BY Stocks.DateAdded DESC";
            }
            else
            {
                cmd.CommandText = @"SELECT StockID, StockTypeName, StockName, StockDescription,
                            Qty, Stocks.Status, DateModified
                            FROM Stocks
                            INNER JOIN StockType ON Stocks.StockTypeID = StockType.StockTypeID
                            WHERE (StockID LIKE @keyword OR 
                            StockTypeName LIKE @keyword OR 
                            StockName LIKE @keyword) AND StockTypeName = @stocktype
                            AND Stocks.Status = @status ORDER BY Stocks.DateAdded DESC";
            }

            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@stocktype", ddlType.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearchText + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Stocks");
            lvStocks.DataSource = ds;
            lvStocks.DataBind();
        }
    }

    protected void ddlStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetStocks(txtSearch.Text);
    }

    protected void ddlType_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetStocks(txtSearch.Text);
    }

    protected void txtSearch_OnTextChanged(object sender, EventArgs e)
    {
        GetStocks(txtSearch.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        GetStocks(txtSearch.Text);
    }

    protected void lvStocks_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpStocks.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetStocks(txtSearch.Text);
    }

    protected void lvStocks_OnDataBound(object sender, EventArgs e)
    {
        dpStocks.Visible = dpStocks.PageSize < dpStocks.TotalRowCount;
    }
}