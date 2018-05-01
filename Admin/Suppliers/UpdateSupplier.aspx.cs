using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Suppliers_UpdateSupplier : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int supplierID = 0;
        bool validSupplier = int.TryParse(Request.QueryString["ID"], out supplierID);

        if (validSupplier)
        {
            if (!IsPostBack)
            {
                DateTime dn = Helper.PHTime();
                txtDateA.Text = dn.ToString("yyyy-MM-dd");
                txtDateB.Text = dn.AddDays(30).ToString("yyyy-MM-dd");

                txtDateC.Text = dn.ToString("yyyy-MM-dd");
                txtDateD.Text = dn.AddDays(30).ToString("yyyy-MM-dd");

                GetSupplierDetails(supplierID);
                GetCheque();
                GetInvoice();
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
                                FROM Invoice 
                                WHERE SupplierID = @id AND
                                InvoiceDate BETWEEN @datea AND @dateb";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@datea", txtDateA.Text);
            cmd.Parameters.AddWithValue("@dateb", txtDateB.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Invoice");
            lvInvoice.DataSource = ds;
            lvInvoice.DataBind();
        }
    }

    private void GetCheque()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ChequeID, AccountName, AccountNo, PayableTo,
                                CheckNo, CheckAmount, CheckDate
                                FROM Cheques
                                INNER JOIN Accounts ON Cheques.AccountID = Accounts.AccountID
                                WHERE PayableTo = @supname AND
                                CheckDate BETWEEN @datea AND @dateb";
            cmd.Parameters.AddWithValue("@supname", txtSupplierName.Text);
            cmd.Parameters.AddWithValue("@datea", txtDateA.Text);
            cmd.Parameters.AddWithValue("@dateb", txtDateB.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Cheques");
            lvCheques.DataSource = ds;
            lvCheques.DataBind();
        }

        GetTotalCheques();
    }

    private void GetTotalCheques()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SUM(CheckAmount) AS Total FROM Cheques
                                WHERE PayableTo = @supname AND
                                CheckDate BETWEEN @datea AND @dateb";
            cmd.Parameters.AddWithValue("@supname", txtSupplierName.Text);
            cmd.Parameters.AddWithValue("@datea", txtDateA.Text);
            cmd.Parameters.AddWithValue("@dateb", txtDateB.Text);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                if (dr["Total"].ToString() != "")
                {
                    txtTotalCheque.Text = Convert.ToDecimal(dr["Total"]).ToString("#,###.00");
                }
                else
                {
                    txtTotalCheque.Text = "0.00";
                }
            }
        }
    }

    private void GetSupplierDetails(int supplierId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SupplierName, ContactNo, Address,
                ContactPerson, Status FROM Suppliers WHERE SupplierID = @id";
            cmd.Parameters.AddWithValue("@id", supplierId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtSupplierName.Text = dr["SupplierName"].ToString();
                txtContactNo.Text = dr["ContactNo"].ToString();
                txtAddress.Text = dr["Address"].ToString();
                txtContactPer.Text = dr["ContactPerson"].ToString();
                ddlStatus.SelectedValue = dr["Status"].ToString();
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
            cmd.CommandText = @"UPDATE Suppliers 
                        SET SupplierName = @sn,
                        ContactNo = @cn,
                        Address = @addr,
                        ContactPerson = @cp,
                        Status = @status
                        WHERE SupplierID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@sn", txtSupplierName.Text);
            cmd.Parameters.AddWithValue("@cn", txtContactNo.Text);
            cmd.Parameters.AddWithValue("@addr", txtAddress.Text);
            cmd.Parameters.AddWithValue("@cp", txtContactPer.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("View.aspx");
    }

    protected void txtDateA_TextChanged(object sender, EventArgs e)
    {
        GetCheque();
    }

    protected void txtDateB_TextChanged(object sender, EventArgs e)
    {
        GetCheque();
    }

    protected void lvCheques_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpCheques.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetCheque();
    }

    protected void lvCheques_DataBound(object sender, EventArgs e)
    {
        dpCheques.Visible = dpCheques.PageSize < dpCheques.TotalRowCount;
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

    protected void txtDateC_TextChanged(object sender, EventArgs e)
    {
        GetInvoice();
    }

    protected void txtDateD_TextChanged(object sender, EventArgs e)
    {
        GetInvoice();
    }
}