<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Admin_Inventory_View" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <i class="fa fa-list"></i>Users List
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
                                        <asp:DropDownList ID="ddlStatus" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_OnSelectedIndexChanged">
                                            <asp:ListItem Text="Active" Value="Active" />
                                            <asp:ListItem Text="Inactive" Value="Inactive" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlType" runat="server" class="form-control"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddlType_OnSelectedIndexChanged" />
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
                                    <th>#</th>
                                    <th>Stock Type</th>
                                    <th>Stock Name</th>
                                    <th>Description</th>
                                    <th>Available Qty</th>
                                    <th>Status</th>
                                    <th>Date Modified</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvStocks" runat="server"
                                        OnPagePropertiesChanging="lvStocks_OnPagePropertiesChanging"
                                        OnDataBound="lvStocks_OnDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("StockID") %></td>
                                                <td><%# Eval("StockTypeName") %></td>
                                                <td><%# Eval("StockName") %></td>
                                                <td><%# Eval("StockDescription") %></td>
                                                <td><%# Eval("Qty") %></td>
                                                <td>
                                                    <span class='<%# Eval("Status").ToString() == "Inactive" ? "label label-danger" : "label label-success"%>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td><%# Eval("DateModified", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateStocks.aspx?ID=<%# Eval("StockID") %>'>
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
                            <center>
                                <asp:DataPager id="dpStocks" runat="server" pageSize="10" PagedControlID="lvStocks">
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

