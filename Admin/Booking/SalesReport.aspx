<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="SalesReport.aspx.cs" Inherits="Admin_Booking_SalesReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i> Sales Report
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-12">
                    <div class="panel panel-midnightblue">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtDateA" class="form-control" TextMode="Date" runat="server"
                                                 AutoPostback="True" OnTextChanged="txtDateA_TextChanged"/>
                                </div>
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtDateB" class="form-control" TextMode="Date"
                                                 AutoPostback="True" OnTextChanged="txtDateB_TextChanged" runat="server" />
                                </div>
                                <div class="col-lg-2">
                                            <asp:Button ID="btnReport" runat="server" Visible="true" class="btn btn-primary" Text="Print Report"
                                                OnClick="btnReport_Click" />
                                </div>
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>Client Name</th>
                                    <th>Event Location</th>
                                    <th>Booking Type</th>
                                    <th>Event Date & Time</th>
                                    <th>Payment Status</th>
                                    <th>Total</th>
                                    <th>Date Added</th> 
                                    <th></th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvSales" runat="server"
                                        OnPagePropertiesChanging="lvSales_PagePropertiesChanging"
                                        OnDataBound="lvSales_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("ContactFirstName") %> <%# Eval("ContactLastName") %> </td>
                                                <td><%# Eval("EventAddress") %></td>
                                                <td><%# Eval("MainTable") %></td>
                                                <td><%# Eval("EventDateTime", "{0: dddd, MMMM d, yyyy hh:mm tt}") %></td>
                                                <td>
                                                    <span class='<%# Eval("Status").ToString() == "Pending" ? "label label-danger" : "label label-success"%>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td>₱ <%# Eval("Total", "{0: #,###.00}") %></td>
                                                <td><%# Eval("DateAdded", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateBooking.aspx?ID=<%# Eval("BookingID") %>'>
                                                        <asp:Label runat="server" ToolTip="Show Info"><i class="fa fa-search"></i></asp:Label></a>
                                                </td>
                                                <td>
                                                    <a href='BookingReport.aspx?ID=<%# Eval("BookingID") %>'>
                                                        <asp:Label runat="server" ToolTip="Booking Report"><i class="fa fa-print"></i></asp:Label></a>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                        <EmptyDataTemplate>
                                            <tr>
                                                <td colspan="12">
                                                    <h2 class="text-center">No records found.</h2>
                                                </td>
                                            </tr>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </tbody>
                            </table>
                        </div>
                        <div class="panel-footer">
                            <div class="col-lg-3 pull-right">
                                <div class="form-group">
                                    <label class="control-label col-lg-5">Total Sales</label>
                                    <div class="col-lg-7">
                                        <div class="input-group">
                                            <span class="input-group-addon">₱</span>
                                            <asp:TextBox ID="txtTotalSales" class="form-control" runat="server"
                                                disabled />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <center>
                                <asp:DataPager id="dpSales" runat="server" pageSize="10" PagedControlID="lvSales">
                                    <Fields>
                                        <asp:NumericPagerField Buttontype="Button"
                                                               NumericButtonCssClass="btn btn-default"
                                                               CurrentPageLabelCssClass="btn btn-success"
                                                               NextPreviousButtonCssClass ="btn btn-default" 
                                                               ButtonCount="10" />
                                    </Fields>
                                </asp:DataPager>
                            </center>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>

