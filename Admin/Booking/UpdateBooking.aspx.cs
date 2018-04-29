using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.UI.WebControls;

public partial class Admin_Booking_UpdateBooking : System.Web.UI.Page
{
    static int _bdid;

    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int bookingID = 0;
        bool validBooking = int.TryParse(Request.QueryString["ID"], out bookingID);

        if (validBooking)
        {
            if (!IsPostBack)
            {
                Hides(bookingID);
                GetClientDetails(bookingID);
            }
        }
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

    bool isExist(int bdid)
    {
        bool isExist;

        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingLinenID FROM BookingLinen
                                WHERE StockID = @id AND BookingDetailsID = @bdid";
            cmd.Parameters.AddWithValue("@id", hfName2.Value);
            cmd.Parameters.AddWithValue("@bdid", bdid);
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

    private void Hides(int bookingId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingDetailsID, MainTable FROM Bookings
                                INNER JOIN
                                BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                WHERE Bookings.BookingID = @id";
            cmd.Parameters.AddWithValue("@id", bookingId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                int bdid = int.Parse(dr["BookingDetailsID"].ToString());
                _bdid = int.Parse(dr["BookingDetailsID"].ToString());

                if (dr["MainTable"].ToString() == "Party Tray")
                {
                    pnlHides.Visible = false;
                    pnlHides2.Visible = false;
                    pnlHides3.Visible = false;
                    pnlHides4.Visible = false;

                    GetBookingDetails(bookingId);
                    GetMenu(bdid);
                    GetPayments(bookingId);
                }
                else
                {
                    GetBookingDetails(bookingId);
                    GetStockTypes();
                    GetLinens(bdid);
                    GetOtherDetails(bdid);
                    GetMenu(bdid);
                    GetPayments(bookingId);
                }
            }
        }
    }

