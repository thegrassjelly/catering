<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="UpdateCheque.aspx.cs" Inherits="Admin_Cheques_UpdateCheque" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-edit"></i> Update Cheque
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Account Details
                </div>
                <div class="panel-body">
                    <asp:UpdatePanel runat="server">
                        <ContentTemplate>
                            <div class="col-lg-6">
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Bank</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtBank" class="form-control" runat="server" disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Check Number</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtCheckNo" class="form-control" runat="server"
                                            TextMode="number" required />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Payable To</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtPayable" class="form-control" runat="server" required />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
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
                                    TextMode="Date" runat="server" required />
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
                    Invoices
                </div>
                <div class="panel-body">
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
                </div>
            </div>
        </div>
    </form>
</asp:Content>

