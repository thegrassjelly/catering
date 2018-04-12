using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Inventory_ViewType : System.Web.UI.Page
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
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT StockTypeID, StockTypeName, Status, DateAdded
                                FROM StockType WHERE Status = @status";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "StockType");
            lvStockTypes.DataSource = ds;
            lvStockTypes.DataBind();
        }
    }

    protected void ddlStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetStockTypes();
    }

    protected void lvStockTypes_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpStockType.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetStockTypes();
    }

    protected void lvStockTypes_OnDataBound(object sender, EventArgs e)
    {
        dpStockType.Visible = dpStockType.PageSize < dpStockType.TotalRowCount;
    }
}