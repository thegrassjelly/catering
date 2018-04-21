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
                                    <label class="control-label col-lg-3">Account Name</label>
                                    <div class="col-lg-6">
                                        <asp:DropDownList ID="ddlAccName" class="form-control" runat="server"
                                            AutoPostback="True" OnSelectedIndexChanged="ddlAccName_OnSelectedIndexChanged" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Account Number</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtAccNo" class="form-control" runat="server" disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Bank</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtBank" class="form-control" runat="server" disabled />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-lg-3">Branch</label>
                                    <div class="col-lg-6">
                                        <asp:TextBox ID="txtBranch" class="form-control" runat="server" disabled />
                                    </div>
                                </div>
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <div class="col-lg-6">
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
        </div>
    </form>
</asp:Content>

