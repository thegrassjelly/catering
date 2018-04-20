using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Suppliers_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetSuppliers(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetSuppliers(string txtSearchText)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SupplierID, SupplierName, ContactNo, Address,
                            Status, ContactPerson, DateAdded
                            FROM Suppliers
                            WHERE (SupplierID LIKE @keyword OR 
                            SupplierName LIKE @keyword OR 
                            Address LIKE @keyword OR
                            ContactPerson LIKE @keyword)
                            AND Status = @status ORDER BY DateAdded DESC";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearchText + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Suppliers");
            lvSuppliers.DataSource = ds;
            lvSuppliers.DataBind();
        }
    }

    protected void ddlStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetSuppliers(txtSearch.Text);
    }

    protected void txtSearch_OnTextChanged(object sender, EventArgs e)
    {
        GetSuppliers(txtSearch.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        GetSuppliers(txtSearch.Text);
    }

    protected void lvSuppliers_OnDataBound(object sender, EventArgs e)
    {
        dpSuppliers.Visible = dpSuppliers.PageSize < dpSuppliers.TotalRowCount;
    }

    protected void lvSuppliers_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpSuppliers.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetSuppliers(txtSearch.Text);
    }
}