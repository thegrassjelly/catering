using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
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
        Helper.ValidateAdmin();

        if (!IsPostBack)
        {
            GetStockTypes();
            GetClientHist();
            GetMenu();
            GetBookingLinens();
        }
    }

    private void GetStockTypes()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT StockTypeID, StockTypeName FROM StockType " +
                              "WHERE Status = 'Active'";
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                ddlStockType.DataSource = dr;
                ddlStockType.DataTextField = "StockTypeName";
                ddlStockType.DataValueField = "StockTypeID";
                ddlStockType.DataBind();
            }
        }
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

    private void GetMenu()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT MenuID, MenuName, Guest, DateAdded
                                FROM Menu
                                WHERE BookingDetailsID = '-1' AND UserID = @id";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Menu");
            lvMenu.DataSource = ds;
            lvMenu.DataBind();
        }
    }

    private void GetBookingLinens()
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT StockTypeName, BookingLinenID, StockName, BookingLinen.Qty, StockDescription,
                                BookingLinen.DateAdded
                                FROM BookingLinen
                                INNER JOIN Stocks ON BookingLinen.StockID = Stocks.StockID
                                INNER JOIN StockType ON Stocks.StockTypeID = StockType.StockTypeID
                                WHERE BookingDetailsID = '-1' AND UserID = @id";
            cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "BookingLinen");
            lvLinen.DataSource = ds;
            lvLinen.DataBind();
        }
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

    [WebMethod]
    public static List<string> GetStocks(string stockname, string stocktype)
    {
        List<string> name = new List<string>();

        using (SqlConnection conn = new SqlConnection())
        {
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["myCon"].ConnectionString;
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.CommandText = @"SELECT StockID, StockName FROM
                                    Stocks
                                    WHERE StockName LIKE @keyword 
                                    AND Stocks.Status = 'Active'
                                    AND StockTypeID = @stocktype";
                cmd.Parameters.AddWithValue("@keyword", "%" + stockname + "%");
                cmd.Parameters.AddWithValue("@stocktype", stocktype);
                cmd.Connection = conn;
                conn.Open();
                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    while (dr.Read())
                    {
                        string myString = dr["StockName"] + "/vn/" + dr["StockID"];
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

    protected void btnStock_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT StockID,
                StockName, StockDescription, Qty, 
                Stocks.Status FROM Stocks 
                WHERE StockID = @id";
            cmd.Parameters.AddWithValue("@id", hfName2.Value);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtStockName.Text = dr["StockName"].ToString();
                        txtStockDesc.Text = dr["StockDescription"].ToString();
                        txtQty.Text = dr["Qty"].ToString();
                    }
                }
            }
        }
    }

    protected void btnAddLinen_OnClick(object sender, EventArgs e)
    {
        if (hfName2.Value != "0")
        {
            pnlStockError.Visible = false;

            using (var con = new SqlConnection(Helper.GetCon()))
            using (var cmd = new SqlCommand())
            {
                con.Open();
                cmd.Connection = con;
                cmd.CommandText = @"INSERT INTO BookingLinen
                                (StockID, Qty, BookingDetailsID, UserID, DateAdded)
                                VALUES
                                (@sid, @qty, @bdid, @uid, @dadded)";
                cmd.Parameters.AddWithValue("@sid", hfName2.Value);
                cmd.Parameters.AddWithValue("@qty", txtLinenQty.Text);
                cmd.Parameters.AddWithValue("@bdid", "-1");
                cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
                cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
                cmd.ExecuteNonQuery();
            }

            GetBookingLinens();
        }
        else
        {
            pnlStockError.Visible = true;
        }
    }

    protected void btnAddMenu_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Menu
                                (MenuName, Guest, BookingDetailsID, UserID, DateAdded)
                                VALUES
                                (@menuname, @guest, @bdid, @uid, @dadded)";
            cmd.Parameters.AddWithValue("@menuname", txtMenuName.Text);
            cmd.Parameters.AddWithValue("@guest", ddlGuest.SelectedValue);
            cmd.Parameters.AddWithValue("@bdid", "-1");
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();
        }

        GetMenu();
    }

    protected void lvLinen_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpLinen.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetBookingLinens();
    }

    protected void lvLinen_OnDataBound(object sender, EventArgs e)
    {
        dpLinen.Visible = dpLinen.PageSize < dpLinen.TotalRowCount;
    }

    protected void lvLinen_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Literal ltBLID = (Literal)e.Item.FindControl("ltBLID");

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"DELETE FROM BookingLinen
                                WHERE BookingLinenID = @id";
            cmd.Parameters.AddWithValue("@id", ltBLID.Text);
            cmd.ExecuteNonQuery();
        }

        GetBookingLinens();
    }

    protected void lvMenu_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpMenu.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetMenu();
    }

    protected void lvMenu_OnDataBound(object sender, EventArgs e)
    {
        dpMenu.Visible = dpMenu.PageSize < dpMenu.TotalRowCount;
    }

    protected void lvMenu_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Literal ltMenuID = (Literal)e.Item.FindControl("ltMenuID");

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"DELETE FROM Menu
                                WHERE MenuID = @id";
            cmd.Parameters.AddWithValue("@id", ltMenuID.Text);
            cmd.ExecuteNonQuery();
        }

        GetMenu();
    }

    protected void btnSubmit_OnClick(object sender, EventArgs e)
    {

        //    using (var con = new SqlConnection(Helper.GetCon()))
        //    using (var cmd = new SqlCommand())
        //    {
        //        con.Open();
        //        cmd.Connection = con;
        //        cmd.CommandText = @"INSERT INTO Bookings
        //                            (EventDate, IngressTime, EventTime, EatingTime,
        //                            Theme, AdultGuest, KidGuest, ClientID, Remarks, UserID, DateAdded)
        //                            VALUES
        //                            (@edate, @itime, @evtime, @eattime, @theme, @aguest, @kguest,
        //                            @cid, @rmrks, @uid, @dadded); 
        //                            SELECT TOP 1 BookingID FROM Bookings WHERE UserID = @ID ORDER BY BookingID DESC";
        //        cmd.Parameters.AddWithValue("@edate", txtEventDate.Text);
        //        cmd.Parameters.AddWithValue("@itime", txtIngressTime.Text);
        //        cmd.Parameters.AddWithValue("@evtime", txtEventTime.Text);
        //        cmd.Parameters.AddWithValue("@eattime", txtEatingTime.Text);
        //        cmd.Parameters.AddWithValue("@theme", txtTheme.Text);
        //        cmd.Parameters.AddWithValue("@aguest", txtAdultPax.Text);
        //        cmd.Parameters.AddWithValue("@kguest", txtKidPax.Text);
        //        cmd.Parameters.AddWithValue("@cid", hfName.Value);
        //        cmd.Parameters.AddWithValue("@rmks", txtRemarks.Text);
        //        cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
        //        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
        //        int bookingid = (int)cmd.ExecuteScalar();
        //    }
        //}
    }
}