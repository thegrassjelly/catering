<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="SalesReportPrint.aspx.cs" Inherits="Admin_Booking_SalesReportPrint" %>

<%@ Register TagPrefix="CR" Namespace="CrystalDecisions.Web" Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-print"></i> Sales Report
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class=form-horizontal runat="server">
        <asp:ScriptManager runat="server" />
        <div class="row">
            <div class="col-lg-12">
                <CR:CrystalReportViewer ID="crvSalesReport" runat="server"
                    AutoDataBind="true" EnableDatabaseLogonPrompt="false"
                    ToolPanelView="None" />
            </div>
        </div>
    </form>
</asp:Content>

