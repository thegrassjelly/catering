using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class Admin_Suppliers_AddInvoice : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {

        }
    }

    [WebMethod]
    public static List<string> GetSupplier(string prefixText)
    {
        List<string> name = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["myCon"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = @"SELECT SupplierName, SupplierID FROM Suppliers WHERE 
                    SupplierName LIKE @SearchText
                    ORDER BY SupplierName ASC";
                cmd.Parameters.AddWithValue("@SearchText", "%" + prefixText + "%");
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string myString = dr["SupplierName"] + "/vn/" + dr["SupplierID"];
                        name.Add(myString);
                    }
                }

                conn.Close();
            }

        }
        return name;
    }

    protected void btnUser_Click(object sender, EventArgs e)
    {
        if (hfName.Value != "0")
        {
            using (var con = new SqlConnection(Helper.GetCon()))
            using (var cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = @"SELECT SupplierID, SupplierName, ContactNo, 
                Address, ContactNo, ContactPerson, Status
                FROM Suppliers WHERE SupplierID = @id";
                cmd.Parameters.AddWithValue("@id", hfName.Value);
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.HasRows)
                    {
                        if (dr.Read())
                        {
                            txtSupplierName.Text = dr["SupplierName"].ToString();
                            txtPayable.Text = dr["SupplierName"].ToString();
                            txtAddress.Text = dr["Address"].ToString();
                            txtContactNo.Text = dr["ContactNo"].ToString();
                            txtContactPer.Text = dr["ContactPerson"].ToString();
                            txtStatus.Text = dr["Status"].ToString();
                        }
                    }
                }
            }
        }

        GetInvoice();
    }

    protected void btnAddInvoice_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Invoice
                                (InvoiceNumber, Description, InvoiceDate, Amount, 
                                SupplierID, CheckID, Status, UserID, DateAdded)
                                VALUES
                                (@inum, @desc, @idate, @amnt, @supid, @cid, @status, @uid, @dadded)";
            cmd.Parameters.AddWithValue("@inum", txtInvoiceNo.Text);
            cmd.Parameters.AddWithValue("@desc", txtDesc.Text);
            cmd.Parameters.AddWithValue("@idate", txtInvoiceDate.Text);
            cmd.Parameters.AddWithValue("@amnt", txtInvoiceAmnt.Text);
            cmd.Parameters.AddWithValue("@supid", hfName.Value);
            cmd.Parameters.AddWithValue("@cid", -1);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();
        }

        GetInvoice();

        txtInvoiceNo.Text = string.Empty;
        txtDesc.Text = string.Empty;
        txtInvoiceDate.Text = string.Empty;
        txtInvoiceAmnt.Text = string.Empty;
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
                                FROM Invoice WHERE SupplierID = @id 
                                AND UserID = @uid AND CheckID = '-1'";
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@id", hfName.Value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Invoice");
            lvInvoice.DataSource = ds;
            lvInvoice.DataBind();
        }

        GetTotal();
    }

    private void GetTotal()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT SUM(Amount) AS Total
                                FROM Invoice WHERE SupplierID = @id 
                                AND UserID = @uid AND CheckID = '-1'";
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@id", hfName.Value);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                if (dr["Total"].ToString() != "")
                {
                    txtCheckAmnt.Text = Convert.ToDecimal(dr["Total"]).ToString("##.00");
                }
                else
                {
                    txtCheckAmnt.Text = "0.00";
                }
            }
        }
    }

    protected void lvInvoice_PagePropertiesChanging(object sender, System.Web.UI.WebControls.PagePropertiesChangingEventArgs e)
    {
        dpInvoice.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetInvoice();
    }

    protected void lvInvoice_DataBound(object sender, EventArgs e)
    {
        dpInvoice.Visible = dpInvoice.PageSize < dpInvoice.TotalRowCount;
    }

    protected void lvInvoice_ItemCommand(object sender, System.Web.UI.WebControls.ListViewCommandEventArgs e)
    {
        Literal ltInvoiceID = (Literal)e.Item.FindControl("ltInvoiceID");

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"DELETE FROM Invoice
                                WHERE InvoiceID = @id";
            cmd.Parameters.AddWithValue("@id", ltInvoiceID.Text);
            cmd.ExecuteNonQuery();
        }

        GetInvoice();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Cheques
                            (Bank, CheckNo, PayableTo, CheckAmount, CheckDate, DateAdded) 
                            VALUES
                            (@bank, @chkno, @payto, @chkamnt, @chkdate, @dadded);
                            SELECT TOP 1 ChequeID FROM Cheques ORDER BY ChequeID DESC";
            cmd.Parameters.AddWithValue("@bank", txtBank.Text);
            cmd.Parameters.AddWithValue("@chkno", txtCheckNo.Text);
            cmd.Parameters.AddWithValue("@payto", txtPayable.Text);
            cmd.Parameters.AddWithValue("@chkamnt", txtCheckAmnt.Text);
            cmd.Parameters.AddWithValue("@chkdate", txtDate.Text);
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            int chequeid = (int)cmd.ExecuteScalar();

            Helper.Log("Add Cheque",
            "Added new cheque: " + txtBank.Text + txtPayable.Text,
            "", Session["userid"].ToString());

            cmd.Parameters.Clear();
            cmd.CommandText = @"UPDATE Invoice SET CheckID = @cid
                                WHERE SupplierID = @sid AND UserID = @uid
                                AND CheckID = '-1'";
            cmd.Parameters.AddWithValue("@cid", chequeid);
            cmd.Parameters.AddWithValue("@sid", hfName.Value);
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.ExecuteNonQuery();

            Response.Redirect("View.aspx");
        }
    }
}