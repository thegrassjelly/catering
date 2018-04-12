<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="AddType.aspx.cs" Inherits="Admin_Inventory_AddType" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <i class="fa fa-plus"></i> Add Stock Type
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <div class="col-lg-12">
            <div class="panel panel-midnightblue">
                <div class="panel-heading">
                    Membership Details
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="control-label col-lg-3">Stock Type</label>
                        <div class="col-lg-6">
                            <asp:TextBox ID="txtStockType" class="form-control" runat="server" required />
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

