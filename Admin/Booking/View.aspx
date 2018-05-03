<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Admin_Booking_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i> Booking List
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
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlBookingType" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlBookingType_OnSelectedIndexChanged">
                                            <asp:ListItem Text="All Bookings" Value="All Bookings" />
                                            <asp:ListItem Text="10 Seater Round" Value="10 Seater Round" />
                                            <asp:ListItem Text="Cocktail Table" Value="Cocktail Table" />
                                            <asp:ListItem Text="Party Tray" Value="Party Tray" />
                                            <asp:ListItem Text="Buffet Only" Value="Buffet Only" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlPaymentStatus" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlPaymentStatus_OnSelectedIndexChanged">
                                            <asp:ListItem Text="All Status" Value="All Status" />
                                            <asp:ListItem Text="Pending" Value="Pending" />
                                            <asp:ListItem Text="Paid" Value="Paid" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-10">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearch" runat="server" class="form-control autosuggest"
                                            placeholder="Keyword..." OnTextChanged="txtSearch_OnTextChanged" AutoPostBack="true" />
                                        <span class="input-group-btn">
                                            <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-info"
                                                OnClick="btnSearch_OnClick">
                                      <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>Client Name</th>
                                    <th>Account Executive</th>
                                    <th>Event Location</th>
                                    <th>Booking Type</th>
                                    <th>Event Date & Time</th>
                                    <th>Payment Status</th>
                                    <th>Date Added</th>
                                    <th></th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvBooking" runat="server"
                                        OnPagePropertiesChanging="lvBooking_OnPagePropertiesChanging"
                                        OnDataBound="lvBooking_OnDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("ContactFirstName") %> <%# Eval("ContactLastName") %> </td>
                                                <td><%# Eval("AccountExec") %></td>
                                                <td><%# Eval("EventAddress") %></td>
                                                <td><%# Eval("MainTable") %></td>
                                                <td><%# Eval("EventDateTime", "{0: dddd, MMMM d, yyyy hh:mm tt}") %></td>
                                                <td>
                                                    <span class='<%# Eval("Status").ToString() == "Pending" ? "label label-danger" : "label label-success"%>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
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
                            <center>
                                <asp:DataPager id="dpBooking" runat="server" pageSize="10" PagedControlID="lvBooking">
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

