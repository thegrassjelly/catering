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
                GetChequeDetails(chequeid);;
                GetInvoice();
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
            cmd.CommandText = @"SELECT Bank,
                CheckNo, PayableTo, CheckAmount,
                CheckDate FROM Cheques WHERE ChequeID = @id";
            cmd.Parameters.AddWithValue("@id", chequeid);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtBank.Text = dr["Bank"].ToString();
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
            cmd.CommandText = @"UPDATE Cheques SET Bank = @bank, 
                                CheckNo = @cno,
                                PayableTo = @payto, CheckAmount = @camnt, CheckDate = @cdate
                                WHERE ChequeID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@bank", txtBank.Text);
            cmd.Parameters.AddWithValue("@cno", txtCheckNo.Text);
            cmd.Parameters.AddWithValue("@payto", txtPayable.Text);
            cmd.Parameters.AddWithValue("@camnt", txtCheckAmnt.Text);
            cmd.Parameters.AddWithValue("@cdate", txtDate.Text);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("View.aspx");
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