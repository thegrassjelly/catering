<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="UpdateSupplier.aspx.cs" Inherits="Admin_Suppliers_UpdateSupplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-edit"></i> Update Supplier Details
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Supplier Details
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Supplier Name</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtSupplierName" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Contact No.</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtContactNo" class="form-control"
                                    TextMode="Number" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Address</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtAddress" runat="server"
                                    TextMode="Multiline" Style="max-width: 100%" class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Contact Person</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtContactPer" runat="server" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Status</label>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="ddlStatus" class="form-control" runat="server">
                                    <asp:ListItem>Active</asp:ListItem>
                                    <asp:ListItem>Inactive</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="pull-right">
                        <asp:Button ID="btnBack" class="btn btn-primary" runat="server" Text="Back" OnClick="btnBack_OnClick" />
                        <asp:Button ID="btnUpdate" class="btn btn-success" runat="server" Text="Update" OnClick="btnUpdate_OnClick" />
                    </div>
                </div>
            </div>
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Issued Cheques
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDateA" class="form-control" TextMode="Date" runat="server"
                                AutoPostBack="True" OnTextChanged="txtDateA_TextChanged" />
                        </div>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDateB" class="form-control" TextMode="Date"
                                AutoPostBack="True" OnTextChanged="txtDateB_TextChanged" runat="server" />
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <th>Account Name</th>
                            <th>Account #</th>
                            <th>Check #</th>
                            <th>Amount</th>
                            <th>Check Date</th>
                            <th></th>
                        </thead>
                        <tbody>
                            <asp:ListView ID="lvCheques" runat="server"
                                OnPagePropertiesChanging="lvCheques_PagePropertiesChanging"
                                OnDataBound="lvCheques_DataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td><%# Eval("AccountName") %></td>
                                        <td><%# Eval("AccountNo") %></td>
                                        <td><%# Eval("CheckNo") %></td>
                                        <td>₱ <%# Eval("CheckAmount", "{0: #,###.00}") %></td>
                                        <td><%# Eval("CheckDate", "{0: dddd, MMMM d, yyyy}") %></td>
                                        <td>
                                            <a href='../Cheques/UpdateCheque.aspx?ID=<%# Eval("ChequeID") %>'>
                                                <asp:Label runat="server" ToolTip="Show Info"><i class="fa fa-edit"></i></asp:Label></a>
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
                            <label class="control-label col-lg-5">Total Cheque Amount</label>
                            <div class="col-lg-7">
                                <div class="input-group">
                                    <span class="input-group-addon">₱</span>
                                    <asp:TextBox ID="txtTotalCheque" class="form-control" runat="server"
                                        disabled />
                                </div>
                            </div>
                        </div>
                    </div>
                    <center>
                                <asp:DataPager id="dpCheques" runat="server" pageSize="10" PagedControlID="lvCheques">
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
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Supplier Invoice
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDateC" class="form-control" TextMode="Date" runat="server"
                                AutoPostBack="True" OnTextChanged="txtDateC_TextChanged" />
                        </div>
                        <div class="col-lg-2">
                            <asp:TextBox ID="txtDateD" class="form-control" TextMode="Date"
                                AutoPostBack="True" OnTextChanged="txtDateD_TextChanged" runat="server" />
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <th>Invoice #</th>
                            <th>Invoice Date</th>
                            <th>Amount</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Date Added</th>
                        </thead>
                        <tbody>
                            <asp:ListView ID="lvInvoice" runat="server"
                                OnPagePropertiesChanging="lvInvoice_PagePropertiesChanging"
                                OnDataBound="lvInvoice_DataBound">
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
                                                <asp:DataPager id="dpInvoice" runat="server" pageSize="10" PagedControlID="lvInvoice">
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
    </form>
</asp:Content>

