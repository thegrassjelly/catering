using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Booking_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetBooking(txtSearch.Text);
        }

        this.Form.DefaultButton = this.btnSearch.UniqueID;
    }

    private void GetBooking(string txtSearchText)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (ddlBookingType.SelectedValue == "All Bookings")
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                                    MainTable, Address, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    Address LIKE @keyword) AND 
                                    Status = @status ORDER BY Bookings.DateAdded ASC";
            }
            else
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                                    MainTable, Address, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    Address LIKE @keyword) AND 
                                    Status = @status AND MainTable = @bookingtype
                                    ORDER BY Bookings.DateAdded ASC";
            }

            cmd.Parameters.AddWithValue("@status", ddlPaymentStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@bookingtype", ddlBookingType.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearchText + "%");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Bookings");
            lvBooking.DataSource = ds;
            lvBooking.DataBind();
        }
    }

    protected void ddlBookingType_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void ddlPaymentStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void txtSearch_OnTextChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void btnSearch_OnClick(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void lvBooking_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpBooking.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetBooking(txtSearch.Text);
    }

    protected void lvBooking_OnDataBound(object sender, EventArgs e)
    {
        dpBooking.Visible = dpBooking.PageSize < dpBooking.TotalRowCount;
    }
}