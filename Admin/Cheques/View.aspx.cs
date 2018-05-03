using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Admin_Cheques_View : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            DateTime dn = Helper.PHTime();
            txtDateA.Text = dn.ToString("yyyy-MM-dd");
            txtDateB.Text = dn.AddDays(7).ToString("yyyy-MM-dd");

            GetCheques();
        }
    }

    private void GetCheques()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ChequeID, Bank, PayableTo,
                                CheckNo, CheckAmount, CheckDate
                                FROM Cheques
                                WHERE 
                                (PayableTo LIKE @keyword OR
                                CheckNo LIKE @keyword) AND
                                CheckDate BETWEEN @datea AND @dateb";
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearch.Text + "%");
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
                                WHERE 
                                (PayableTo LIKE @keyword OR
                                CheckNo LIKE @keyword) AND
                                CheckDate BETWEEN @datea AND @dateb";
            cmd.Parameters.AddWithValue("@keyword", "%" + txtSearch.Text + "%");
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

    protected void lvCheques_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpCheques.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetCheques();
    }

    protected void lvCheques_OnDataBound(object sender, EventArgs e)
    {
        dpCheques.Visible = dpCheques.PageSize < dpCheques.TotalRowCount;

    }

    protected void txtDateA_OnTextChanged(object sender, EventArgs e)
    {
        GetCheques();
    }

    protected void txtDateB_OnTextChanged(object sender, EventArgs e)
    {
        GetCheques();
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        GetCheques();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetCheques();
    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        Response.Redirect("SupplierReports.aspx?datea=" + txtDateA.Text + "&&" + "dateb=" + txtDateB.Text);
    }
}