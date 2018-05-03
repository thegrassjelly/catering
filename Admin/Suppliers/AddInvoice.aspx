<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="AddInvoice.aspx.cs" Inherits="Admin_Suppliers_AddInvoice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-plus"></i> Add Invoice

    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
    <script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

    <script type="text/javascript">
        $(document).ready(function () {
            SearchSupplier();
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
            SearchSupplier();
        }

        function SearchSupplier() {
            $("#<%=txtName.ClientID %>").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "AddInvoice.aspx/GetSupplier",
                        data: "{'prefixText':'" + request.term + "'}",
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
                            alert("Error");
                        }
                    });
                },
                select: function (e, i) {
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
                            Supplier Details
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="control-label col-lg-3">Search Supplier</label>
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
                                <label class="control-label col-lg-3">Supplier Name</label>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtSupplierName" class="form-control" runat="server" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Contact No.</label>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtContactNo" class="form-control"
                                        TextMode="Number" runat="server" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Address</label>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtAddress" runat="server"
                                        TextMode="Multiline" Style="max-width: 100%" class="form-control" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Contact Person</label>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtContactPer" runat="server" class="form-control" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Status</label>
                                <div class="col-lg-6">
                                    <asp:Textbox ID="txtStatus" class="form-control" runat="server" disabled />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Add Invoice
                        </div>
                        <div class="panel-body">
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Invoice #</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtInvoiceNo" class="form-control"
                                            TextMode="Number" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Invoice Date</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtInvoiceDate" class="form-control"
                                            TextMode="date" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Description</label>
                                    <div class="col-lg-7">
                                        <asp:TextBox ID="txtDesc" class="form-control"
                                            TextMode="multiline" runat="server" style="max-width: 100%"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3"></label>
                                    <div class="col-lg-6">
                                        <asp:Button ID="btnAddInvoice" class="btn btn-success" runat="server" 
                                            Text="Add Invoice"
                                            OnClick="btnAddInvoice_Click" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Invoice Amount</label>
                                    <div class="col-lg-7">
                                        <div class="input-group">
                                            <span class="input-group-addon">₱</span>
                                            <asp:TextBox ID="txtInvoiceAmnt" class="form-control" runat="server"
                                                Text="0" TextMode="number" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Status</label>
                                    <div class="col-lg-7">
                                        <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                            <asp:ListItem>Active</asp:ListItem>
                                            <asp:ListItem>Inactive</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <hr />
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>Invoice #</th>
                                    <th>Invoice Date</th>
                                    <th>Amount</th>
                                    <th>Description</th>
                                    <th>Status</th>
                                    <th>Date Added</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvInvoice" runat="server"
                                        OnPagePropertiesChanging="lvInvoice_PagePropertiesChanging"
                                        OnDataBound="lvInvoice_DataBound"
                                        OnItemCommand="lvInvoice_ItemCommand">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("InvoiceNumber") %></td>
                                                <asp:Literal ID="ltInvoiceID" runat="server" Text='<%# Eval("InvoiceID") %>' Visible="false" />
                                                <td><%# Eval("InvoiceDate", "{0: MMMM d, yyyy}") %></td>
                                                <td>₱ <%# Eval("Amount", "{0: #,###.00}") %></td>
                                                <td><%# Eval("Description") %></td>
                                                <td>
                                                    <span class='<%# Eval("Status").ToString() == "Inactive" ? "label label-danger" : "label label-success"%>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td><%# Eval("DateAdded", "{0: MMMM d, yyyy}") %></td>
                                                <td>
                                                    <asp:Button ID="btnRemoveInvoice" CommandName="delitem"
                                                        class="btn btn-sm btn-danger" runat="server" Text='Remove Invoice'
                                                        OnSubmitBehavior="false" formnovalidate />
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
                                                <asp:DataPager id="dpInvoice" runat="server" pageSize="5" PagedControlID="lvInvoice">
                                                    <Fields>
                                                        <asp:NumericPagerField Buttontype="Button"
                                                                               NumericButtonCssClass="btn btn-default"
                                                                               CurrentPageLabelCssClass="btn btn-success"
                                                                               NextPreviousButtonCssClass ="btn btn-default" 
                                                                               ButtonCount="10" />
                                                    </Fields>
                                                </asp:DataPager>
                                            </center>
                            <div class="col-lg-12">
                                <hr />
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Bank</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtBank" class="form-control" runat="server" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Check Number</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtCheckNo" class="form-control" runat="server"
                                            TextMode="number" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Payable To</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtPayable" class="form-control" runat="server" />
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Check Amount</label>
                                    <div class="col-lg-6">
                                        <div class="input-group">
                                            <span class="input-group-addon">₱</span>
                                            <asp:TextBox ID="txtCheckAmnt" class="form-control" runat="server"
                                                TextMode="number" />
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Check Date</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtDate" class="form-control"
                                            TextMode="Date" runat="server" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <div class="pull-right">
                                <asp:Button ID="btnSubmit" runat="server" Visible="true" class="btn btn-success pull-right" Text="Submit Invoice"
                                    OnClientClick='return confirm("Are you sure?");' OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>

