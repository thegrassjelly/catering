using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_AddAccount : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("ViewAccounts.aspx");
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Accounts
                            (AccountNo, AccountName, BankName, Branch, Status, DateAdded) 
                            VALUES
                            (@accno, @accnme, @bankname, @branch, @status, @dadded)";
            cmd.Parameters.AddWithValue("@accno", txtAccNo.Text);
            cmd.Parameters.AddWithValue("@accnme", txtAccName.Text);
            cmd.Parameters.AddWithValue("@bankname", txtBank.Text);
            cmd.Parameters.AddWithValue("@branch", txtBranch.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Helper.Log("Add Account",
                "Added new account: " + txtBank.Text + " " + txtAccName.Text,
                "", Session["userid"].ToString());

            Response.Redirect("ViewAccounts.aspx");
        }
    }
}