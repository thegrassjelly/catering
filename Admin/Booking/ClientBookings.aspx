﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="ClientBookings.aspx.cs" Inherits="Admin_Booking_ClientBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <i class="fa fa-list"></i> View Client Bookings

    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

    <script type="text/javascript">
        $(document).ready(function () {
            SearchUser();
        });
        // if you use jQuery, you can load them when dom is read.
        $(document).ready(function () {
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_initializeRequest(InitializeRequest);
            prm.add_endRequest(EndRequest);

        });

        function InitializeRequest(sender, args) {
        }

        function EndRequest(sender, args) {
            // after update occur on UpdatePanel re-init the Autocomplete
            SearchUser();
        }

        function SearchUser() {
            $("#<%=txtName.ClientID %>").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "ClientBookings.aspx/GetName",
                        data: "{'prefixText':'" + request.term + "'}",
                        dataType: "json",
                        success: function(data) {
                            response($.map(data.d,
                                function(item) {
                                    return {
                                        label: item.split('/vn/')[0],
                                        val: item.split('/vn/')[1]
                                    }
                                }))
                        },
                        error: function(result) {
                            alert("Error");
                        }
                    });
                },
                select: function(e, i) {
                    $("#<%=hfName.ClientID %>").val(i.item.val);
                },
                minLength: 2
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-4">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Search Client
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="control-label col-lg-3">Search Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtName" class="form-control" runat="server" required />
                                </div>
                                <div class="col-lg-2">
                                    <asp:LinkButton ID="btnUser" runat="server" OnClick="btnUser_Click" CssClass="btn btn-success"> 
                                                <i class="fa fa-refresh"></i></asp:LinkButton>
                                </div>
                                <asp:HiddenField runat="server" Value="0" ID="hfName" />
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">First Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtFN" class="form-control" runat="server" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Last Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtLN" class="form-control" runat="server" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Email</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"
                                        class="form-control" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Mobile No.</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtMNo" class="form-control" runat="server"
                                        TextMode="Number" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Address</label>
                                <div class="col-lg-7">
                                    <asp:TextBox ID="txtAddr" class="form-control" runat="server"
                                        TextMode="Multiline" Style="max-width: 100%;" disabled />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Booking List
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlBookingType" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlBookingType_SelectedIndexChanged">
                                            <asp:ListItem Text="All Bookings" Value="All Bookings" />
                                            <asp:ListItem Text="10 Seater Round" Value="10 Seater Round" />
                                            <asp:ListItem Text="Cocktail Table" Value="Cocktail Table" />
                                            <asp:ListItem Text="Party Tray" Value="Party Tray" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlPaymentStatus" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlPaymentStatus_SelectedIndexChanged">
                                            <asp:ListItem Text="All Status" Value="All Status" />
                                            <asp:ListItem Text="Pending" Value="Pending" />
                                            <asp:ListItem Text="Paid" Value="Paid" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-10">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtSearch" runat="server" class="form-control autosuggest"
                                            placeholder="Keyword..." OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" />
                                        <span class="input-group-btn">
                                            <asp:LinkButton ID="btnSearch" runat="server" class="btn btn-info"
                                                OnClick="btnSearch_Click">
                                      <i class="fa fa-search"></i>
                                            </asp:LinkButton>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>Booking Type</th>
                                    <th>Address</th>
                                    <th>Event Date & Time</th>
                                    <th>Payment Status</th>
                                    <th>Date Added</th>
                                    <th></th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvBooking" runat="server"
                                        OnPagePropertiesChanging="lvBooking_PagePropertiesChanging"
                                        OnDataBound="lvBooking_DataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("MainTable") %></td>
                                                <td><%# Eval("Address") %></td>
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

