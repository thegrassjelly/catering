using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_ViewAccounts : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetAccounts();
        }
    }

    private void GetAccounts()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT AccountID, AccountNo, AccountName,
                                BankName, Branch, Status, DateAdded
                                FROM Accounts WHERE Status = @status";
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Accounts");
            lvAccounts.DataSource = ds;
            lvAccounts.DataBind();
        }
    }

    protected void ddlStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetAccounts();
    }

    protected void lvAccounts_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpAccounts.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetAccounts();
    }

    protected void lvAccounts_OnDataBound(object sender, EventArgs e)
    {
        dpAccounts.Visible = dpAccounts.PageSize < dpAccounts.TotalRowCount;
    }
}