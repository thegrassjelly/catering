using System;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

public partial class Admin_Booking_SalesReportPrint : System.Web.UI.Page
{
    static string _name;

    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (Request.QueryString["datea"] != null && 
            Request.QueryString["dateb"] != null)
        {
            if (!IsPostBack)
            {
                txtDateA.Text = Request.QueryString["datea"];
                txtDateB.Text = Request.QueryString["dateb"];

                GetName();
                GetSalesReport();
            }
        }
    }

    private void GetSalesReport()
    {
        ReportDocument report = new ReportDocument();
        report.Load(Server.MapPath("~/Admin/Booking/rptSalesReport.rpt"));

        report.DataSourceConnections[0].SetConnection(Helper.server, Helper.database, Helper.username, Helper.password);

        report.SetParameterValue("User", _name);
        report.SetParameterValue("datea", txtDateA.Text);
        report.SetParameterValue("dateb", txtDateB.Text);
        report.SetParameterValue("Logo", "~/Admin/assets/img/adminlogo.jpg");

        crvSalesReport.ReportSource = report;
        crvSalesReport.DataBind();
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

    protected void txtDateA_TextChanged(object sender, EventArgs e)
    {
        GetName();
        GetSalesReport();
    }

    protected void txtDateB_TextChanged(object sender, EventArgs e)
    {
        GetName();
        GetSalesReport();
    }
}