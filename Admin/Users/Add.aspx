<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="Add.aspx.cs" Inherits="Admin_Users_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-plus"></i> Add Users
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    User Details
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">First Name</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtFN" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Last Name</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtLN" class="form-control" runat="server" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Username</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtUName" runat="server"
                                    class="form-control" />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Password</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtPassword" runat="server" class="form-control" TextMode="Password" MaxLength="20" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Re-type Password</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtRetypePassword" runat="server" class="form-control"
                                             TextMode="Password"/>
                                <asp:CompareValidator ID="CompareValidator1" runat="server"
                                                      ControlToCompare="txtPassword" ControlToValidate="txtRetypePassword"
                                                      Display="Dynamic"
                                                      ErrorMessage="Passwords don't match" ForeColor="Red" Font-Bold="True">
                                </asp:CompareValidator>
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
                        <div class="form-group">
                            <label class="control-label col-lg-3">User Type</label>
                            <div class="col-lg-6">
                                <asp:DropDownList ID="ddlType" class="form-control" runat="server">
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel-footer">
                    <div class="pull-right">
                        <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Submit" OnClick="btnSubmit_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

