<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="ViewClients.aspx.cs" Inherits="Admin_Booking_ViewClients" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <i class="fa fa-list"></i> Clients List
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
                                <div class="col-lg-12">
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
                                    <th>Client Name</th>
                                    <th>Contact No.</th>
                                    <th>Email Address</th>
                                    <th>Date Added</th>
                                    <th></th>
                                </thead>
                                <tbody>
                                    <asp:ListView ID="lvUsers" runat="server"
                                        OnPagePropertiesChanging="lvUsers_OnPagePropertiesChanging"
                                        OnDataBound="lvUsers_OnDataBound">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# Eval("ContactFirstName") %>, <%# Eval("ContactLastName") %> </td>
                                                <td><%# Eval("ContactNo") %></td>
                                                <td><%# Eval("EmailAddress") %></td>
                                                <td><%# Eval("DateAdded", "{0: dddd, MMMM d, yyyy}") %></td>
                                                <td>
                                                    <a href='ClientDetails.aspx?ID=<%# Eval("ClientID") %>'>
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
                                        <asp:DataPager id="dpUsers" runat="server" pageSize="10" PagedControlID="lvUsers">
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

