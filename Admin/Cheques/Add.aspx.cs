using System;
using System.Data.SqlClient;

public partial class Admin_Cheques_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetAccounts();
            GetAccountDetails();
        }
    }

    private void GetAccounts()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT AccountID, AccountName
                              FROM Accounts WHERE Status = 'Active'";
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                ddlAccName.DataSource = dr;
                ddlAccName.DataTextField = "AccountName";
                ddlAccName.DataValueField = "AccountID";
                ddlAccName.DataBind();
            }
        }
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Cheques
                            (AccountID, CheckNo, PayableTo, CheckAmount, CheckDate, DateAdded) 
                            VALUES
                            (@accid, @chkno, @payto, @chkamnt, @chkdate, @dadded)";
            cmd.Parameters.AddWithValue("@accid", ddlAccName.SelectedValue);
            cmd.Parameters.AddWithValue("@chkno", txtCheckNo.Text);
            cmd.Parameters.AddWithValue("@payto", txtPayable.Text);
            cmd.Parameters.AddWithValue("@chkamnt", txtCheckAmnt.Text);
            cmd.Parameters.AddWithValue("@chkdate", txtDate.Text);
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            Helper.Log("Add Cheque",
                "Added new cheque: " + ddlAccName.SelectedItem.Text + " " + txtAccNo.Text + " " + txtPayable.Text,
                "", Session["userid"].ToString());

            Response.Redirect("View.aspx");
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }

    protected void ddlAccName_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetAccountDetails();
    }

    private void GetAccountDetails()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT AccountNo,
                BankName, Branch FROM Accounts WHERE AccountID = @id";
            cmd.Parameters.AddWithValue("@id", ddlAccName.SelectedValue);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtAccNo.Text = dr["AccountNo"].ToString();
                txtBank.Text = dr["BankName"].ToString();
                txtBranch.Text = dr["Branch"].ToString();
            }
        }
    }
}