    private void GetOtherDetails(int bdid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT Stylist, Host, Planner, Media
                                FROM OtherDetails
                                WHERE BookingDetailsID = @id";
            cmd.Parameters.AddWithValue("@id", bdid);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                txtStylist.Text = dr["Stylist"].ToString();
                txtHost.Text = dr["Host"].ToString();
                txtPlanner.Text = dr["Planner"].ToString();
                txtMedia.Text = dr["Media"].ToString();
            }
        }
    }

    private void GetLinens(int bdid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingLinen.StockID, StockTypeName, BookingLinenID, StockName, BookingLinen.Qty, StockDescription,
                                BookingLinen.DateAdded
                                FROM BookingLinen
                                INNER JOIN Stocks ON BookingLinen.StockID = Stocks.StockID
                                INNER JOIN StockType ON Stocks.StockTypeID = StockType.StockTypeID
                                WHERE BookingDetailsID = @id OR BookingDetailsID = '0'";
            cmd.Parameters.AddWithValue("@id", bdid);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "BookingLinen");
            lvLinen.DataSource = ds;
            lvLinen.DataBind();
        }
    }

    private void GetMenu(int bdid)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT MenuID, MenuName, Guest, Menu.DateAdded
                                FROM Menu 
                                WHERE BookingDetailsID = @id";
            cmd.Parameters.AddWithValue("@id", bdid);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            con.Close();
            da.Fill(ds, "Menu");
            lvMenu.DataSource = ds;
            lvMenu.DataBind();
        }
    }

    private void GetPayments(int bookingId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BasicFee, MiscFee, MiscDesc, OtherFee, DownPayment,
                                PaymentMethod, Balance, Total, VAT, Status
                                FROM Payments
                                WHERE BookingID = @id";
            cmd.Parameters.AddWithValue("@id", bookingId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                txtBasicFee.Text = dr["BasicFee"].ToString();
                txtMiscFee.Text = dr["MiscFee"].ToString();
                txtMiscFeeDesc.Text = dr["MiscDesc"].ToString();
                txtOtherFee.Text = dr["OtherFee"].ToString();
                txtDP.Text = dr["DownPayment"].ToString();
                txtPayMethod.Text = dr["PaymentMethod"].ToString();
                txtBalance.Text = dr["Balance"].ToString();
                txtTotal.Text = dr["Total"].ToString();
                ddlVat.SelectedValue = dr["VAT"].ToString();
                ddlStatus.SelectedValue = dr["Status"].ToString();
            }
        }
    }

    private void GetBookingDetails(int bookingId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT BookingDetailsID, EventDateTime, IngressTime, EatingTime,
                                EventAddress, Theme, AdultGuest, KidGuest, Remarks,
                                MainTable, MainTableQty, EightSeater, MonoBlock, KiddieTables,
                                BuffetTables, Utensils, RollTop, ChafingDish, Flowers,
                                HeadWaiter, WaterIce, EightSeaterRound, Napkin, ChairCover,
                                BuffetDir, BuffetSkir, BuffetCrump
                                FROM Bookings
                                INNER JOIN
                                BookingDetails ON Bookings.BookingID = BookingDetails.BookingID
                                WHERE Bookings.BookingID = @id";
            cmd.Parameters.AddWithValue("@id", bookingId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;

                DateTime edt = Convert.ToDateTime(dr["EventDateTime"]);
                DateTime it = Convert.ToDateTime(dr["EventDateTime"]);
                DateTime et = Convert.ToDateTime(dr["EventDateTime"]);

                txtEventDT.Text = edt.ToString("yyyy-MM-ddTHH:mm");
                txtIngressTime.Text = it.ToString("HH:mm");
                txtEatingTime.Text = et.ToString("HH:mm");
                txtAddr.Text = dr["EventAddress"].ToString();
                txtTheme.Text = dr["Theme"].ToString();
                txtAdultPax.Text = dr["AdultGuest"].ToString();
                txtKidPax.Text = dr["KidGuest"].ToString();
                txtRemarks.Text = dr["Remarks"].ToString();
                ddlMainTable.SelectedValue = dr["MainTable"].ToString();
                txtMainTableQty.Text = dr["MainTableQty"].ToString();
                txtEightSeater.Text = dr["EightSeater"].ToString();
                txtMonoblock.Text = dr["MonoBlock"].ToString();
                txtKiddieTables.Text = dr["KiddieTables"].ToString();
                txtBuffetTables.Text = dr["BuffetTables"].ToString();
                txtUtensils.Text = dr["Utensils"].ToString();
                txtRollTop.Text = dr["RollTop"].ToString();
                txtChafingDish.Text = dr["ChafingDish"].ToString();
                txtFlowers.Text = dr["Flowers"].ToString();
                txtHeadWaiter.Text = dr["HeadWaiter"].ToString();
                txtWaterIce.Text = dr["WaterIce"].ToString();
                txtEightSeaterRound.Text = dr["EightSeaterRound"].ToString();
                txtNapkin.Text = dr["Napkin"].ToString();
                txtChairCover.Text = dr["ChairCover"].ToString();
                txtFlowers.Text = dr["Flowers"].ToString();
                txtBuffetDir.Text = dr["BuffetDir"].ToString();
                txtBuffetSkir.Text = dr["BuffetSkir"].ToString();
                txtBuffetCrump.Text = dr["BuffetCrump"].ToString();
            }
        }
    }

    private void GetClientDetails(int bookingId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT ContactFirstName, ContactLastName,
                ContactNo, EmailAddress
                FROM Bookings
                INNER JOIN Clients ON Bookings.ClientID = Clients.ClientID
                WHERE BookingID = @id";
            cmd.Parameters.AddWithValue("@id", bookingId);
            using (var dr = cmd.ExecuteReader())
            {
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtFN.Text = dr["ContactFirstName"].ToString();
                txtLN.Text = dr["ContactLastName"].ToString();
                txtEmail.Text = dr["EmailAddress"].ToString();
                txtMNo.Text = dr["ContactNo"].ToString();
            }
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
            cmd.Parameters.AddWithValue("@bdid", _bdid);
            cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
            cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
            cmd.ExecuteNonQuery();
        }

        GetMenu(_bdid);
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Bookings SET
                                EventDateTime = @edt, IngressTime = @itime, EatingTime = @eattime,
                                EventAddress = @eaddr, Theme = @theme, AdultGuest = @aguest, KidGuest = @kguest,
                                Remarks = @rmks WHERE BookingID = @id";
            cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            cmd.Parameters.AddWithValue("@edt", Convert.ToDateTime(txtEventDT.Text));

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
            cmd.Parameters.AddWithValue("@rmks", txtRemarks.Text);
            cmd.ExecuteNonQuery();

            UpdateBookingDetails(cmd);

            if (ddlMainTable.SelectedValue == "Party Tray")
            {
                UpdatePayments(cmd);
                UpdateScheduler(cmd);
            }
            else
            {
                UpdateLinensQty(cmd);
                UpdateOtherDetails(cmd);
                UpdatePayments(cmd);
                UpdateScheduler(cmd);
            }
        }

        Response.Redirect("View.aspx");
    }

    private void UpdateLinensQty(SqlCommand cmd)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"SELECT StockID, Qty FROM BookingLinen
                                WHERE BookingDetailsID = @bdid AND UserID = @id";
        cmd.Parameters.AddWithValue("@bdid", 0);
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

        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE BookingLinen SET BookingDetailsID = @bdid
                            WHERE BookingDetailsID = '0' AND UserID = @id";
        cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
        cmd.Parameters.AddWithValue("@bdid", _bdid);
        cmd.ExecuteNonQuery();
    }

    private void UpdateScheduler(SqlCommand cmd)
    {
        DateTime edt = Convert.ToDateTime(txtEventDT.Text);

        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE Scheduler SET
                                    StartDate = @sdate, EndDate = @edate,
                                    OriginalOccurrenceStart = @oos,
                                    OriginalOccurrenceEnd = @ooe,
                                    Description = @desc
                                    WHERE CustomField = @id";
        cmd.Parameters.AddWithValue("@sdate", edt);
        cmd.Parameters.AddWithValue("@edate", edt.AddHours(3));
        cmd.Parameters.AddWithValue("@oos", edt);
        cmd.Parameters.AddWithValue("@ooe", edt.AddHours(3));
        cmd.Parameters.AddWithValue("@desc", txtRemarks.Text);
        cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
        cmd.ExecuteNonQuery();
    }

    private void UpdateOtherDetails(SqlCommand cmd)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE OtherDetails SET Stylist = @style,
                                    Host = @hst, Planner = @plnnr, Media = @mdia
                                    WHERE BookingDetailsID = @id";
        cmd.Parameters.AddWithValue("@id", _bdid);
        cmd.Parameters.AddWithValue("@style", txtStylist.Text);
        cmd.Parameters.AddWithValue("@hst", txtHost.Text);
        cmd.Parameters.AddWithValue("@plnnr", txtPlanner.Text);
        cmd.Parameters.AddWithValue("@mdia", txtMedia.Text);
        cmd.ExecuteNonQuery();
    }

    private void UpdatePayments(SqlCommand cmd)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE Payments SET
                                    BasicFee = @bfee, MiscFee = @mfee,
                                    MiscDesc = @mdesc, PaymentMethod = @paymeth,
                                    OtherFee = @ofee, DownPayment = @dp,
                                    Balance = @blnce, Total = @total, VAT = @vat,
                                    Status = @status
                                    WHERE BookingID = @id";
        cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
        cmd.Parameters.AddWithValue("@bfee", txtBasicFee.Text);
        cmd.Parameters.AddWithValue("@mfee", txtMiscFee.Text);
        cmd.Parameters.AddWithValue("@mdesc", txtMiscFeeDesc.Text);
        cmd.Parameters.AddWithValue("@paymeth", txtPayMethod.Text);
        cmd.Parameters.AddWithValue("@ofee", txtOtherFee.Text);
        cmd.Parameters.AddWithValue("@dp", txtDP.Text);
        cmd.Parameters.AddWithValue("@blnce", txtBalance.Text);
        cmd.Parameters.AddWithValue("@total", txtTotal.Text);
        cmd.Parameters.AddWithValue("@vat", ddlVat.SelectedValue);
        cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
        cmd.ExecuteNonQuery();
    }

    private void UpdateBookingDetails(SqlCommand cmd)
    {
        cmd.Parameters.Clear();
        cmd.CommandText = @"UPDATE BookingDetails SET
                                MainTable = @mtable, MainTableQty = @mtableqty, EightSeater = @eightseat, MonoBlock = @monob,
                                KiddieTables = @ktables, BuffetTables = @btables, Utensils = @uten,
                                RollTop = @rtop, ChafingDish = @cdish, Flowers = @flr, HeadWaiter = @hwaiter,
                                WaterIce = @wice, EightSeaterRound = @eightsr, Napkin = @npkn, ChairCover = @ccover,
                                BuffetDir = @bdir, BuffetSkir = @bskir, BuffetCrump = @bcrump
                                WHERE BookingDetailsID = @id";
        cmd.Parameters.AddWithValue("@id", _bdid);
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
        cmd.ExecuteNonQuery();
    }

    protected void btnAddLinen_OnClick(object sender, EventArgs e)
    {
        if (hfName2.Value != "0")
        {
            pnlStockError.Visible = false;

            if (!isExist(_bdid))
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
                    cmd.Parameters.AddWithValue("@bdid", 0);
                    cmd.Parameters.AddWithValue("@uid", Session["userid"].ToString());
                    cmd.Parameters.AddWithValue("@dadded", Helper.PHTime());
                    cmd.ExecuteNonQuery();
                }

                GetLinens(_bdid);
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
                if (!dr.HasRows) return;
                if (!dr.Read()) return;
                txtStockName.Text = dr["StockName"].ToString();
                txtStockDesc.Text = dr["StockDescription"].ToString();
                txtQty.Text = dr["Qty"].ToString();
            }
        }
    }

    protected void lvLinen_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpLinen.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetLinens(_bdid);
    }

    protected void lvLinen_OnDataBound(object sender, EventArgs e)
    {
        dpLinen.Visible = dpLinen.PageSize < dpLinen.TotalRowCount;
    }

    protected void lvLinen_OnItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Literal ltBLID = (Literal)e.Item.FindControl("ltBLID");
        Literal ltStockID = (Literal)e.Item.FindControl("ltStockID");
        Literal ltQty = (Literal)e.Item.FindControl("ltQty");

        int stockid = int.Parse(ltStockID.Text);
        int qty = int.Parse(ltQty.Text);
            
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;

            cmd.CommandText = @"UPDATE Stocks SET Qty += @qty, DateModified = @dmod
                                WHERE StockID = @sid";
            cmd.Parameters.AddWithValue("@qty", qty);
            cmd.Parameters.AddWithValue("@sid", stockid);
            cmd.Parameters.AddWithValue("@dmod", Helper.PHTime());
            cmd.ExecuteNonQuery();

            cmd.CommandText = @"DELETE FROM BookingLinen
                                WHERE BookingLinenID = @id";
            cmd.Parameters.AddWithValue("@id", ltBLID.Text);
            cmd.ExecuteNonQuery();
        }

        GetLinens(_bdid);
    }

    protected void lvMenu_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    {
        dpMenu.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
        GetMenu(_bdid);
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

        GetMenu(_bdid);
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

    protected void ddlVat_SelectedIndexChanged(object sender, EventArgs e)
    {
        ComputeTotal();
        ComputeBalance();
    }

    private void ComputeTotal()
    {
        decimal bcharges,
            mfee,
            ocharges,
            total;

        decimal vat = (decimal.Parse(Helper.vat) / 100) + 1;

        decimal.TryParse(txtBasicFee.Text, out bcharges);
        decimal.TryParse(txtMiscFee.Text, out mfee);
        decimal.TryParse(txtOtherFee.Text, out ocharges);


        if (ddlVat.SelectedValue == "Yes")
        {

            total = (bcharges + mfee + ocharges) * vat;
        }
        else
        {
            total = bcharges + mfee + ocharges;
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