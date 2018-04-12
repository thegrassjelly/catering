<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="ViewType.aspx.cs" Inherits="Admin_Inventory_ViewType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-list"></i> Stock Types List
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
                                <div class="col-lg-1">
                                    <div class="input-group">
                                        <asp:DropDownList ID="ddlStatus" runat="server" class="form-control"
                                                          AutoPostBack="True" OnSelectedIndexChanged="ddlStatus_OnSelectedIndexChanged">
                                            <asp:ListItem Text="Active" Value="Active" />
                                            <asp:ListItem Text="Inactive" Value="Inactive" />
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                            <table class="table table-striped table-hover">
                                <thead>
                                    <th>#</th>
                                    <th>Stock Type</th>
                                    <th>Status</th>
                                    <th>Date Added</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvStockTypes" runat="server"
                                        OnPagePropertiesChanging="lvStockTypes_OnPagePropertiesChanging"
                                        OnDataBound="lvStockTypes_OnDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("StockTypeID") %></td>
                                                <td><%# Eval("StockTypeName") %></td>
                                                <td>
                                                    <span class='<%# Eval("Status").ToString() == "Inactive" ? "label label-danger" : "label label-success"%>'>
                                                        <%# Eval("Status") %>
                                                    </span>
                                                </td>
                                                <td><%# Eval("DateAdded", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='UpdateStockType.aspx?ID=<%# Eval("StockTypeID") %>'>
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
                                <asp:DataPager id="dpStockType" runat="server" pageSize="10" PagedControlID="lvStockTypes">
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

