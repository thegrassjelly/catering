using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Booking_ClientBookings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int clientid = 0;
        bool validClient = int.TryParse(Request.QueryString["ID"], out clientid);

        if (validClient)
        {
            if (!IsPostBack)
            {
                GetClientDetails(clientid);
                GetBooking(txtSearch.Text);
            }
        }
    }

    private void GetClientDetails(int clientid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ClientID, ContactFirstName, ContactLastName, 
                EmailAddress, ContactNo
                FROM Clients WHERE ClientID = @id";
            cmd.Parameters.AddWithValue("@id", clientid);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtFN.Text = dr["ContactFirstName"].ToString();
                        txtLN.Text = dr["ContactLastName"].ToString();
                        txtEmail.Text = dr["EmailAddress"].ToString();
                        txtContactNo.Text = dr["ContactNo"].ToString();
                    }
                }
            }
        }
    }

    private void GetBooking(string text)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            if (ddlBookingType.SelectedValue == "All Bookings")
            {
                if (ddlPaymentStatus.SelectedValue == "All Status")
                {
                    cmd.CommandText = @"SELECT AccountExec, ContactFirstName, ContactLastName,
                                    MainTable, EventAddress, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    EventAddress LIKE @keyword) AND Clients.ClientID = @id ORDER BY Bookings.DateAdded DESC";
                }
                else
                {
                    cmd.CommandText = @"SELECT AccountExec, ContactFirstName, ContactLastName,
                                    MainTable, EventAddress, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    EventAddress LIKE @keyword) AND Clients.ClientID = @id AND
                                    Status = @status ORDER BY Bookings.DateAdded DESC";
                }

            }
            else
            {
                if (ddlPaymentStatus.SelectedValue == "All Status")
                {
                    cmd.CommandText = @"SELECT AccountExec, ContactFirstName, ContactLastName,
                                    MainTable, EventAddress, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    EventAddress LIKE @keyword) AND MainTable = @bookingtype AND Clients.ClientID = @id
                                    ORDER BY Bookings.DateAdded DESC";
                }
                else
                {
                    cmd.CommandText = @"SELECT AccountExec, ContactFirstName, ContactLastName,
                                    MainTable, EventAddress, EventDateTime, Status,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE
                                    (ContactFirstName LIKE @keyword OR
                                    ContactLastName LIKE @keyword OR
                                    EventAddress LIKE @keyword) AND Clients.ClientID = @id AND
                                    Status = @status AND MainTable = @bookingtype
                                    ORDER BY Bookings.DateAdded DESC";
                }
            }

            cmd.Parameters.AddWithValue("@status", ddlPaymentStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@bookingtype", ddlBookingType.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Bookings");
            lvBooking.DataSource = ds;
            lvBooking.DataBind();
        }

    }

    protected void lvBooking_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpBooking.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetBooking(txtSearch.Text);
    }

    protected void lvBooking_DataBound(object sender, EventArgs e)
    {
        dpBooking.Visible = dpBooking.PageSize < dpBooking.TotalRowCount;
    }

    protected void ddlBookingType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void ddlPaymentStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetBooking(txtSearch.Text);
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("ViewClients.aspx");
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Clients SET ContactFirstName = @fn,
                        ContactLastName = @ln,
                        ContactNo = @contact, EmailAddress = @email
                        WHERE ClientID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@contact", txtContactNo.Text);
            cmd.Parameters.AddWithValue("@email", txtEmail.Text);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("ViewClients.aspx");
    }
}