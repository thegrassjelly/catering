<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/site.master" AutoEventWireup="true" CodeFile="UpdateInventory.aspx.cs" Inherits="Admin_Inventory_UpdateInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<i class="fa fa-plus"></i> Update Stocks
    
<script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery.min.js") %>'></script>
<script type='text/javascript' src='<%= Page.ResolveUrl("~/js/newjs/jquery-ui.min.js") %>'></script>

<script type="text/javascript">
    $(document).ready(function () {
        SearchText();
    });
    // if you use jQuery, you can load them when dom is read.
    $(document).ready(function () {
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_initializeRequest(InitializeRequest);
        prm.add_endRequest(EndRequest);

    });

    function InitializeRequest(sender, args) {
    }

    function EndRequest(sender, args) {
        // after update occur on UpdatePanel re-init the Autocomplete
        SearchText();
    }

    function SearchText() {
        $(".autosuggest").autocomplete({
            source: function (request, response) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "UpdateInventory.aspx/GetStocks",
                    data: JSON.stringify({
                        stockname: document.getElementById('<%=txtStockName.ClientID%>').value,
                        stocktype: document.getElementById('<%=ddlStockType.ClientID%>').value
                    }),
                    dataType: "json",
                    success: function (data) {
                        response($.map(data.d, function (item) {
                            return {
                                label: item.split('/vn/')[0],
                                val: item.split('/vn/')[1]
                            }
                        }))
                    },
                    error: function (result) {
                        //alert("Error");
                    }
                });
            },
            select: function (e, i) {
                $("#<%=hfName.ClientID %>").val(i.item.val);
            },
            minLength: 2
        });
    }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="body" Runat="Server">
    <form class="form-horizontal" runat="server">
        <asp:ScriptManager runat="server" />
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-6">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Stock Details
                        </div>
                        <div class="panel-body">
                            <div id="pnlStockError" runat="server" visible="false">
                                <div class="alert alert-danger">
                                    <b>Select a stock to update</b>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Stock Type</label>
                                <div class="col-lg-6">
                                    <asp:DropDownList ID="ddlStockType" class="form-control"
                                                      runat="server" />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Stock Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtStockName" class="autosuggest form-control" runat="server" />
                                </div>
                                <div class="col-lg-2">
                                    <asp:LinkButton ID="btnStock" runat="server" OnClick="btnStock_OnClick" CssClass="btn btn-success"> 
                                        <i class="fa fa-refresh"></i></asp:LinkButton>
                                </div>
                                <asp:HiddenField runat="server" Value="0" ID="hfName" />
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Stock Description</label>
                                <div class="col-lg-6">
                                    <asp:TextBox ID="txtStockDesc" class="form-control"
                                                 TextMode="Multiline" runat="server" disabled />
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-lg-3">Available Quantity</label>
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtQty" class="form-control"
                                                 runat="server" disabled />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <div class="col-lg-6">
                    <div class="panel panel-midnightblue">
                        <div class="panel-heading">
                            Update Stock Inventory
                        </div>
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="control-label col-lg-3">Quantity to Add</label>
                                <div class="col-lg-2">
                                    <asp:TextBox ID="txtQtyAdd" class="form-control"
                                        Text="0"
                                        TextMode="Number" runat="server" />
                                </div>
                            </div>
                        </div>
                        <div class="panel-footer">
                            <div class="pull-right">
                                <asp:Button ID="btnBack" class="btn btn-primary" runat="server" Text="Back" OnClick="btnBack_OnClick" />
                                <asp:Button ID="btnSubmit" class="btn btn-success" runat="server" Text="Add" OnClick="btnSubmit_OnClick" />
                            </div>
                        </div>
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</asp:Content>

