﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Users_UpdateUsers : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Helper.ValidateAdmin();

        int userID = 0;
        bool validUser = int.TryParse(Request.QueryString["ID"], out userID);

        if (validUser)
        {
            if (!IsPostBack)
            {
                GetUserType();
                GetUser(userID);
            }
        }
        else if (Request.QueryString["Profile"] == "1")
        {
            if (!IsPostBack)
            {
                GetUserType();
                GetUser(int.Parse(Session["userid"].ToString()));
            }
        }
    }

    void GetUserType()
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "SELECT TypeID, UserType FROM UserTypes";
            using (SqlDataReader dr = cmd.ExecuteReader())
            {
                ddlType.DataSource = dr;
                ddlType.DataTextField = "UserType";
                ddlType.DataValueField = "TypeID";
                ddlType.DataBind();
            }
        }
    }

    private void GetUser(int userId)
    {
        using (var con = new SqlConnection(Helper.GetCon()))
        using (var cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"SELECT UserID, FirstName, LastName,
                UserName,
                Status, TypeID FROM Users WHERE UserID = @id";
            cmd.Parameters.AddWithValue("@id", userId);
            using (var dr = cmd.ExecuteReader())
            {
                if (dr.HasRows)
                {
                    if (dr.Read())
                    {
                        txtID.Text = dr["UserID"].ToString();
                        txtFN.Text = dr["FirstName"].ToString();
                        txtLN.Text = dr["LastName"].ToString();
                        txtUName.Text = dr["UserName"].ToString();
                        ddlStatus.SelectedValue = dr["Status"].ToString();
                        ddlType.SelectedValue = dr["TypeID"].ToString();
                    }
                }
            }
        }
    }

    protected void btnUpdate_OnClick(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(Helper.GetCon()))
        using (SqlCommand cmd = new SqlCommand())
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = @"UPDATE Users SET FirstName = @fn,
                        LastName = @ln,
                        Status = @status,
                        TypeID = @type WHERE UserID = @id";

            if (Request.QueryString["Profile"] == "1")
            {
                cmd.Parameters.AddWithValue("@id", Session["userid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@id", Request.QueryString["ID"]);
            }

            cmd.Parameters.AddWithValue("@fn", txtFN.Text);
            cmd.Parameters.AddWithValue("@ln", txtLN.Text);
            cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedValue);
            cmd.Parameters.AddWithValue("@type", ddlType.SelectedValue);
            cmd.ExecuteNonQuery();
        }

        Response.Redirect("View.aspx");
    }

    protected void btnBack_OnClick(object sender, EventArgs e)
    {
        Response.Redirect("View.aspx");
    }
}