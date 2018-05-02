using CrystalDecisions.CrystalReports.Engine;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_SupplierReports : System.Web.UI.Page
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
                GetSupplierReport();
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

    private void GetSupplierReport()
    {
        ReportDocument report = new ReportDocument();
        report.Load(Server.MapPath("~/Admin/Cheques/rptSupplierReports.rpt"));

        report.DataSourceConnections[0].SetConnection(Helper.server, Helper.database, Helper.username, Helper.password);

        report.SetParameterValue("User", _name);
        report.SetParameterValue("datea", txtDateA.Text);
        report.SetParameterValue("dateb", txtDateB.Text);
        report.SetParameterValue("Logo", "~/Admin/assets/img/adminlogo.jpg");

        crvSupplierReports.ReportSource = report;
        crvSupplierReports.DataBind();
    }

    protected void txtDateA_TextChanged(object sender, EventArgs e)
    {
        GetName();
        GetSupplierReport();
    }

    protected void txtDateB_TextChanged(object sender, EventArgs e)
    {
        GetName();
        GetSupplierReport();
    }
}