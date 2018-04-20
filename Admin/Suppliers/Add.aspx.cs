using System;
using System.Data.SqlClient;

public partial class Admin_Suppliers_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        this.Form.DefaultButton = this.btnSubmit.UniqueID;
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Suppliers
                            (SupplierName, ContactNo, Address, ContactPerson, Status, DateAdded) 
                            VALUES
                            (@sn, @cn, @addr, @cp, @status, @dadded)";
            cmd.Parameters.AddWithValue("@sn", txtSupplierName.Text);
            cmd.Parameters.AddWithValue("@cn", txtContactNo.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddress.Text);
            cmd.Parameters.AddWithValue("@cp", txtContactPer.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Helper.Log("Add Supplier",
                "Added supplier: " + txtSupplierName.Text, "", Session["userid"].ToString());

            Response.Redirect("View.aspx");
        }
    }
}