<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Admin_Cheques_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-list"></i> Supplier Payments
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
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
                                                 AutoPostback="True" OnTextChanged="txtDateA_OnTextChanged"/>
                                </div>
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtDateB" class="form-control" TextMode="Date"
                                                 AutoPostback="True" OnTextChanged="txtDateB_OnTextChanged" runat="server" />
                                </div>
                                <div class="col-lg-1">
                                            <asp:Button ID="btnReport" runat="server" Visible="true" class="btn btn-primary" Text="Print Report"
                                                OnClick="btnReport_Click" />
                                </div>
                                <div class="col-lg-7">
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
                                    <th>Supplier Name</th>
                                    <th>Bank</th>
                                    <th>Check #</th>
                                    <th>Amount</th>
                                    <th>Check Date</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvCheques" runat="server"
                                        OnPagePropertiesChanging="lvCheques_OnPagePropertiesChanging"
                                        OnDataBound="lvCheques_OnDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("PayableTo") %></td>
                                                <td><%# Eval("Bank") %></td>
                                                <td><%# Eval("CheckNo") %></td>
                                                <td>₱ <%# Eval("CheckAmount", "{0: #,###.00}") %></td>
                                                <td><%# Eval("CheckDate", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateCheque.aspx?ID=<%# Eval("ChequeID") %>'>
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
                                    <label class="control-label col-lg-5">Total Amount</label>
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
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>

