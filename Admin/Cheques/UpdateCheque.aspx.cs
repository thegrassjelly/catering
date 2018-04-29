using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_UpdateCheque : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int chequeid = 0;
        bool validCheque = int.TryParse(Request.QueryString["ID"], out chequeid);

        if (validCheque)
        {
            if (!IsPostBack)
            {
                GetAccounts();
                GetChequeDetails(chequeid);
                GetAccountDetails();
                GetInvoice();
            }
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

    private void GetChequeDetails(int chequeid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT AccountID,
                CheckNo, PayableTo, CheckAmount,
                CheckDate FROM Cheques WHERE ChequeID = @id";
            cmd.Parameters.AddWithValue("@id", chequeid);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                ddlAccName.SelectedValue = dr["AccountID"].ToString();
                txtCheckNo.Text = dr["CheckNo"].ToString();
                txtPayable.Text = dr["PayableTo"].ToString();
                txtCheckAmnt.Text = dr["CheckAmount"].ToString();
                DateTime cdate = DateTime.Parse(dr["CheckDate"].ToString());
                txtDate.Text = cdate.ToString("yyyy-MM-dd");
            }
        }
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Cheques SET AccountID = @accid, 
                                CheckNo = @cno,
                                PayableTo = @payto, CheckAmount = @camnt, CheckDate = @cdate
                                WHERE ChequeID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@accid", ddlAccName.SelectedValue);
            cmd.Parameters.AddWithValue("@cno", txtCheckNo.Text);
            cmd.Parameters.AddWithValue("@payto", txtPayable.Text);
            cmd.Parameters.AddWithValue("@camnt", txtCheckAmnt.Text);
            cmd.Parameters.AddWithValue("@cdate", txtDate.Text);
            cmd.ExecuteNonQuery();
        }

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

    private void GetInvoice()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT InvoiceID, InvoiceNumber, Description,
                                InvoiceDate, Amount, Status, DateAdded
                                FROM Invoice WHERE CheckID = @cid";
            cmd.Parameters.AddWithValue("@cid", Request.QueryString["ID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Invoice");
            lvInvoice.DataSource = ds;
            lvInvoice.DataBind();
        }
    }

    protected void lvInvoice_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpInvoice.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetInvoice();
    }

    protected void lvInvoice_DataBound(object sender, EventArgs e)
    {
        dpInvoice.Visible = dpInvoice.PageSize < dpInvoice.TotalRowCount;
    }
}