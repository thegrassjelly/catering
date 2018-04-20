using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Suppliers_UpdateSupplier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int supplierID = 0;
        bool validSupplier = int.TryParse(Request.QueryString["ID"], out supplierID);

        if (validSupplier)
        {
            if (!IsPostBack)
            {
                GetSupplierDetails(supplierID);
            }
        }
    }

    private void GetSupplierDetails(int supplierId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SupplierName, ContactNo, Address,
                ContactPerson, Status FROM Suppliers WHERE SupplierID = @id";
            cmd.Parameters.AddWithValue("@id", supplierId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtSupplierName.Text = dr["SupplierName"].ToString();
                txtContactNo.Text = dr["ContactNo"].ToString();
                txtAddress.Text = dr["Address"].ToString();
                txtContactPer.Text = dr["ContactPerson"].ToString();
                ddlStatus.SelectedValue = dr["Status"].ToString();
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Suppliers 
                        SET SupplierName = @sn,
                        ContactNo = @cn,
                        Address = @addr,
                        ContactPerson = @cp,
                        Status = @status
                        WHERE SupplierID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@sn", txtSupplierName.Text);
            cmd.Parameters.AddWithValue("@cn", txtContactNo.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddress.Text);
            cmd.Parameters.AddWithValue("@cp", txtContactPer.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("View.aspx");
    }
}