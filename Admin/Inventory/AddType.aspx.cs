using System;
using System.Data.SqlClient;

public partial class Admin_Inventory_AddType : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO StockType
                            (StockTypeName, Status, DateAdded) VALUES
                            (@stype, @status, @dadded)";
            cmd.Parameters.AddWithValue("@stype", txtStockType.Text);
            cmd.Parameters.AddWithValue("@status", "Active");
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Helper.Log("Add Stock Type",
                "Added new stock type " + txtStockType.Text, "", Session["userid"].ToString());

            Response.Redirect("ViewType.aspx");
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("ViewType.aspx");
    }
}