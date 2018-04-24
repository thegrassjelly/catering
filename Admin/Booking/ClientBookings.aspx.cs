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
    }

    [WebMethod]
    public static List<string> GetName(string prefixText)
    {
        List<string> name = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["myCon"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName, ClientID FROM Clients WHERE 
                    ContactFirstName LIKE @SearchText OR
                    ContactLastName LIKE @SearchText
                    ORDER BY ContactLastName ASC";
                cmd.Parameters.AddWithValue("@SearchText", "%" + prefixText + "%");
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string myString = dr["ContactLastName"] + ", " + dr["ContactFirstName"] + "/vn/" + dr["ClientID"];
                        name.Add(myString);
                    }
                }

                conn.Close();
            }

        }
        return name;
    }

    protected void btnUser_Click(object sender, EventArgs e)
    {
        if (hfName.Value != "0")
        {
            using (var con = new SqlConnection(Helper.GetCon()))
            using (var cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = @"SELECT ClientID, ContactFirstName, ContactLastName, 
                EmailAddress, ContactNo, Address
                FROM Clients WHERE ClientID = @id";
                cmd.Parameters.AddWithValue("@id", hfName.Value);
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.HasRows)
                    {
                        if (dr.Read())
                        {
                            txtFN.Text = dr["ContactFirstName"].ToString();
                            txtLN.Text = dr["ContactLastName"].ToString();
                            txtEmail.Text = dr["EmailAddress"].ToString();
                            txtAddr.Text = dr["Address"].ToString();
                            txtMNo.Text = dr["ContactNo"].ToString();
                        }
                    }
                }
            }
        }

        GetBooking(txtSearch.Text);
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
                                    Address LIKE @keyword) AND Clients.ClientID = @id ORDER BY Bookings.DateAdded DESC";
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
                                    Address LIKE @keyword) AND Clients.ClientID = @id AND
                                    Status = @status ORDER BY Bookings.DateAdded DESC";
                }

            }
            else
            {
                if (ddlPaymentStatus.SelectedValue == "All Status")
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
                                    Address LIKE @keyword) AND MainTable = @bookingtype AND Clients.ClientID = @id
                                    ORDER BY Bookings.DateAdded DESC";
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
                                    Address LIKE @keyword) AND Clients.ClientID = @id AND
                                    Status = @status AND MainTable = @bookingtype
                                    ORDER BY Bookings.DateAdded DESC";
                }
            }

            cmd.Parameters.AddWithValue("@status", ddlPaymentStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@bookingtype", ddlBookingType.SelectedValue);
            cmd.Parameters.AddWithValue("@keyword", "%" + text + "%");
            cmd.Parameters.AddWithValue("@id", hfName.Value);
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
}