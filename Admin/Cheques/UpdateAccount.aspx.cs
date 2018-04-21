using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_UpdateAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int accountID = 0;
        bool validAccount = int.TryParse(Request.QueryString["ID"], out accountID);

        if (validAccount)
        {
            if (!IsPostBack)
            {
                GetAccountDetails(accountID);
            }
        }
    }

    private void GetAccountDetails(int accountId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT AccountNo,
                AccountName, BankName, Branch,
                Status FROM Accounts WHERE AccountID = @id";
            cmd.Parameters.AddWithValue("@id", accountId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtAccNo.Text = dr["AccountNo"].ToString();
                txtAccName.Text = dr["AccountName"].ToString();
                txtBank.Text = dr["BankName"].ToString();
                txtBranch.Text = dr["Branch"].ToString();
                ddlStatus.SelectedValue = dr["Status"].ToString();
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("ViewAccounts.aspx");
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Accounts SET AccountNo = @accno, 
                                AccountName = @accname,
                                BankName = @bname, Branch = @brnch, Status = @status
                                WHERE AccountID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@accno", txtAccNo.Text);
            cmd.Parameters.AddWithValue("@accname", txtAccName.Text);
            cmd.Parameters.AddWithValue("@bname", txtBank.Text);
            cmd.Parameters.AddWithValue("@brnch", txtBranch.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("ViewAccounts.aspx");
    }
}