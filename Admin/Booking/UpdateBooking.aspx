<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="UpdateBooking.aspx.cs" Inherits="Admin_Booking_UpdateBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-search"></i> Booking Details
    
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

    <script type="text/javascript">
        $(document).ready(function () {
            SearchText();
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
            SearchText();
        }

        function SearchText() {
            $(".autosuggest").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "UpdateBooking.aspx/GetStocks",
                        data: JSON.stringify({
                            stockname: document.getElementById('<%=txtStockName.ClientID%>').value,
                        stocktype: document.getElementById('<%=ddlStockType.ClientID%>').value
                    }),
                    dataType: "json",
                    success: function (data) {
                        response($.map(data.d,
                            function (item) {
                                return {
                                    label: item.split('/vn/')[0],
                                    val: item.split('/vn/')[1]
                                }
                            }))
                    },
                    error: function (result) {
                        //alert("Error");
                    }
                });
            },
            select: function (e, i) {
                $("#<%=hfName2.ClientID %>").val(i.item.val);
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
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Menu
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="control-label col-lg-3">Menu for</label>
                                <div class="col-lg-5">
                                    <asp:DropDownList ID="ddlGuest" class="form-control" runat="server">
                                        <asp:ListItem>Adult</asp:ListItem>
                                        <asp:ListItem>Kid</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Menu Name</label>
                                <div class="col-lg-7">
                                    <asp:TextBox ID="txtMenuName" class="form-control" runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3"></label>
                                <div class="col-lg-7">
                                    <asp:Button ID="btnAddMenu" class="btn btn-success" runat="server" Text="Add Menu"
                                        OnClick="btnAddMenu_OnClick" />
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <hr />
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>Guest</th>
                                    <th>Menu Name</th>
                                    <th>Date Added</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvMenu" runat="server"
                                        OnPagePropertiesChanging="lvMenu_OnPagePropertiesChanging"
                                        OnDataBound="lvMenu_OnDataBound"
                                        OnItemCommand="lvMenu_OnItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("Guest") %></td>
                                                <asp:Literal ID="ltMenuID" runat="server" Text='<%# Eval("MenuID") %>' Visible="false" />
                                                <td><%# Eval("MenuName") %></td>
                                                <td><%# Eval("DateAdded", "{0: MMMM d, yyyy}") %></td>
                                                <td>
                                                    <asp:Button ID="btnRemoveMenu" CommandName="delitem"
                                                        class="btn btn-sm btn-danger" runat="server" Text='Remove Menu'
                                                        OnSubmitBehavior="false" formnovalidate
                                                        OnClientClick='return confirm("Are you sure?");' />
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
                                    <asp:DataPager id="dpMenu" runat="server" pageSize="5" PagedControlID="lvMenu">
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
                <div class="col-lg-8">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Booking Details
                        </div>
                        <div class="panel-body">
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Event Date & Time</label>
                                    <div class="col-lg-8">
                                        <asp:TextBox ID="txtEventDT" class="form-control"
                                            TextMode="DateTimeLocal" runat="server" />
                                    </div>
                                </div>
                                <div id="pnlHides" runat="server">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Ingress Time</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtIngressTime" class="form-control"
                                                TextMode="Time" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Eating Time</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtEatingTime" class="form-control"
                                                TextMode="Time" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Theme</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtTheme" class="form-control"
                                                runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Adult Guest (pax)</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtAdultPax" class="form-control"
                                                TextMode="number" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Kid Guest (pax)</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtKidPax" class="form-control"
                                                TextMode="number" runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Remarks</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtRemarks" class="form-control" Style="max-width: 100%"
                                            TextMode="Multiline" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Main Table (with stand)</label>
                                    <div class="col-lg-7">
                                        <asp:DropDownList ID="ddlMainTable" class="form-control" runat="server">
                                            <asp:ListItem>10 Seater Round</asp:ListItem>
                                            <asp:ListItem>Cocktail Table</asp:ListItem>
                                            <asp:ListItem>Party Tray</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Qty</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtMainTableQty" class="form-control" TextMode="Number" runat="server" />
                                    </div>
                                </div>
                                <div id="pnlHides2" runat="server">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">8 Seater Table</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtEightSeater" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Monobloc Chairs w/ Cover</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtMonoblock" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Kiddie Tables and Chairs</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtKiddieTables" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Buffet Tables</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtBuffetTables" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Utensils</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtUtensils" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Roll Top</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtRollTop" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Chafing Dish</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtChafingDish" class="form-control" runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div id="pnlHides3" class="col-lg-4" runat="server">
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Flowers</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtFlowers" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Head Waiter</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtHeadWaiter" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Purified Water & Ice</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtWaterIce" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">8 Seater Round</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtEightSeaterRound" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Napkin (Table Napkin)</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtNapkin" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Chair Covers</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtChairCover" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Buffet (Direct)</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtBuffetDir" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Buffet Skirting</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtBuffetSkir" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-4">Buffet Crumple</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtBuffetCrump" class="form-control" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div id="pnlHides4" runat="server">
                                <div class="col-lg-12">
                                    <div class="panel panel-midnightblue">
                                        <div class="panel-heading">
                                            Linens
                                        </div>
                                        <div class="panel-body">
                                            <div id="pnlStockError" runat="server" visible="false">
                                                <div class="alert alert-danger">
                                                    <b>Select a stock to add</b>
                                                </div>
                                            </div>
                                            <div id="pnlStockExist" runat="server" visible="false">
                                                <div class="alert alert-danger">
                                                    <b>Stock already added</b>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="control-label col-lg-3">Stock Type</label>
                                                    <div class="col-lg-6">
                                                        <asp:DropDownList ID="ddlStockType" class="form-control"
                                                            runat="server" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-lg-3">Stock Name</label>
                                                    <div class="col-lg-5">
                                                        <asp:TextBox ID="txtStockName" class="autosuggest form-control" runat="server" />
                                                    </div>
                                                    <div class="col-lg-2">
                                                        <asp:LinkButton ID="btnStock" runat="server" OnClick="btnStock_OnClick" CssClass="btn btn-success"> 
                                                            <i class="fa fa-refresh"></i></asp:LinkButton>
                                                    </div>
                                                    <asp:HiddenField runat="server" Value="0" ID="hfName2" />
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-lg-3">Quantity</label>
                                                    <div class="col-lg-3">
                                                        <asp:TextBox ID="txtLinenQty" class="form-control"
                                                            TextMode="Number" runat="server" />
                                                    </div>
                                                    <span style="font-size: small;">Note: Always update booking after adding/deleting linen items</span>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-lg-3"></label>
                                                    <div class="col-lg-6">
                                                        <asp:Button ID="btnAddLinen" class="btn btn-success" runat="server" Text="Add Linen"
                                                            OnClick="btnAddLinen_OnClick" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-6">
                                                <div class="form-group">
                                                    <label class="control-label col-lg-4">Available Quantity</label>
                                                    <div class="col-lg-3">
                                                        <asp:TextBox ID="txtQty" class="form-control"
                                                            runat="server" disabled />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="control-label col-lg-4">Stock Description</label>
                                                    <div class="col-lg-6">
                                                        <asp:TextBox ID="txtStockDesc" class="form-control" Style="max-width: 100%"
                                                            TextMode="Multiline" runat="server" disabled />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-lg-12">
                                                <hr />
                                            </div>
                                            <table class="table table-striped table-hover">
                                                <thead>
                                                    <th>Stock Type</th>
                                                    <th>Stock Name</th>
                                                    <th>Quantity</th>
                                                    <th>Description</th>
                                                    <th>Date Added</th>
                                                </thead>
                                                <tbody>
                                                    <asp:ListView ID="lvLinen" runat="server"
                                                        OnPagePropertiesChanging="lvLinen_OnPagePropertiesChanging"
                                                        OnDataBound="lvLinen_OnDataBound"
                                                        OnItemCommand="lvLinen_OnItemCommand">
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td><%# Eval("StockTypeName") %></td>
                                                                <asp:Literal ID="ltBLID" runat="server" Text='<%# Eval("BookingLinenID") %>' Visible="false" />
                                                                <asp:Literal ID="ltStockID" runat="server" Text='<%# Eval("StockID") %>' Visible="false" />
                                                                <asp:Literal ID="ltQty" runat="server" Text='<%# Eval("Qty") %>' Visible="false" />
                                                                <td><%# Eval("StockName") %></td>
                                                                <td><%# Eval("Qty") %></td>
                                                                <td><%# Eval("StockDescription") %></td>
                                                                <td><%# Eval("DateAdded", "{0: MMMM d, yyyy}") %></td>
                                                                <td>
                                                                    <asp:Button ID="btnRemoveLinen" CommandName="delitem"
                                                                        class="btn btn-sm btn-danger" runat="server" Text='Remove Linen'
                                                                        OnSubmitBehavior="false"
                                                                        OnClientClick='return confirm("Are you sure?");' formnovalidate />
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
                                            <center>
                                                <asp:DataPager id="dpLinen" runat="server" pageSize="5" PagedControlID="lvLinen">
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
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Stylist</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtStylist" class="form-control"
                                                runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Host</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtHost" class="form-control"
                                                runat="server" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Planner</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtPlanner" class="form-control"
                                                runat="server" />
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-3">Media</label>
                                        <div class="col-lg-7">
                                            <asp:TextBox ID="txtMedia" class="form-control"
                                                runat="server" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <div class="pull-left">
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Status</label>
                                        <div class="col-lg-8">
                                            <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                                <asp:ListItem>Pending</asp:ListItem>
                                                <asp:ListItem>Paid</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Basic Charges</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtBasicFee" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Misc Fees</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtMiscFee" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Other Charges</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtOtherFee" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Total</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtTotal" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Downpayment</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtDP" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="control-label col-lg-4">Balance</label>
                                        <div class="col-lg-8">
                                            <div class="input-group">
                                                <span class="input-group-addon">₱</span>
                                                <asp:TextBox ID="txtBalance" class="form-control" runat="server"
                                                    TextMode="number" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-4">
                                    <div class="pull-right">
                                        <asp:Button ID="btnUpdate" runat="server" Visible="true" class="btn btn-success pull-right" Text="Update Booking"
                                            OnClientClick='return confirm("Are you sure?");' OnClick="btnUpdate_OnClick" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>

