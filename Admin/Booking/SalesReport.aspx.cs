using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Booking_SalesReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            Dates();
            GetSalesReport();
        }
    }

    private void Dates()
    {
        DateTime dn = Helper.PHTime();
        var startDate = new DateTime(dn.Year, dn.Month, 1);
        var endDate = startDate.AddMonths(1).AddDays(-1);

        txtDateA.Text = startDate.ToString("yyyy-MM-dd");
        txtDateB.Text = endDate.ToString("yyyy-MM-dd");
    }

    private void GetSalesReport()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                                    MainTable, EventAddress, EventDateTime, Status, Total,
                                    Bookings.DateAdded, Bookings.BookingID
                                    FROM Bookings
                                    INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                                    INNER JOIN BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                    INNER JOIN Payments ON Bookings.BookingID = Payments.BookingID
                                    WHERE Bookings.DateAdded BETWEEN @datea AND @dateb AND Status = 'Paid'
                                    ORDER BY Bookings.DateAdded ASC";
            cmd.Parameters.AddWithValue("@datea", txtDateA.Text);
            cmd.Parameters.AddWithValue("@dateb", txtDateB.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Bookings");
            lvSales.DataSource = ds;
            lvSales.DataBind();
        }

        GetTotal();
    }

    private void GetTotal()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SUM(Total) AS Total FROM Payments
                                INNER JOIN Bookings ON Payments.BookingID = Bookings.BookingID
                                WHERE Bookings.DateAdded Between @datea AND @dateb AND Status = 'Paid'";
            cmd.Parameters.AddWithValue("@datea", txtDateA.Text);
            cmd.Parameters.AddWithValue("@dateb", txtDateB.Text);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                if (dr["Total"].ToString() != "")
                {
                    txtTotalSales.Text = Convert.ToDecimal(dr["Total"]).ToString("#,###.00");
                }
                else
                {
                    txtTotalSales.Text = "0.00";
                }
            }
        }
    }

    protected void txtDateA_TextChanged(object sender, EventArgs e)
    {
        GetSalesReport();
    }

    protected void txtDateB_TextChanged(object sender, EventArgs e)
    {
        GetSalesReport();
    }

    protected void lvSales_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpSales.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetSalesReport();
    }

    protected void lvSales_DataBound(object sender, EventArgs e)
    {
        dpSales.Visible = dpSales.PageSize < dpSales.TotalRowCount;
    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("SalesReportPrint.aspx?datea=" + txtDateA.Text + "&&" + "dateb=" + txtDateB.Text);
    }
}