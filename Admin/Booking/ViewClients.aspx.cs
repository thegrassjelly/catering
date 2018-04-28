using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Booking_ViewClients : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetClients(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetClients(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
                cmd.CommandText = @"SELECT ClientID, ContactFirstName, ContactLastName, ContactNo,
                            EmailAddress, DateAdded
                            FROM Clients
                            WHERE (ContactFirstName LIKE @keyword OR 
                            ContactLastName LIKE @keyword) 
                            ORDER BY DateAdded DESC";
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Clients");
            lvUsers.DataSource = ds;
            lvUsers.DataBind();
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetClients(txtSearch.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetClients(txtSearch.Text);
    }

    protected void lvUsers_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpUsers.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetClients(txtSearch.Text);
    }

    protected void lvUsers_OnDataBound(object sender, EventArgs e)
    {
        dpUsers.Visible = dpUsers.PageSize < dpUsers.TotalRowCount;
    }
}