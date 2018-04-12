using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Booking_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetClientHist();
    }

    [WebMethod]
    public static List<string> GetName(string prefixText)
    {
        List<string> name = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["myCon"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = @"SELECT ContactFirstName, ContactLastName, ClientID FROM Clients WHERE 
                    ContactFirstName LIKE @SearchText OR
                    ContactLastName LIKE @SearchText
                    ORDER BY ContactLastName ASC";
                cmd.Parameters.AddWithValue("@SearchText", "%" + prefixText + "%");
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string myString = dr["ContactLastName"] + ", " + dr["ContactFirstName"] + "/vn/" + dr["ClientID"];
                        name.Add(myString);
                    }
                }

                conn.Close();
            }

        }
        return name;
    }

    protected void btnUser_OnClick(object sender, EventArgs e)
    {
        if (hfName.Value != "0")
        {
            using (var con = new SqlConnection(Helper.GetCon()))
            using (var cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = @"SELECT ClientID, ContactFirstName, ContactLastName, 
                EmailAddress, ContactNo, Address
                FROM Clients WHERE ClientID = @id";
                cmd.Parameters.AddWithValue("@id", hfName.Value);
                using (var dr = cmd.ExecuteReader())
                {
                    if (dr.HasRows)
                    {
                        if (dr.Read())
                        {
                            txtFN.Text = dr["ContactFirstName"].ToString();
                            txtLN.Text = dr["ContactLastName"].ToString();
                            txtEmail.Text = dr["EmailAddress"].ToString();
                            txtAddr.Text = dr["Address"].ToString();
                            txtMNo.Text = dr["ContactNo"].ToString();
                        }
                    }
                }
            }
        }
    }

    protected void ddlClientHist_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GetClientHist();
        pnlAddedClient.Visible = false;
    }

    private void GetClientHist()
    {
        if (ddlClientHist.SelectedValue == "New Client")
        {
            pnlNewClient.Visible = true;
            pnlOldClient.Visible = false;
        }
        else
        {
            pnlNewClient.Visible = false;
            pnlOldClient.Visible = true;
        }
    }

    protected void btnAdd_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Clients
                            (ContactFirstName, ContactLastName, ContactNo, Address,
                            EmailAddress, DateAdded) VALUES
                            (@fn, @ln, @conct, @addr, @eadd, @dadded)";
            cmd.Parameters.AddWithValue("@fn", txtNewFN.Text);
            cmd.Parameters.AddWithValue("@ln", txtNewLN.Text);
            cmd.Parameters.AddWithValue("@conct", txtNewMob.Text);
            cmd.Parameters.AddWithValue("@addr", txtNewAddr.Text);
            cmd.Parameters.AddWithValue("@eadd", txtNewEmail.Text);
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();

            pnlAddedClient.Visible = true;

            Helper.Log("Add Client",
                "Added client " + txtNewLN.Text + ", " + txtNewFN.Text, "", Session["userid"].ToString());
        }
    }
}