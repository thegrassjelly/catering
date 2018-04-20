using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Payments_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetPayments(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetPayments(string txtSearchText)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (ddlPaymentStatus.SelectedValue == "All Status")
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                                Address, DownPayment, Balance, Total, Status,
                                Payments.DateAdded
                                FROM Payments
                                INNER JOIN Bookings ON Payments.BookingID = Bookings.BookingID
                                INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                WHERE 
                                (ContactFirstName LIKE @keyword OR
                                ContactLastName LIKE @keyword OR
                                Address LIKE @keyword) ORDER BY DateAdded DESC";
            }
            else
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                                Address, DownPayment, Balance, Total, Status,
                                Payments.DateAdded
                                FROM Payments
                                INNER JOIN Bookings ON Payments.BookingID = Bookings.BookingID
                                INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                WHERE 
                                (ContactFirstName LIKE @keyword OR
                                ContactLastName LIKE @keyword OR
                                Address LIKE @keyword) AND 
                                Payments.Status = @status ORDER BY DateAdded DESC";
            }

            cmd.Parameters.AddWithValue("@status", ddlPaymentStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearchText + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Payments");
            lvPayments.DataSource = ds;
            lvPayments.DataBind();
        }
    }

    protected void ddlPaymentStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetPayments(txtSearch.Text);
    }

    protected void txtSearch_OnTextChanged(object sender, EventArgs e)
    {
        GetPayments(txtSearch.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        GetPayments(txtSearch.Text);
    }

    protected void lvPayments_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpPayments.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetPayments(txtSearch.Text);
    }

    protected void lvPayments_OnDataBound(object sender, EventArgs e)
    {
        dpPayments.Visible = dpPayments.PageSize < dpPayments.TotalRowCount;
    }
}