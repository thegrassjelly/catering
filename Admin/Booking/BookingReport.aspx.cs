using System;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

public partial class Admin_Booking_BookingReport : System.Web.UI.Page
{
    static string _name;
    static string _bdid;

    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();
        if (Request.QueryString["ID"] != null)
        {
            int bookingid = 0;
            bool validBooking = int.TryParse(Request.QueryString["ID"], out bookingid);

            if (validBooking)
            {
                GetName();
                GetBookingDetailsID(bookingid);
                GetBookingReport(bookingid);
            }
        }
    }

    private void GetBookingReport(int bookingid)
    {
        ReportDocument report = new ReportDocument();
        report.Load(Server.MapPath("~/Admin/Booking/rptBooking.rpt"));

        report.DataSourceConnections[0].SetConnection(Helper.server, Helper.database, Helper.username, Helper.password);

        report.SetParameterValue("User", _name);
        report.SetParameterValue("BookingID", bookingid);
        report.SetParameterValue("BookingDetailsID", _bdid);
        report.SetParameterValue("Logo", "~/Admin/assets/img/adminlogo.jpg");

        crvBookingReport.ReportSource = report;
        crvBookingReport.DataBind();
    }

    private void GetBookingReport2(int bookingid)
    {
        ReportDocument report = new ReportDocument();
        report.Load(Server.MapPath("~/Admin/Booking/rptBooking2.rpt"));

        report.DataSourceConnections[0].SetConnection(Helper.server, Helper.database, Helper.username, Helper.password);

        report.SetParameterValue("User", _name);
        report.SetParameterValue("BookingID", bookingid);
        report.SetParameterValue("BookingDetailsID", _bdid);
        report.SetParameterValue("Logo", "~/Admin/assets/img/adminlogo.jpg");

        crvBookingReport.ReportSource = report;
        crvBookingReport.DataBind();
    }

    private void GetBookingDetailsID(int bookingid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingDetailsID FROM BookingDetails WHERE BookingID = @id";
            cmd.Parameters.AddWithValue("@id", bookingid);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                while (dr.Read())
                {
                    _bdid = dr["BookingDetailsID"].ToString();
                }
            }
        }
    }

    private void GetName()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT FirstName, LastName FROM Users WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                while (dr.Read())
                {
                    _name = dr["FirstName"] + " " + dr["LastName"];
                }
            }
        }
    }

    protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlReportType.SelectedValue == "Stripped")
        {
            GetBookingReport2(int.Parse(Request.QueryString["ID"]));
        }
        else
        {
            GetBookingReport(int.Parse(Request.QueryString["ID"]));
        }
    }
}