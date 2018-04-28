<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="BookingReport.aspx.cs" Inherits="Admin_Booking_BookingReport" %>

<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-print"></i> Booking Report
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class=form-horizontal runat="server">
        <asp:ScriptManager runat="server" />
        <div class="row">
            <div class="col-lg-12">
                <div class="form-group">
                    <div class="col-lg-2">
                        <asp:DropDownList ID="ddlReportType" class="form-control" runat="server"
                            AutoPostBack="true" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                            <asp:ListItem>Default</asp:ListItem>
                            <asp:ListItem>Stripped</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                <CR:CrystalReportViewer ID="crvBookingReport" runat="server"
                    AutoDataBind="true" EnableDatabaseLogonPrompt="false"
                    ToolPanelView="None" />
            </div>
        </div>
    </form>
</asp:Content>

