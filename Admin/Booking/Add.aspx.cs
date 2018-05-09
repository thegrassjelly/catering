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
                EmailAddress, ContactNo
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

    bool isClientExist()
    {
        bool isExist;

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ClientID FROM Clients
                                WHERE ContactFirstName = @cfn AND
                                ContactLastName = @cln AND EmailAddress = @eadd";
            cmd.Parameters.AddWithValue("@cfn", txtNewFN.Text);
            cmd.Parameters.AddWithValue("@cln", txtNewLN.Text);
            cmd.Parameters.AddWithValue("@eadd", txtNewEmail.Text);
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                dr.Read();
                {
                    isExist = dr.HasRows;
                }
            }
        }

        return isExist;
    }

    protected void btnAdd_OnClick(object sender, EventArgs e)
    {
        if (txtNewFN.Text != "" && txtNewLN.Text != "")
        {
            errorClient.Visible = false;

            if (!isClientExist())
            {
                clientExist.Visible = false;

                using (var con = new SqlConnection(Helper.GetCon()))
                using (var cmd = new SqlCommand())
                {
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandText = @"INSERT INTO Clients
                            (ContactFirstName, ContactLastName, ContactNo,
                            EmailAddress, DateAdded) VALUES
                            (@fn, @ln, @conct, @eadd, @dadded)";
                    cmd.Parameters.AddWithValue("@fn", txtNewFN.Text);
                    cmd.Parameters.AddWithValue("@ln", txtNewLN.Text);
                    cmd.Parameters.AddWithValue("@conct", txtNewMob.Text);
                    cmd.Parameters.AddWithValue("@eadd", txtNewEmail.Text);
                    cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
                    cmd.ExecuteNonQuery();

                    txtNewFN.Text = string.Empty;
                    txtNewLN.Text = string.Empty;
                    txtNewEmail.Text = string.Empty;
                    txtNewMob.Text = string.Empty;
                    btnAdd.Visible = false;

                    Helper.Log("Add Client",
                        "Added client: " + txtNewLN.Text + ", " + txtNewFN.Text, "", Session["userid"].ToString());
                }
            }
            else
            {
                clientExist.Visible = true;
            }
        }
        else
        {
            errorClient.Visible = true;
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

    bool isExist()
    {
        bool isExist;

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingLinenID FROM BookingLinen
                                WHERE StockID = @id AND BookingDetailsID = '-1'";
            cmd.Parameters.AddWithValue("@id", hfName2.Value);
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                dr.Read();
                {
                    isExist = dr.HasRows;
                }
            }
        }

        return isExist;
    }

    protected void btnAddLinen_OnClick(object sender, EventArgs e)
    {
        if (hfName2.Value != "0")
        {
            pnlStockError.Visible = false;

            if (!isExist())
            {
                pnlStockExist.Visible = false;

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
                pnlStockExist.Visible = true;
            }
        }
        else
        {
            pnlStockError.Visible = true;
        }
    }

    protected void btnAddMenu_OnClick(object sender, EventArgs e)
    {
        if (txtMenuName.Text != "")
        {
            menuError.Visible = false;

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

            txtMenuName.Text = string.Empty;

            GetMenu();
        }
        else
        {
            menuError.Visible = true;
        }
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
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"INSERT INTO Bookings
                                    (AccountExec, EventDateTime, IngressTime, EatingTime, EventAddress,
                                    Theme, AdultGuest, KidGuest, ClientID, Remarks, UserID, DateAdded)
                                    VALUES
                                    (@aexec, @edate, @itime, @eattime, @eaddr, @theme, @aguest, @kguest,
                                    @cid, @rmrks, @uid, @dadded); 
                                    SELECT TOP 1 BookingID FROM Bookings WHERE UserID = @uid ORDER BY BookingID DESC";
            cmd.Parameters.AddWithValue("@aexec", txtAE.Text);
            cmd.Parameters.AddWithValue("@edate", Convert.ToDateTime(txtEventDT.Text));

            cmd.Parameters.AddWithValue("@itime",
                txtIngressTime.Text == ""
                    ? Convert.ToDateTime(txtEventDT.Text)
                    : Convert.ToDateTime(txtIngressTime.Text));

            cmd.Parameters.AddWithValue("@eattime",
                txtEatingTime.Text == ""
                    ? Convert.ToDateTime(txtEventDT.Text)
                    : Convert.ToDateTime(txtEatingTime.Text));

            cmd.Parameters.AddWithValue("@eaddr", txtAddr.Text);
            cmd.Parameters.AddWithValue("@theme", txtTheme.Text);
            cmd.Parameters.AddWithValue("@aguest", txtAdultPax.Text);
            cmd.Parameters.AddWithValue("@kguest", txtKidPax.Text);
            cmd.Parameters.AddWithValue("@cid", hfName.Value);
            cmd.Parameters.AddWithValue("@rmrks", txtRemarks.Text);
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            int bookingid = (int)cmd.ExecuteScalar();

            if (ddlMainTable.SelectedValue == "Party Tray")
            {
                int bdid = InsertBooking(cmd, bookingid);
                InsertMenu(cmd, bdid);
                InsertPayments(cmd, bookingid);
                InsertSchedule(cmd, bookingid);
            }
            else
            {
                int bdid = InsertBooking(cmd, bookingid);
                InsertLinen(cmd, bdid);
                InsertMenu(cmd, bdid);
                InsertOtherDetails(cmd, bdid);
                InsertPayments(cmd, bookingid);
                InsertSchedule(cmd, bookingid);
            }

            DateTime logdt = Convert.ToDateTime(txtEventDT.Text);

            Helper.Log("Add Booking",
                "Added new booking: " + txtLN.Text + ", " + txtFN.Text + " - " + txtAddr.Text + " - " + logdt
                , "", Session["userid"].ToString());

            Response.Redirect("View.aspx");
        }
    }

    private void InsertSchedule(SqlCommand cmd, int bid)
    {
        DateTime edt = Convert.ToDateTime(txtEventDT.Text);

        cmd.Parameters.Clear();
        cmd.CommandText = @"INSERT INTO Scheduler
                                (Type, StartDate, EndDate, AllDay, Subject, Location,
                                OriginalOccurrenceStart, OriginalOccurrenceEnd, Description, Status,
                                Label, CustomField, TimeZoneID)
                                VALUES
                                (@type, @sdate, @edate, @aday, @sub, @loc, @oos, @ooe, @desc,
                                @stat, @label, @bid, @tzid)";
        cmd.Parameters.AddWithValue("@type", 0);
        cmd.Parameters.AddWithValue("@sdate", edt);
        cmd.Parameters.AddWithValue("@edate", edt.AddHours(3));
        cmd.Parameters.AddWithValue("@aday", "False");
        cmd.Parameters.AddWithValue("@sub", txtFN.Text + " " + txtLN.Text);
        cmd.Parameters.AddWithValue("@loc", txtAddr.Text);
        cmd.Parameters.AddWithValue("@oos", edt);
        cmd.Parameters.AddWithValue("@ooe", edt.AddHours(3));
        cmd.Parameters.AddWithValue("@desc", txtRemarks.Text);
        cmd.Parameters.AddWithValue("@stat", 2);
        cmd.Parameters.AddWithValue("@label", 0);
        cmd.Parameters.AddWithValue("@bid", bid);
        cmd.Parameters.AddWithValue("@tzid", "Singapore Standard Time");
        cmd.ExecuteNonQuery();
    }

    private void InsertPayments(SqlCommand cmd, int bookingid)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"INSERT INTO Payments
                                (BasicFee, MiscFee, MiscDesc, OtherFee, DownPayment, PaymentMethod, Balance, Total, VAT, Status, BookingID, DateAdded)
                                VALUES
                                (@bfee, @mfee, @miscdesc, @ofee, @dp, @paymeth, @blnce, @total, @vat, @status, @bid, @dadded)";
        cmd.Parameters.AddWithValue("@bfee", txtBasicFee.Text);
        cmd.Parameters.AddWithValue("@mfee", txtMiscFee.Text);
        cmd.Parameters.AddWithValue("@miscdesc", txtMiscFeeDesc.Text);
        cmd.Parameters.AddWithValue("@ofee", txtOtherFee.Text);
        cmd.Parameters.AddWithValue("@dp", txtDP.Text);
        cmd.Parameters.AddWithValue("@paymeth", txtPayMethod.Text);
        cmd.Parameters.AddWithValue("@blnce", txtBalance.Text);
        cmd.Parameters.AddWithValue("@total", txtTotal.Text);
        cmd.Parameters.AddWithValue("@vat", ddlVat.SelectedValue);
        cmd.Parameters.AddWithValue("@status", "Pending");
        cmd.Parameters.AddWithValue("@bid", bookingid);
        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
        cmd.ExecuteNonQuery();
    }

    private void InsertOtherDetails(SqlCommand cmd, int bdid)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"INSERT INTO OtherDetails
                                (BookingDetailsID, Stylist, Host, Planner, Media, DateAdded)
                                VALUES
                                (@bdid, @style, @hst, @plnnr, @mdia, @dadded)";
        cmd.Parameters.AddWithValue("@bdid", bdid);
        cmd.Parameters.AddWithValue("@style", txtStylist.Text);
        cmd.Parameters.AddWithValue("@hst", txtHost.Text);
        cmd.Parameters.AddWithValue("@plnnr", txtPlanner.Text);
        cmd.Parameters.AddWithValue("@mdia", txtMedia.Text);
        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
        cmd.ExecuteNonQuery();
    }

    private void InsertMenu(SqlCommand cmd, int bdid)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE Menu SET
                                BookingDetailsID = @bdid
                                WHERE UserID = @id AND BookingDetailsID = '-1'";
        cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
        cmd.Parameters.AddWithValue("@bdid", bdid);
        cmd.ExecuteNonQuery();
    }

    private void InsertLinen(SqlCommand cmd, int bdid)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE BookingLinen SET
                                BookingDetailsID = @bdid
                                WHERE UserID = @id AND BookingDetailsID = '-1'";
        cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
        cmd.Parameters.AddWithValue("@bdid", bdid);
        cmd.ExecuteNonQuery();

        cmd.Parameters.Clear();
        cmd.CommandText = @"SELECT StockID, Qty FROM BookingLinen
                                WHERE BookingDetailsID = @bdid AND UserID = @id";
        cmd.Parameters.AddWithValue("@bdid", bdid);
        cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
        DataTable dt = new DataTable();
        dt.Load(cmd.ExecuteReader());
        cmd.Parameters.Clear();

        foreach (DataRow dr in dt.Rows)
        {
            decimal qty = decimal.Parse(dr["Qty"].ToString());
            int stockid = int.Parse(dr["StockID"].ToString());

            cmd.CommandText = @"UPDATE Stocks SET Qty -= @bookingqty, DateModified = @dmod
                                    WHERE StockID = @sid";
            cmd.Parameters.AddWithValue("@bookingqty", qty);
            cmd.Parameters.AddWithValue("@sid", stockid);
            cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
        }
    }

    private int InsertBooking(SqlCommand cmd, int bookingid)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"INSERT INTO BookingDetails
                                (BookingID, MainTable, MainTableQty, EightSeater, MonoBlock, KiddieTables, BuffetTables,
                                Utensils, RollTop, ChafingDish, Flowers, HeadWaiter, WaterIce,
                                EightSeaterRound, Napkin, ChairCover, BuffetDir, BuffetSkir, BuffetCrump,
                                UserID, DateAdded) 
                                VALUES
                                (@bid, @mtable, @mtableqty, @eightseat, @monob, @ktables, @btables, @uten, @rtop, @cdish,
                                @flr, @hwaiter, @wice, @eightsr, @npkn, @ccover, @bdir, @bskir, @bcrump,
                                @uid, @dadded)
                                SELECT TOP 1 BookingDetailsID FROM BookingDetails WHERE UserID = @uid ORDER BY BookingDetailsID DESC";
        cmd.Parameters.AddWithValue("@bid", bookingid);
        cmd.Parameters.AddWithValue("@mtable", ddlMainTable.SelectedValue);
        cmd.Parameters.AddWithValue("@mtableqty", txtMainTableQty.Text);
        cmd.Parameters.AddWithValue("@eightseat", txtEightSeater.Text);
        cmd.Parameters.AddWithValue("@monob", txtMonoblock.Text);
        cmd.Parameters.AddWithValue("@ktables", txtKiddieTables.Text);
        cmd.Parameters.AddWithValue("@btables", txtBuffetTables.Text);
        cmd.Parameters.AddWithValue("@uten", txtUtensils.Text);
        cmd.Parameters.AddWithValue("@rtop", txtRollTop.Text);
        cmd.Parameters.AddWithValue("@cdish", txtChafingDish.Text);
        cmd.Parameters.AddWithValue("@flr", txtFlowers.Text);
        cmd.Parameters.AddWithValue("@hwaiter", txtHeadWaiter.Text);
        cmd.Parameters.AddWithValue("@wice", txtWaterIce.Text);
        cmd.Parameters.AddWithValue("@eightsr", txtEightSeaterRound.Text);
        cmd.Parameters.AddWithValue("@npkn", txtNapkin.Text);
        cmd.Parameters.AddWithValue("@ccover", txtChairCover.Text);
        cmd.Parameters.AddWithValue("@bdir", txtBuffetDir.Text);
        cmd.Parameters.AddWithValue("@bskir", txtBuffetSkir.Text);
        cmd.Parameters.AddWithValue("@bcrump", txtBuffetCrump.Text);
        cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
        cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
        int bdid = (int)cmd.ExecuteScalar();
        return bdid;
    }

    protected void ddlMainTable_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMainTable.SelectedValue == "Party Tray")
        {
            pnlHides.Visible = false;
            pnlHides2.Visible = false;
            pnlHides3.Visible = false;
            pnlHides4.Visible = false;
        }
        else
        {
            pnlHides.Visible = true;
            pnlHides2.Visible = true;
            pnlHides3.Visible = true;
            pnlHides4.Visible = true;
        }
    }

    protected void ddlVat_SelectedIndexChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    protected void txtBasicFee_TextChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    protected void txtMiscFee_TextChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    protected void txtOtherFee_TextChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    protected void txtDP_TextChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    private void ComputeTotal()
    {
        decimal bcharges, adultpax, kidpax,
            mfee, totaladlt, totalkds,
            ocharges,
            total;

        decimal vat = (decimal.Parse(Helper.vat) / 100) + 1;

        decimal.TryParse(txtBasicFee.Text, out bcharges);
        decimal.TryParse(txtAdultPax.Text, out adultpax);
        decimal.TryParse(txtKidPax.Text, out kidpax);
        decimal.TryParse(txtMiscFee.Text, out mfee);
        decimal.TryParse(txtOtherFee.Text, out ocharges);

        totaladlt = bcharges * adultpax;
        totalkds = bcharges * kidpax;

        txtTotalAdlt.Text = totaladlt.ToString("##.00");
        txtTotalKds.Text = totalkds.ToString("##.00");

        if (ddlVat.SelectedValue == "Yes")
        {

            total = ((totaladlt + totalkds) + mfee + ocharges) * vat;
        }
        else
        {
            total = (totaladlt + totalkds) + mfee + ocharges;
        }

        txtTotal.Text = total.ToString("##.00");
    }

    private void ComputeBalance()
    {
        decimal total, dp;

        decimal.TryParse(txtTotal.Text, out total);
        decimal.TryParse(txtDP.Text, out dp);

        txtBalance.Text = (total - dp).ToString("##.00");
    }
}