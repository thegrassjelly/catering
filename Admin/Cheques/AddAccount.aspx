<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="AddAccount.aspx.cs" Inherits="Admin_Cheques_AddAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-plus"></i> Add Account
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Account Details
                </div>
                <div class="panel-body">
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Bank Name</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtBank" class="form-control" runat="server"  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Branch</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtBranch" class="form-control" runat="server"  />
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="form-group">
                            <label class="control-label col-lg-3">Account Number</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtAccNo" class="form-control" runat="server"
                                    TextMode="number" required />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-lg-3">Account Name</label>
                            <div class="col-lg-6">
                                <asp:TextBox ID="txtAccName" class="form-control" runat="server" required />
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
                        <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Submit" OnClick="btnSubmit_OnClick" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

